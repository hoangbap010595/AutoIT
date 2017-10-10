#include <_HttpRequest.au3>

;~ Func Example($UName, $UPass)
;~ 	$oFB = FB_Login($UName, $UPass)
;~ 	If @error Then
;~ 		MsgBox(16, "", "Đăng nhập thất bại" & @CRLF & "Error code: " & @error)
;~ 		Return False
;~ 	EndIf
;~ 	$Post_ID = FB_Post($oFB, "Facebook WinHttp UDF - FB_Post()", 0)
;~ 	ConsoleWrite("Post's ID: " & $Post_ID & @CRLF)
;~ 	FB_React($oFB, $Post_ID, 2)
;~ 	FB_Comment($oFB, $Post_ID, "Facebook WinHttp UDF - FB_Comment()", 1)

;~ 	$Share_ID = FB_Share($oFB, $Post_ID, "Facebook WinHttp UDF - FB_Share()", 0)
;~ 	ConsoleWrite("Share's ID: " & $Share_ID & @CRLF)
;~ 	FB_React($oFB, $Share_ID, 2)
;~ 	FB_Comment($oFB, $Share_ID, "Facebook WinHttp UDF - FB_Comment()", 1)
;~ 	Return True
;~ EndFunc

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
	$Post = _HttpRequest(1, "https://www.facebook.com/login.php", "email=" & _URIEncode($Username) & "&pass=" & _URIEncode($Password), _GetCookie(_HttpRequest(1, "https://www.facebook.com/", "Facebook")))
	$Check = StringRegExp($Post, "Set-Cookie: c_user=(.*?);", 3)
	If not IsArray($Check) Then Return SetError(1, 0, False)
	$Ret[0] = _GetCookie($Post)
	$Ret[1] = $Check[0]
	$FB_dtsg = StringRegExp(_HttpRequest(2, "https://www.facebook.com/profile.php?id=" & $Ret[1], "", $Ret[0]), '<input type="hidden" name="fb_dtsg" value="(.*?)" autocomplete="off" />', 3)
	If not IsArray($FB_dtsg) Then Return SetError(2, 0, False)
	$Ret[2] = $FB_dtsg[0]
	Return $Ret
EndFunc


;==================FB_Post_stt====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Content: What to post
;                - $Pri: privacy
;					+ 0: Public
;					+ 1: Friend
;					+ 2: Only me
;                + $UID: User's ID to post, leave false to post on your own profile
;  Return:       - Success: Post's id
;                - False:
;					+ @error = 1: Handle is not an array
;					+ @error = 2: Can't get post's id
;==================================================
Func FB_Post($Handle, $Content, $Pri = 0, $UID = False)
	Local $Post_pri[3] = ["300645083384735", "291667064279714", "286958161406148"], $data, $FB_ID = ($UID ? $UID : $Handle[1]), $Post_body, $Get_id
	If not IsArray($Handle) then Return SetError(1, 0, False)
	If $Pri < 0 Or $Pri > 2 or (not IsNumber($Pri)) Then $Pri = 0
	$data = "privacyx=" & ($UID ? "" : $Post_pri[$Pri]) & "&xhpc_targetid=" & $FB_ID &"&xhpc_message=" & _URIEncode($Content) & "&fb_dtsg=" & $Handle[2]
	$Post_body = _HttpRequest(2, "https://www.facebook.com/ajax/updatestatus.php",$data, $Handle[0], "https://www.facebook.com/profile.php?id=" & ($UID ? $UID :$Handle[1]))
	$Get_id = StringRegExp($Post_body, "top_level_post_id&quot;:&quot;(.*?)&quot;",3)
	If @error then Return SetError(2, 0, True)
	Return $Get_id[0]
EndFunc


