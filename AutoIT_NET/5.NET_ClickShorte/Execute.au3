#NoTrayIcon
#include <_HttpRequest.au3>
#include <JSON.au3>

Local $username = 'hoangbap1595@gmail.com'
Local $password = 'Hoang911'
Local $file = @ScriptDir&'\log.txt'
Local $fileLink = @ScriptDir&'\FileLink.txt'
Local $resultLink = @ScriptDir&'\ShorteLink.txt'
Local $resultJson = @ScriptDir&'\ShorteJson.json'
Local $cookieFinal = ''
Local $myToken = 'e3aa78bf28230405583a96ab54fda6f9'

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
			Local $urlAddress = 'https://api.shorte.st/stxt/'& $myToken &'/'& $data
			$get = _HttpRequest(2,$urlAddress)
;~ 			$getJson = objectJson($resultJson, $get)
;~ 			$getJson = StringReplace($get, "\", "")
;~ 			$obj = Json_Decode($getJson)
;~ 			$link = Json_Get($obj,'["shortenedUrl"]')
			writeLink($resultLink,$get & @CR)
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

