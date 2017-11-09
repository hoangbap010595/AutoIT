#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.15.0 (Beta)
	Author:         HoangLC3

#ce ----------------------------------------------------------------------------

#include <_HttpRequest.au3>
#include <InetConstants.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <GDIPlus.au3>
#include "CoreData.au3"

Local $username = 'lchoang1995@gmail.com'
Local $password = 'Omega@1112'
Global $cookieFinal = ''
Global $myIDAccount = ''
Local $urlLogin = 'https://manager.sunfrogshirts.com/'
Local $urlDashboard = 'https://manager.sunfrogshirts.com/index.cfm?dashboard'
Local $urlUpload = 'https://manager.sunfrogshirts.com/Designer/php/upload-handler.cfm'
Local $urlEditDesign = 'https://manager.sunfrogshirts.com/my-art-edit.cfm?editNewDesign'

;~ HttpSetProxy(2,"http://proxy.hcm.fpt.vn:80")
_HttpRequest_SetProxy("http://proxy.hcm.fpt.vn:80")

#Region =======TESS=======

;~ $login = Login($username, $password)
;~ If $login = Null Then
;~ 	MsgBox(0, 0, 'Dang nhap khong thanh cong')
;~ EndIf

#EndRegion =======TESS=======

Func Login($username, $password)
	$cookieFinal = ''
	$data = _HttpRequest(1, $urlLogin)

	$cookieFirst = _GetCookie(1, $data)
;~ 	MsgBox(0,0,$cookieFirst)

	$dataToSendLogin = 'username=' & _URIEncode($username) & '&password=' & _URIEncode($password) & '&login=Login'
;~ 	MsgBox(0,0,$dataToSendLogin)

	$dataLogin = _HttpRequest(1, $urlLogin, $dataToSendLogin, $cookieFirst, $urlLogin)
;~ 	MsgBox(0,0,$dataLogin)

	$location = _GetLocationRedirect($dataLogin)
;~ 	MsgBox(0,0,$location)

	$resultFinal = _HttpRequest(1, $location, '', $cookieFirst, $urlLogin)
;~ 	MsgBox(0,0,$resultFinal)

	$cookieFinal = _GetCookie($resultFinal)
;~ 	MsgBox(0,0,$cookieFinal)

	$resultFinal = _HttpRequest(2, $urlDashboard, '', $cookieFinal, $urlLogin)
;~ 	_HttpRequest_Test($resultFinal,@ScriptDir&'/Code.html',Default,False)

	$regID = '<strong style="font-size:1.5em; line-height:15px; padding-bottom:0px;" class="clearfix">(.*?)</strong>'
	$myIDAccount = StringRegExp($resultFinal, $regID, 3)
;~ 	MsgBox(0, 0, $myIDAccount[0])
;~ 	_ArrayDisplay($myIDAccount)
;~ 	MsgBox(0,0,$myIDAccount)
	If $myIDAccount = 1 Then
		Return 1
	EndIf
;~ 	MsgBox(0, 0, $myIDAccount[0])
	Return $myIDAccount[0]
EndFunc   ;==>Login