;==================FB_Share====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Post_ID: Post's ID to share
;                + $Content: What to share
;                - $Pri: privacy
;					+ 0: Public
;					+ 1: Friend
;					+ 2: Only me
;                + $UID: User's ID to post, leave false to post on your own profile
;                - $UID_type: User's ID type
;					+ 1: Friend
;					+ 2: Group
;  Return:       - Success: Post's id
;                - False:
;					+ @error = 1: Handle is not an array
;					+ @error = 2: Can't get post's id
;==================================================
Func FB_Share($Handle, $Post_ID, $Content = "", $Pri = 0, $UID = False, $UID_type = 1)
	Local $Post_pri[3] = ["300645083384735", "291667064279714", "286958161406148"], $URL, $Post_body, $Get_id
	If not IsArray($Handle) then Return SetError(1, 0, False)
	If $Pri < 0 Or $Pri > 2 or (not IsNumber($Pri)) Then $Pri = 0
	$URL = "https://www.facebook.com/share/dialog/submit/?app_id=25554907596"
	If $UID Then
		$URL &=  "&audience_type=" & ($UID_type = 1 ? "friend" : "group")
		$URL &=  "&audience_targets[0]=" & $UID
	Else
		$URL &=  "&audience_type=self"
	EndIf
	$URL &= "&message=" &_URIEncode($Content)
	$URL &= "&post_id=" & $Post_ID
	$URL &= "&privacy=" & ($UID ? "" : $Post_pri[$Pri])
	$URL &= "&share_type=22"
	$URL &=  "&is_forced_reshare_of_post=true"
	$URL &= "&source=1"
	_HttpRequest(1, $URL, "fb_dtsg=" & $Handle[2], $Handle[0])
	$Post_body = _HttpRequest(2, "https://www.facebook.com/profile.php?id=" & ($UID ? $UID :$Handle[1]), "", $Handle[0])
	$Get_id = StringRegExp($Post_body, "top_level_post_id&quot;:&quot;(.*?)&quot;",3)
	If @error then Return SetError(2, 0, True)
	Return $Get_id[0]
EndFunc


;==================FB_Comment====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Content: What to comment
;                + $Post_ID: Post's id to comment
;                + $Sticker: Sticker ID, from 1 to 32, find out yourself
;  Return:       - Success: Request's return
;                - False: Handle is not an array
;==================================================
Func FB_Comment($Handle, $Post_ID, $Content, $Sticker = 0)
	Local $data, $Stickers[33] = ["", "126361874215276", "126362187548578", "126361967548600", "126362100881920", "126362137548583", "126361920881938", _
	"126362064215257", "126361974215266", "126361910881939", "126361987548598", "126361994215264", "126362007548596", "126362027548594", "126362044215259", _
	"126362074215256", "126362080881922", "126362087548588", "126362107548586", "126362117548585", "126362124215251", "126362130881917", "126362160881914", _
	"126362167548580", "126362180881912", "126362197548577", "126362207548576", "126361900881940", "126361884215275", "126361957548601", "126361890881941", _
	"126362034215260", "126362230881907"]
	If $Sticker < 0 Or $Sticker > 32 or (not IsNumber($Sticker)) Then $Sticker = 0
	If not IsArray($Handle) then Return False
	$data =  "ft_ent_identifier=" & $Post_ID & "&comment_text=" & _URIEncode($Content) & "&attached_sticker_fbid=" & $Stickers[$Sticker] & "&source=1&client_id=1&session_id=1&fb_dtsg=" & $Handle[2]
	Return _HttpRequest(1, "https://www.facebook.com/ufi/add/comment/", $data, $Handle[0])
EndFunc


;==================FB_React====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $Post_ID: Post's id to react
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
Func FB_React($Handle, $Post_ID, $React = 1)
	Local $data
	If not IsArray($Handle) Then Return False
	If not (($React >= 0 And $React <= 4) or $React = 7 or $React = 8) Then $React = 1
	$data =  "ft_ent_identifier=" & $Post_ID & "&reaction_type=" & $React & "&client_id=1&session_id=1&source=1&fb_dtsg=" & $Handle[2]
	Return _HttpRequest(1, "https://www.facebook.com/ufi/reaction/", $data, $Handle[0])
EndFunc

;==================FB_Poke====================
;  Parameters:   + $Handle: Handle returned from FB_login()
;                + $UID: User's ID to poke
;  Return:       - Success: Request's return
;                - False: Handle is not an array
;==================================================
Func FB_Poke($Handle, $UID)
	Local $data
	If not IsArray($Handle) Then Return False
	$data =  "poke_target=" & $UID & "&fb_dtsg=" & $Handle[2]
	Return _HttpRequest(1, "https://www.facebook.com/pokes/dialog", $data, $Handle[0])
EndFunc