#include-once
#include <_HttpRequest.au3>
#include <Crypt.au3>


Func FB_Login_Ex($EmailOrPhone, $Password, $iRememberCookie = 1, $sPathSaveCookie = Default, $iUserAgent = Default)
	If Not $sPathSaveCookie Or $sPathSaveCookie = Default Then $sPathSaveCookie = @ScriptDir & "\LoginFB.ini"
	If $iUserAgent And $iUserAgent <> Default Then $g___iUserAgent = $iUserAgent
	;--------------------------------------------------------------------------------------------------
	Local $sDataToSend = "email=" & _URIEncode($EmailOrPhone) & "&pass=" & _URIEncode($Password)
	Local $SectionINI = _Crypt_HashData(_Crypt_HashData($sDataToSend, $CALG_MD5), $CALG_MD5)
	Local $EncryptData = IniRead($sPathSaveCookie, $SectionINI, 'EncryptData', '')
	If $iRememberCookie And $EncryptData And ___TimeStampNow() - IniRead($sPathSaveCookie, $SectionINI, 'Timestamp', 0) < 50000 Then
		Local $DecryptData = _Crypt_DecryptData(_Crypt_DecryptData($EncryptData, $Password, $CALG_AES_256), $EmailOrPhone, $CALG_AES_256)
		If @error Then
			IniDelete($sPathSaveCookie, $SectionINI)
			ConsoleWrite(@CRLF & '!_Crypt_DecryptData fail' & @CRLF & '!Re-Login' & @CRLF)
			Return FB_Login_Ex($EmailOrPhone, $Password, 0, $sPathSaveCookie, $iUserAgent)
		EndIf
		Local $aRet = StringSplit(BinaryToString($DecryptData), '±', 2)
		If @error Then
			IniDelete($sPathSaveCookie, $SectionINI)
			ConsoleWrite(@CRLF & '!DecryptData error' & @CRLF & '!Re-Login' & @CRLF)
			Return FB_Login_Ex($EmailOrPhone, $Password, 0, $sPathSaveCookie, $iUserAgent)
		EndIf
		If Not StringInStr(_HttpRequest(2, 'https://m.facebook.com/policies/', '', $aRet[0]), 'logout.php', 0, -1) Then
			IniDelete($sPathSaveCookie, $SectionINI)
			ConsoleWrite(@CRLF & '!cookies fail' & @CRLF & '!Re-Login' & @CRLF)
			Return FB_Login_Ex($EmailOrPhone, $Password, 0, $sPathSaveCookie, $iUserAgent)
		EndIf
	Else
		_HttpRequest(0, 'https://www.facebook.com/')
		Local $Request = _HttpRequest(1, 'https://www.facebook.com/login.php', $sDataToSend)
		Local $sCookie = _GetCookie($Request)
		If @error Or Not $sCookie Then
			FileDelete($sPathSaveCookie)
			Return SetError(1, ConsoleWrite(@CRLF & '!cannot get cookies'), 'cannot get cookies')
		EndIf
		If StringInStr($sCookie, 'reg_fb') Then
			If StringInStr($sCookie, 'checkpoint=', 1, 1) Then Return SetError(-1, ConsoleWrite(@CRLF & '!checkPoint'), 'checkpoint')
			If StringInStr($sCookie, 'sfau=', 1, 1) Then Return SetError(-2, ConsoleWrite(@CRLF & '!incorrect password'), 'incorrect password')
			Return SetError(-3, ConsoleWrite(@CRLF & '!incorrect email_or_phone'), 'incorrect email_or_phone')
		EndIf
		Local $UserID = StringRegExp($sCookie, "c_user=(.*?);", 1)
		If @error Or Not $UserID[0] Then Return SetError(2, ConsoleWrite(@CRLF & '!cannot get UserID'), 'cannot get UserID')
		Local $FB_dtsg = StringRegExp(_HttpRequest(2, 'https://m.facebook.com', '', $sCookie), '\\?"fb_dtsg\\?" value=\\?"(.*?)\\?"', 1)
		If @error Or Not $FB_dtsg[0] Then Return SetError(3, ConsoleWrite(@CRLF & 'cannot get FB_dtsg'), 'cannot get FB_dtsg')
		$EncryptData = _Crypt_EncryptData(_Crypt_EncryptData($sCookie & '±' & $UserID[0] & '±' & $FB_dtsg[0], $EmailOrPhone, $CALG_AES_256), $Password, $CALG_AES_256)
		If @error Then Return SetError(4, ConsoleWrite(@CRLF & '!_Crypt_EncryptData fail'), '_Crypt_EncryptData fail')
		IniWrite($sPathSaveCookie, $SectionINI, 'Timestamp', ___TimeStampNow())
		IniWrite($sPathSaveCookie, $SectionINI, 'EncryptData', $EncryptData)
		Local $aRet[3] = [$sCookie, $UserID[0], $FB_dtsg[0]]
	EndIf
	Return $aRet
EndFunc

Func ___TimeStampNow()
	Local $nYear = @YEAR - (@MON < 3 ? 1 : 0)
	Return (Int(Int($nYear / 100) / 4) - Int($nYear / 100) + @MDAY + Int(365.25 * ($nYear + 4716)) + Int(30.6 * ((@MON < 3 ? @MON + 12 : @MON) + 1)) - 2442110) * 86400 + (@HOUR * 3600 + @MIN * 60 + @SEC)
EndFunc