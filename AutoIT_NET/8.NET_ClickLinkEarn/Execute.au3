#NoTrayIcon
#include <_HttpRequest.au3>
#include <JSON.au3>

Local $username = 'lchoang1995'
Local $password = 'Hoang911'
Local $file = @ScriptDir&'\log.txt'
Local $fileLink = @ScriptDir&'\FileLink.txt'
Local $resultLink = @ScriptDir&'\LinkEarn.txt'
Local $resultJson = @ScriptDir&'\LinkEarn.json'
Local $cookieFinal = ''
Local $myToken = 'fa4517a71da6b69225b49355e71d882d7d7bd718'

_HttpRequest_SetProxy('http://proxy.hcm.fpt.vn:80')

;~ Login($urlAddress,$username,$password)

Func Login($urlAddress,$username = '', $password = '')
	FileDelete($file)

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
			Local $urlAddress = 'https://link-earn.com/api/?api='& $myToken &'&url='& $data
			$get = _HttpRequest(2,$urlAddress)
			$getJson = StringReplace($get, "\", "")
			$obj = Json_Decode($getJson)
			$link = Json_Get($obj,'["shortenedUrl"]')
			writeLink($resultLink,$link & @CR)
			Sleep(100)
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

