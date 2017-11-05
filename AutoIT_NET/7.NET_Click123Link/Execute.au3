#NoTrayIcon
#include <_HttpRequest.au3>
#include <JSON.au3>

Local $username = 'lchoang1995@gmail.com'
Local $password = 'Hoang911'
Local $file = @ScriptDir&'\log.txt'
Local $fileLink = @ScriptDir&'\FileLink.txt'
Local $resultLink = @ScriptDir&'\123Link.txt'
Local $resultJson = @ScriptDir&'\123Json.json'
Local $cookieFinal = ''
Local $myToken = '20772de6a738c9f3d4f6d803d7a62ba5bf3855e1'
Local $url = 'https://123link.top'
Local $urlAddress = 'https://123link.top/auth/signin'
;~ _HttpRequest_SetProxy('http://proxy.hcm.fpt.vn:80')

Login($username,$password)

Func Login($username = '', $password = '')
	FileDelete($file)
	$head = _HttpRequest(1,$url)
	writeLog($file,'Header',$head)
	$cookie = _GetCookie($head)
	writeLog($file,'Cookie',$cookie)
	$data = _HttpRequest(2,$urlAddress,'',$cookie)
	$token = StringRegExp($data,'<input type="hidden" name="_csrfToken" value="(.*?)"/>',1)[0]
;~ 	$tokenField = StringRegExp($data,'<input type="hidden" name="_Token[fields]" value="(.*?)"/>',1)[0]
;~ 	$tokenUnLock = StringRegExp($data,'<input type="hidden" name="_Token[unlocked]" value="(.*?)"/>',1)[0]
	$tokenField = 'cc04d6020c0207395772fadfdaf85b984e5e4a99%3A'
	$tokenUnLock = 'adcopy_challenge%257Cadcopy_response%257Cg-recaptcha-response'
	writeLog($file,'Token',$token)
	writeLog($file,'$tokenField',$tokenUnLock)
	writeLog($file,'$tokenUnLock',$tokenUnLock)
	$dataSend = '_method=POST&_csrfToken='&$token&'&username='&_URIEncode($username)&'&password='&_URIEncode($password)&'&_Token%5Bfields%5D='&$tokenField&'&_Token%5Bunlocked%5D='&$tokenUnLock&''
	writeLog($file,'$tokenUnLock',$dataSend)

	$header = _HttpRequest(1,$urlAddress,$dataSend,$cookie)
	writeLog($file,'$header',$header)

	$cookieFinal = _GetCookie($header)
	writeLog($file,'$cookieFinal',$cookieFinal)

	$header = _HttpRequest(1,$urlAddress,$dataSend,$cookieFinal)
	writeLog($file,'$header',$header)
	$dataFinal = _HttpRequest(2,$urlAddress,$dataSend,$cookieFinal)

;~ 	$location = StringRegExp($header,'Location: (.*?)',1)[0]
;~ 	writeLog($file,'$location',$location)

;~ 	$dataFinal2 = _HttpRequest(2,$location,'',$cookieFinal)
	_HttpRequest_Test($dataFinal,@ScriptDir&'\code.html')
EndFunc


;~ _getLink()

Func _getLink()
	FileDelete($resultLink)
	Local $myLink = ''
	$oFile = FileOpen($fileLink,0)
	$arrFile = FileReadToArray($oFile)

	For $i = 0 To UBound($arrFile)-1
		$data =  $arrFile[$i]
		If $data <> '' And $data <> Null Then
			Local $urlAddress = 'https://123link.top/api/?api='& $myToken &'&url='& $data
			$get = _HttpRequest(2,$urlAddress)
;~ 			$getJson = objectJson($resultJson, $get)
			$getJson = StringReplace($get, "\", "")
			$obj = Json_Decode($getJson)
			$link = Json_Get($obj,'["shortenedUrl"]')
			writeLink($resultLink,$link & @CR)
;~ 			ConsoleWrite($i & ':' & $link)
		EndIf
	Next
EndFunc

Func writeLink($fileSave, $text)
	FileOpen($fileSave,1)
	FileWrite($fileSave,$text)
	FileClose($fileSave)
EndFunc

Func objectJson($fileSave, $text)
	FileOpen($fileSave,2)
	FileWrite($fileSave,$text)
	$data = FileRead($fileSave)
	FileClose($fileSave)
	Return $data
EndFunc

Func writeLog($file,$title, $text)
	FileOpen($file,1)
	FileWrite($file,'====== ' &$title &' ======'&@CR)
	FileWrite($file,$text&@CR)
	FileWrite($file,@CR&@CR)
	FileClose($file)
EndFunc

