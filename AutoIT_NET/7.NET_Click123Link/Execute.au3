#NoTrayIcon
#include <_HttpRequest.au3>
#include <JSON.au3>

Local $username = 'hoangbap1595@gmail.com'
Local $password = 'Hoang911'
Local $file = @ScriptDir&'\log.txt'
Local $fileLink = @ScriptDir&'\FileLink.txt'
Local $resultLink = @ScriptDir&'\123Link.txt'
Local $resultJson = @ScriptDir&'\123Json.json'
Local $cookieFinal = ''
Local $myToken = '20772de6a738c9f3d4f6d803d7a62ba5bf3855e1'


;~ Login($urlAddress,$username,$password)

Func Login($urlAddress,$username = '', $password = '')
	FileDelete($file)

EndFunc


_getLink()
Func _getLink()
	FileDelete($resultLink)
	Local $myLink = ''
	$oFile = FileOpen($fileLink,0)
	For $i = 0 To 100
		$data =  FileReadLine($oFile,$i)
		If $data <> '' And $data <> Null Then
			Local $urlAddress = 'https://123link.top/api/?api='& $myToken &'&url='& $data
			$get = _HttpRequest(2,$urlAddress)
			$getJson = objectJson($resultJson, $get)
			MsgBox(0,0,$getJson)
			$x = Json_StringDecode($getJson)
			MsgBox(0,0,$x)
			$obj = Json_Decode($x)
			MsgBox(0,0,$obj)
			$link = Json_ObjGet($obj,'["status"]')
			MsgBox(0,0,$link)
;~ 			writeLink($resultLink,$link)
;~ 			ConsoleWrite($i & ':' & $link)
		EndIf
	Next
EndFunc

Func writeLink($fileSave, $text)
	FileOpen($fileSave,1)
	FileWrite($fileSave,$text&@CR)
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

