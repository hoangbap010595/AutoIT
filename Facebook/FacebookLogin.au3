#include-once
#include <Crypt.au3>
#include <_HttpRequest.au3>


Func FB_Login_Ex($Username, $Password, $iRememberCookie = 1, $sPathSaveCookie = @ScriptDir & "\LoginFB.ini")
	If Not FileExists($sPathSaveCookie) Then FileOpen($sPathSaveCookie, 2 + 8 + 32)
	Local $sCookie, $FB_dtsg, $UserID
	$g_SectionINI = ___MyB64Encode(_Crypt_HashData($Username & $Password, $CALG_MD5))
	If $iRememberCookie Then
		$sCookie = IniRead($sPathSaveCookie, $g_SectionINI, 'Cookie', '')
		$FB_dtsg = IniRead($sPathSaveCookie, $g_SectionINI, 'DTSG', '')
		If Not $sCookie Or Not $FB_dtsg Or ___TimeStampNow() - IniRead($sPathSaveCookie, $g_SectionINI, 'Timestamp', 0) > 2000000 Then
			Return FB_Login_Ex($Username, $Password, 0, $sPathSaveCookie)
		EndIf
		Local $encrt_UserID = StringRegExp($sCookie, "c_user=(.*?);", 1)[0]
		$UserID = BinaryToString(_Crypt_DecryptData(___MyB64Decode($encrt_UserID), $Password, $CALG_AES_256))
		$sCookie = StringReplace($sCookie, 'c_user=' & $encrt_UserID, 'c_user=' & $UserID, 1, 1)
		Local $aRet = [$sCookie, $UserID, $FB_dtsg]
	Else
		Local $Request = _HttpRequest(1, "https://m.facebook.com/login.php", "email=" & _URIEncode($Username) & "&pass=" & _URIEncode($Password))
		$sCookie = _GetCookie($Request)
		If @error Then Return SetError(1, 0, False)
		Local $UserID = StringRegExp($sCookie, "c_user=(.*?);", 1)
		If @error Then Return SetError(2, 0, False)
		$FB_dtsg = StringRegExp(_HttpRequest(2, 'https://m.facebook.com/home.php', '', $sCookie), '\Q"fb_dtsg" value="\E(.*?)\"', 1)
		If @error Or $FB_dtsg[0] = '' Then Return SetError(3, 0, False)
		Local $aRet[3] = [$sCookie, $UserID[0], $FB_dtsg[0]]
		Local $encrt_UserID = ___MyB64Encode(_Crypt_EncryptData($UserID[0], $Password, $CALG_AES_256))
		$sCookie = StringReplace($sCookie, 'c_user=' & $UserID[0], 'c_user=' & $encrt_UserID, 1, 1)
		IniWrite($sPathSaveCookie, $g_SectionINI, "Cookie", $sCookie)
		IniWrite($sPathSaveCookie, $g_SectionINI, "DTSG", $aRet[2])
		IniWrite($sPathSaveCookie, $g_SectionINI, "Timestamp", ___TimeStampNow())
	EndIf
	Return $aRet
EndFunc

Func ___MyB64Encode($binaryData, $iLinebreak = 0)
	Local $aChr = StringSplit('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-', '', 2)
	Local $lenData = StringLen($binaryData) - 2, $iOdd = Mod($lenData, 3), $spDec = '', $base64Data = '', $iCounter = 0
	For $i = 3 To $lenData - $iOdd Step 3
		$spDec = Dec(StringMid($binaryData, $i, 3))
		$base64Data &= $aChr[$spDec / 64] & $aChr[Mod($spDec, 64)]
	Next
	If $iOdd Then
		$spDec = BitShift(Dec(StringMid($binaryData, $i, 3)), -8 / $iOdd)
		$base64Data &= $aChr[$spDec / 64] & ($iOdd = 2 ? $aChr[Mod($spDec, 64)] & '==' : '=')
	EndIf
	If $iLinebreak Then $base64Data = StringRegExpReplace($base64Data, '(.{' & $iLinebreak & '})', '${1}' & @LF) & @LF
	Return $base64Data
EndFunc

Func ___MyB64Decode($base64Data)
	$base64Data = StringStripWS($base64Data, 8)
	Local $sChr64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-'
	Local $aData = StringSplit($base64Data, ''), $binaryData = '0x', $iOdd = 0 * StringReplace($base64Data, '=', '') + @extended
	For $i = 1 To $aData[0] - $iOdd * 2 Step 2
		$binaryData &= Hex((StringInStr($sChr64, $aData[$i], 1, 1) - 1) * 64 + StringInStr($sChr64, $aData[$i + 1], 1, 1) - 1, 3)
	Next
	If $iOdd Then $binaryData &= Hex(BitShift((StringInStr($sChr64, $aData[$i], 1, 1) - 1) * 64 + ($iOdd - 1) * (StringInStr($sChr64, $aData[$i + 1], 1, 1) - 1), 8 / $iOdd), $iOdd)
	Return $binaryData
EndFunc

Func ___TimeStampNow()
	Local $nYear = @YEAR - (@MON < 3 ? 1 : 0)
	Return (Int(Int($nYear / 100) / 4) - Int($nYear / 100) + @MDAY + Int(365.25 * ($nYear + 4716)) + Int(30.6 * ((@MON < 3 ? @MON + 12 : @MON) + 1)) - 2442110) * 86400 + (@HOUR * 3600 + @MIN * 60 + @SEC)
EndFunc