Func UploadImageToSunFrog($dataToSend)
;~ 	$dataToSend = '{"ArtOwnerID":0,"IAgree":true,"Title":"hoangtest14","Category":"78","Description":"asdfasdf","Collections":"ADV","Keywords":["adfasdf","asdf","asd"],"imageFront":"<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" id=\"SvgjsSvg1000\" version=\"1.1\" width=\"2400\" height=\"3200\" viewBox=\"311.00000000008 150 387.99999999984004 517.33333333312\"><text id=\"SvgjsText1052\" font-family=\"Source Sans Pro\" fill=\"#808080\" font-size=\"30\" stroke-width=\"0\" font-style=\"\" font-weight=\"\" text-decoration=\" \" text-anchor=\"start\" x=\"457.39119720458984\" y=\"241.71535301208496\"><tspan id=\"SvgjsTspan1056\" dy=\"39\" x=\"457.39119720458984\">adfasdf</tspan></text><defs id=\"SvgjsDefs1001\"></defs></svg>","imageBack":""'
;~ 	$dataToSend &= ',"types":[{"id":8,"name":"Guys Tee","price":19,"colors":["Green"]},{"id":27,"name":"Sweat Shirt","price":31,"colors":["Red"]}],"images":[]}'

	$pathImage = $dataToSend[1] ;'C:\Users\HoangLe\Desktop\Tool up SF\test.png'
	Local $base64 = ConvertImageToBase64($pathImage)
	Local $size = getSizeImage($pathImage)

	$imgFront = ''
	$imgBack = ''
	If $dataToSend[0] = 'F' Then
		$imgFront = '<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" id=\"SvgjsSvg1000\" version=\"1.1\" width=\"2400\" height=\"3200\" viewBox=\"311.00000000008 150 387.99999999984004 517.33333333312\"><g id=\"SvgjsG1052\" transform=\"scale(0.08399999999996445 0.08399999999996445) translate(3761.9047619073062 2165.0793650801543)\"><image id=\"SvgjsImage1053\" xlink:href=\"__dataURI:0__\" width=\"' & $size[0] & '\" height=\"' & $size[1] & '\"></image></g><defs id=\"SvgjsDefs1001\"></defs></svg>'
	Else
		$imgBack = '<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" id=\"SvgjsSvg1006\" version=\"1.1\" width=\"2400\" height=\"3200\" viewBox=\"311.00000000008 100 387.99999999984004 517.33333333312\"><g id=\"SvgjsG1052\" transform=\"scale(0.08399999999996445 0.08399999999996445) translate(3761.9047619073062 1569.8412698418072)\"><image id=\"SvgjsImage1053\" xlink:href=\"__dataURI:0__\" width=\"' & $size[0] & '\" height=\"' & $size[1] & '\"></image></g><defs id=\"SvgjsDefs1007\"></defs></svg>'
	EndIf

	$title = $dataToSend[2] ;'text'
	$category = String(getIDCatoryProduct($dataToSend[3])) ;82
	$description = $dataToSend[4] ;'text'
	$collection = $dataToSend[5] ;'text'
	$keyword = convertStringToJson($dataToSend[6]) ;'mot,hai,ba'

	$theme = $dataToSend[7] ;json

	$dataToSend2 = '{'
	$dataToSend2 &= '"ArtOwnerID":0,"IAgree":true'
	$dataToSend2 &= ',"Title":"' & $title & '"'
	$dataToSend2 &= ',"Category":"' & $category & '"'
	$dataToSend2 &= ',"Description":"' & $description & '"'
	$dataToSend2 &= ',"Collections":"' & $collection & '"'
	$dataToSend2 &= ',"Keywords": ' & $keyword & ''
	$dataToSend2 &= ',"imageFront":"' & $imgFront & '"'
	$dataToSend2 &= ',"imageBack":"' & $imgBack & '"'
	$dataToSend2 &= ',"types":' & $theme & ''
	$dataToSend2 &= ',"images":[{"id":"__dataURI:0__","uri":"data:image/png;base64,' & $base64 & '"}]'
	$dataToSend2 &= '}'

	witeContentFile($dataToSend2, 'data.txt')
	$uploadResult = _HttpRequest(2, $urlUpload, $dataToSend2, $cookieFinal)
;~ 	MsgBox(0, 0, $uploadResult)
	witeContentFile($uploadResult, 'result.txt')


	$lsImageFront2 = StringRegExp($uploadResult, '"imageFront":"(.*?)","imageBack"', 3)
	$lsImageBack2 = StringRegExp($uploadResult, '"imageBack":"(.*?)","color"', 3)

	$result =  StringRegExp($uploadResult,'"description":"(.*?)","products"',1)

	For $item In $lsImageFront2
		$url = 'http:' & $item
		DownLoadImageFromUrl($url)
	Next
	For $item In $lsImageBack2
		$url = 'http:' & $item
		DownLoadImageFromUrl($url)
	Next
	Return $result
EndFunc   ;==>UploadImageToSunFrog

Func DownLoadImageFromUrl($url)
	Local $sFilePath = @ScriptDir & '\Uploaded\'
	If FileExists($sFilePath) = False Then
		DirCreate($sFilePath)
	EndIf
	$arr = StringSplit($url, '/')
	Local $sFileName = $arr[UBound($arr) - 1]

	Local $fileSave = $sFilePath & $sFileName
	; Download the file in the background with the selected option of 'force a reload from the remote site.'
	Local $hDownload = InetGet($url, $fileSave, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

	; Close the handle returned by InetGet.
	InetClose($hDownload)
EndFunc   ;==>DownLoadImageFromUrl

Func ConvertImageToBase64($pathImage)
	$dat = FileRead($pathImage)
	$objXML = ObjCreate("MSXML2.DOMDocument")
	$objNode = $objXML.createElement("b64")
	$objNode.dataType = "bin.base64"
	$objNode.nodeTypedValue = $dat
	ClipPut($objNode.Text)

	$data = ClipGet()

	Return $data ;
EndFunc   ;==>ConvertImageToBase64

Func getSizeImage($filePath)
	_GDIPlus_Startup()
	Local $result[2]
	Local $hImage = _GDIPlus_ImageLoadFromFile($filePath)
	If @error Then
		MsgBox(16, "Error", $filePath & @CRLF & "Does the file exist?")
		Exit 1
	EndIf

	$result[0] = _GDIPlus_ImageGetWidth($hImage)
	$result[1] = _GDIPlus_ImageGetHeight($hImage)

	_GDIPlus_ImageDispose($hImage)

	_GDIPlus_Shutdown()

	Return $result
EndFunc   ;==>getSizeImage

Func witeContentFile($data, $fileName)
	$file = FileOpen(@ScriptDir & '/' & $fileName, 2)
	FileWrite($file, $data)
	FileClose($file)
EndFunc   ;==>witeContentFile
