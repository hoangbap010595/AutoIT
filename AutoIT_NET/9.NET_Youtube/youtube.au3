#include <_HttpRequest.au3>
#include "ImageSearch.au3"
HotKeySet('{Esc}',"_exit")
HotKeySet('{F8}',"_send")
;~ $a = 'comment_text=link%20firm%20click%20here%20http%3A%2F%2Fzo.ee%2F3ytG3&sej=%7B%22clickTrackingParams%22%3A%22CF8Q8FsiEwj2tY7lnPLWAhUEmFgKHXhCCbU%3D%22%2C%22createCommentReplyEndpoint%22%3A%7B%22createReplyParams%22%3A%22Egtra1VicEM2MGJZNCIzejIzZXd6ZG9jeHlnaTNrZGJhY2RwNDMwMmgwZ3V3bGhqbmsyenpoY3dwbHcwM2MwMTBjKgIIADAAUAE%253D%22%7D%7D&csn=-B3jWevCE9K74gLu4qGwBg&session_token=QUFFLUhqbVdqclNqb0lpeHh6cTA2WHBqem4tQzRZbE1qQXxBQ3Jtc0tsMnhlS2E1bmJ0TnkxN25ENllYRFNxaUlpVmJ1Q0p1VlVrVVFUampNdFlVdVJrakJaWEhXbUNqOVBRUWlqc296NDJqYkJOLUc1UnNSUlYtYkhOUmNsQ2JtWnBsZkpGY1pndHVWWk9jdWJsaGs1QmNZMkhseXg1VmJNS1FkLVlvYTVZVEhHQnNvTzVyVEV0NzJNZFN1NnpNMW1ORGc%3D'

;~ $x = _HTMLDecode($a)

;~ MsgBox(0,0,$x)

;~ $x2 = _URIDecode($a)
;~ MsgBox(0,0,$x2)
Func _exit()
	Exit
EndFunc
Func _send()
	Send('http://zo.ee/3ytGG﻿')
EndFunc

ToolTip("Dang thu hien",0,0,"Click")
Local $x = 0,$y = 0
Local $path = @ScriptDir&'\tl.bmp'
Local $enter= 1

While 1
	If $enter = 0 Then
		Send('http://zo.ee/3ytGG﻿')
		$enter = 1
	EndIf
	$search = _ImageSearch($path,1,$x,$y,0)
;~ 	If $search = 1 Then MsgBox(0,0,$x &':'&$y)
	If $search = 1 Then
		MouseClick("left", $x,$y,1)
		$enter = 0
	EndIf
WEnd