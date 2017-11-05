
#include <_HttpRequest.au3>

_HttpRequest_SetOption('http://proxy.hcm.fpt.vn:80')
$filePath = @ScriptDir&'/code.html'

;~ $data = _HttpRequest(1,'http://chiasenhac.vn/login.php')
;~ MsgBox(0,0,$data)

$dataLogin = 'username=huan1hoang2&password=123456&autologin=on&redirect=&login=%C4%90%C4%83ng+nh%E1%BA%ADp'

$data = _HttpRequest(1,'http://chiasenhac.vn/login.php',$dataLogin)
MsgBox(0,0,$data)
$cookie = _GetCookie($data)
MsgBox(0,0,$cookie)
$location = StringRegExp($data,"Location: (.*)",1)[0]
MsgBox(0,0,$location)

$data = _HttpRequest(1,$location,'',$cookie)
MsgBox(0,0,$data)
$location = StringRegExp($data,"Location: (.*)",1)[0]
MsgBox(0,0,$location)

$data = _HttpRequest(1,$location,'',$cookie)
MsgBox(0,0,$data)

$cookieFinal = _GetCookie($data)
MsgBox(0,0,$cookieFinal)

Func _OpenFile($data)
;~ 	MsgBox(0,"$data",$data)
	FileDelete($filePath)
	FileWrite($filePath,$data)
	ShellExecute($filePath)
EndFunc