#include <Facebook.au3>
#include <FacebookLogin.au3>

Local $a = FB_Login_Ex("0901479784", "Thienan@111")
Local $b = FB_Login("0901479784", "Thienan@111")

MsgBox(0,0,$a)
MsgBox(0,0,$b)


Func FB_TimeLineURLToUserID($Handle, $TimelineURL)
        If Not IsArray($Handle) Then Return SetError(1, 0, False)
        $TimelineURL = StringMid($TimelineURL, StringInStr($TimelineURL, '/', 1, -1) + 1)
        Local $Request = _HttpRequest(2, 'https://m.facebook.com/' & $TimelineURL, '', $Handle[0])
        If @error Or StringInStr($Request, 'href="/bugnub/?source=ErrorPage"', 0, 1) Then Return SetError(1, '', 'Tài khoản không tồn tại')
        Local $aRegexp, $aResult[2]
        $aRegexp = StringRegExp($Request, '<title>(.*?)</title>', 1)
        If @error Then Return SetError(2, '', 'Tài khoản không tồn tại')
        $aResult[0] = $aRegexp[0]
        $aRegexp = StringRegExp($Request, 'confirm/\?bid=(\d+)', 1)
        If @error Then Return SetError(2, '', 'Tài khoản không tồn tại')
        $aResult[1] = $aRegexp[0]
        Return $aResult
    EndFunc


    Func FB_Friend_List($Handle, $iStartSearch = 0, $iEndSearch = -1)
        If $Handle = False Or Not IsArray($Handle) Then Return SetError(1, '', False)
        If $iEndSearch = -1 Then $iEndSearch = 999999999
        If $iStartSearch > $iEndSearch Then Return SetError(2, '', 0)
        Local $aRet[0], $Request, $aListFr, $uBound, $iCount = 0, $iError = 0
        Local $TotalFr = StringRegExp(_HttpRequest(2, 'https://m.facebook.com/friends/center/mbasic/?fb_ref=tn&sr=1&ref_component=mbasic_home_header&ref_page=MFriendsCenterFriendsController', '', $Handle[0]), '\Q/friends/?mff_nav=1">\E.*?\((\d+?)\)\<\/a\>', 1)
        $TotalFr = (@error ? 0 : Int(StringRegExpReplace($TotalFr[0], '[\,\.]', '', 1)))
        If $TotalFr <> 0 And $iEndSearch = 999999999 Then $iEndSearch = Ceiling($TotalFr / 10)
        For $i = $iStartSearch To $iEndSearch
            $Request = _HttpRequest(2, 'https://m.facebook.com/friends/center/friends/?ppk=' & $i & '&bph=' & $i, '', $Handle[0])
            $aListFr = StringRegExp($Request, '\Qhref="/friends/hovercard/mbasic/?uid=\E(\d+)&amp;.*?last_acted">(.*?)\Q</a>\E', 3)
            If Not @error Then
                $uBound = UBound($aListFr)
                ReDim $aRet[$iCount + $uBound]
                For $k = 0 To $uBound - 1
                    $aRet[$k + $iCount] = $aListFr[$k]
                Next
                $iCount += $uBound
                ToolTip('Loading...' & Round(100 * $i / $iEndSearch, 1) & '%', 0, 0, 'Status', 1)
            EndIf
            If Not StringInStr($Request, '/friends/?ppk=' & ($i + 1) & '&amp;tid=u_0_0&amp;bph=' & ($i + 1) & '#friends', 1, 1) Then ExitLoop
        Next
        ToolTip('')
        ToolTip('Loading...100%', 0, 0, 'Status', 1)
        Return $aRet
    EndFunc


    Func FB_Friend_Add($Handle, $ID_User)
        If Not IsArray($Handle) Then Return SetError(1, 0, False)
        _HttpRequest(0, 'https://www.facebook.com/ajax/add_friend/action.php', 'to_friend=' & $ID_User & '&action=add_friend&how_found=hovercard&ref_param=hc_ufi&fb_dtsg=' & $Handle[2], $Handle[0])
    EndFunc