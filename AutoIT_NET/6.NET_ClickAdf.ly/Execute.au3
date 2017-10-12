#include <_HttpRequest.au3>

Local $urlAddress = 'https://login.adf.ly/login'
Local $username = 'hoangbap1595@gmail.com'
Local $password = 'Hoang911'
Local $file = @ScriptDir&'\log.txt'
Local $cookieFinal = ''

Login($urlAddress,$username,$password)

Func Login($urlAddress,$username = '', $password = '')
	FileDelete($file)
	$header = _HttpRequest(1,$urlAddress)
	writeLog('Header', $header)
	$cookie = _GetCookie($header)
	writeLog('Coikie', $cookie)

	$data = _HttpRequest(2,$urlAddress)
	$token = StringRegExp($data,'<input type="hidden" name="token" id="token" value="(.*?)" />',1)[0]
	writeLog('Token', $token)

	Local $dataToSend = 'token='& $token &'&bmlUrl=&bmlType=&bmlDomain=&bmlFolder=&dest=&response=&email='& _HTMLEncode($username) &'&password='& _HTMLEncode($password)&''
	writeLog('DataToSend', $dataToSend)
	$login = _HttpRequest(1,$urlAddress,$dataToSend)
	writeLog('Login', $login)

	$ok = _HttpRequest(2,$urlAddress,$dataToSend)
	writeLog('$ok', $ok)
	_HttpRequest_Test($ok,@ScriptDir&'\code.html')
;~ 	$cookieFinal = _GetCookie($login)
;~ 	writeLog('CookieFinal', $cookieFinal)
EndFunc

Func writeLog($title, $text)
	FileOpen($file,1)
	FileWrite($file,'====== ' &$title &' ======'&@CR)
	FileWrite($file,$text&@CR)
	FileWrite($file,@CR&@CR)
	FileClose($file)
EndFunc