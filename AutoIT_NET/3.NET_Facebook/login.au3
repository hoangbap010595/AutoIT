#include <_HttpRequest.au3>
;~ _HttpRequest_SetOption('http://proxy.hcm.fpt.vn:80')

$tk = "0901479784"
$mk = "Thienan@111"
$fb = FB_Login($tk, $mk)
If not IsArray($fb) Then
	MsgBox(16, "", "Đăng nhập thất bại")
	Exit
EndIf
MsgBox(0, "", "FB: " & $fb[0] & @CR & $fb[1] & @CR & $fb[2] & @CR)
;~ $id = FB_post_stt($fb, "Test Facebook WinHttp UDF :D", 2)
;~ MsgBox(0, "", "Post's ID: " & $id)

FB_react($fb, 875382675961724, 3)
FB_cmt($fb, "Test UDF :D", 875382675961724)


;==================FB_Login====================
;  Parameters:   + $Username: Facebook's username
;                + $Password: Facebook's password
;  Return:       - True: Return an array of handle
;                - False:
;                  + @error: 1 -> Wrong username or password
;                  + @error: 2 -> Failed to get FB_dtsg
;==================================================
Func FB_Login($Username, $Password)
	Local $Ret[3], $Post, $Check, $FB_dtsg
	$Post = _HttpRequest(1, "https://www.facebook.com/login.php", "email=" & _URIEncode($Username) & "&pass=" & _URIEncode($Password), _GetCookie(_HttpRequest(1, "https://www.facebook.com/")))
	$Check = StringRegExp($Post, "Set-Cookie: c_user=(.*?);", 3)
	If @error Then Return SetError(1, 0, False)
	$Ret[0] = _GetCookie($Post)
	$Ret[1] = $Check[0]
	$FB_dtsg = StringRegExp(_HttpRequest(2, "https://www.facebook.com/profile.php?id=" & $Ret[1], "", $Ret[0]), '<input type="hidden" name="fb_dtsg" value="(.*?)" autocomplete="off" />', 3)
	If @error then Return SetError(2, 0, False)
	$Ret[2] = $FB_dtsg[0]
	Return $Ret
EndFunc


;==================FB_post_stt====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Content: What to post
;                - $Pri: privacy
;					+ 0: Public
;					+ 1: Friend
;					+ 2: Only me
;                + $ID: Profile id to post, leave false to post on your own profile
;  Return:       - Success: Post's id
;                - False:
;					+ @error = 1: Handle is not an array
;					+ @error = 2: Can't get post's id
;==================================================
Func FB_post_stt($Handle, $Content, $Pri, $ID = False)
	Local $Post_pri[3] = ["300645083384735", "291667064279714", "286958161406148"], $data, $FB_ID = ($ID ? $ID : $Handle[1]), $Post_body, $Get_id
	If not IsArray($Handle) then Return SetError(1, 0, False)
	If $Pri < 0 Or $Pri > 2 or (not IsNumber($Pri)) Then $Pri = 0
	$data = "privacyx=" & ($ID ? "" : $Post_pri[$Pri]) & "&xhpc_targetid=" & $FB_ID &"&xhpc_message=" & _URIEncode($Content) & "&fb_dtsg=" & $Handle[2]
	$Post_body = _HttpRequest(2, "https://www.facebook.com/ajax/updatestatus.php",$data, $Handle[0], "https://www.facebook.com/profile.php?id=" & $Handle[1])
	$Get_id = StringRegExp($Post_body, "top_level_post_id&quot;:&quot;(.*?)&quot;",3)
	If @error then Return SetError(2, 0, True)
	Return $Get_id[0]
EndFunc


;==================FB_cmt====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Content: What to comment
;                + $Post_ID: Post id to comment
;  Return:       - Success: Request's return
;                - False: Handle is not an array
;==================================================
Func FB_cmt($Handle, $Content, $Post_ID)
	Local $data
	If not IsArray($Handle) then Return False
;~ 	$data =  "ft_ent_identifier=" & $Post_ID & "&comment_text=" & _URIEncode($Content) & "&source=1&client_id=1&session_id=1&fb_dtsg=" & $fb[2]
		$data =  "ft_ent_identifier=" & $Post_ID & "&comment_text=" & _URIEncode($Content) & "&source=1&client_id="& $Handle[1]&"&session_id=1&fb_dtsg=" & $Handle[2]
	Return _HttpRequest(1, "https://www.facebook.com/ufi/add/comment/", $data, $Handle[0])
EndFunc


;==================FB_react====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Post_ID: Post id to react
;                - $React: Reaction
;					+ 0: Unlike
;					+ 1: Like
;					+ 2: Love
;					+ 3: Wow
;					+ 4: Haha
;					+ 7: Sad
;					+ 8: Angry
;  Return:       - Success: Request's return
;                - False: Handle is not an array
;==================================================
Func FB_react($Handle, $Post_ID, $React = 1)
	Local $data
	If not IsArray($Handle) Then Return False
	If not (($React >= 0 And $React <= 4) or $React = 7 or $React = 8) Then $React = 1
	$data =  "ft_ent_identifier=" & $Post_ID & "&reaction_type=" & $React & "&client_id=1&session_id=1&source=1&fb_dtsg=" & $Handle[2]
	Return _HttpRequest(1, "https://www.facebook.com/ufi/reaction/", $data, $Handle[0])
EndFunc