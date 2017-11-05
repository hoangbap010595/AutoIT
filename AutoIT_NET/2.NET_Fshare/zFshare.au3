#include <_HttpRequest.au3>

;~ header: fs_csrf=ef0197e45e9f2a43a0fb2737e93e2c19442ce611&LoginForm%5Bemail%5D=lchoang1995%40gmail.com&LoginForm%5Bpassword%5D=Hoang911&LoginForm%5Bcheckloginpopup%5D=0&LoginForm%5BrememberMe%5D=0&yt0=%C4%90%C4%83ng+nh%E1%BA%ADp: undefined
;~ header2: fs_csrf=358f04f506f686bff02f67d5e25edd11ff2bf7b9&LoginForm%5Bemail%5D=lchoang1995%40gmail.com&LoginForm%5Bpassword%5D=Hoang911&LoginForm%5Bcheckloginpopup%5D=0&LoginForm%5BrememberMe%5D=0&yt0=%C4%90%C4%83ng+nh%E1%BA%ADp: undefined
_HttpRequest_SetOption("http://proxy.hcm.fpt.vn:80")
$url = 'https://www.fshare.vn/'
$urlLogin = 'https://www.fshare.vn/login'
;~ login
$email = "lchoang1995@gmail.com"
$pass = "Hoang911"

$a = _GetMD5($pass)
MsgBox(0,'$cookie Data',$a)
;~ MsgBox(0,"$fs_csrf",_URIEncode($email))
;~ MsgBox(0,"$fs_csrf",_URIEncode($pass))

$data = _HttpRequest(2,'https://www.fshare.vn/')
;~ _FileWrite_Test($data)

$cookie = _GetCookie($data)
MsgBox(0,'$cookie Data',$cookie)

$fs_csrf = StringRegExp($data,'<input type="hidden" value="(.*)" name="fs_csrf" />',1)[0]
MsgBox(0,"$fs_csrf",$fs_csrf)

$dataLogin = 'fs_csrf='&$fs_csrf&'&LoginForm%5Bemail%5D='& _URIEncode($email)&'&LoginForm%5Bpassword%5D='&_URIEncode($pass)&'&LoginForm%5Bcheckloginpopup%5D=0&LoginForm%5BrememberMe%5D=0&yt0=%C4%90%C4%83ng+nh%E1%BA%ADp'
$dataLogin2 = 'fs_csrf='&$fs_csrf&'&LoginForm%5Bemail%5D=lchoang1995%40gmail.com&LoginForm%5Bpassword%5D=Hoang911&LoginForm%5Bcheckloginpopup%5D=0&LoginForm%5BrememberMe%5D=0&yt0=%C4%90%C4%83ng+nh%E1%BA%ADp'

$header = _HttpRequest(1,$urlLogin,$dataLogin)
MsgBox(0,'$header',$header)

$location = _GetLocationRedirect($header)
MsgBox(0,'$location',$location)

$cookie = _GetCookie($header)
MsgBox(0,'$cookie',$cookie)