#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         HoangLC3

#ce ----------------------------------------------------------------------------

#include <_HttpRequest.au3>
#include <InetConstants.au3>
#include <Array.au3>


Local $username = 'lchoang1995@gmail.com'
Local $password = 'Omega@111'
Global $cookieFinal = ''
Global $myIDAccount = ''
Local $urlLogin = 'https://manager.sunfrogshirts.com/'
Local $urlDashboard = 'https://manager.sunfrogshirts.com/index.cfm?dashboard'
Local $urlUpload = 'https://manager.sunfrogshirts.com/Designer/php/upload-handler.cfm'
Local $urlEditDesign = 'https://manager.sunfrogshirts.com/my-art-edit.cfm?editNewDesign'

Login($username,$password)
Func Login($userName, $passWord)
	$cookieFinal = ''
	$data = _HttpRequest(1,$urlLogin)

	$cookieFirst = _GetCookie(1,$data)
;~ 	MsgBox(0,0,$cookieFirst)

	$dataToSendLogin = 'username='& _URIEncode($userName) &'&password='& _URIEncode($passWord) &'&login=Login'
;~ 	MsgBox(0,0,$dataToSendLogin)

	$dataLogin = _HttpRequest(1,$urlLogin,$dataToSendLogin,$cookieFirst,$urlLogin)
;~ 	MsgBox(0,0,$dataLogin)

	$location = _GetLocationRedirect($dataLogin)
;~ 	MsgBox(0,0,$location)

	If $location = '' Then
		MsgBox(0,0,'Dang nhap khong thanh cong')
		Return $cookieFinal
	EndIf

	$resultFinal = _HttpRequest(1,$location,'',$cookieFirst,$urlLogin)
;~ 	MsgBox(0,0,$resultFinal)

	$cookieFinal = _GetCookie($resultFinal)
;~ 	MsgBox(0,0,$cookieFinal)


	$resultFinal = _HttpRequest(2,$urlDashboard,'',$cookieFinal,$urlLogin)
;~ 	_HttpRequest_Test($resultFinal,@ScriptDir&'/Code.html',Default,False)

	$regID = '<strong style="font-size:1.5em; line-height:15px; padding-bottom:0px;" class="clearfix">(.*?)</strong>'
	$myIDAccount = StringRegExp($resultFinal,$regID,3)[0]
;~ 	_ArrayDisplay($myIDAccount)
;~ 	MsgBox(0,0,$myIDAccount)

;~ 	UploadImageToSunFrog()
EndFunc


Func UploadImageToSunFrog()
	$dataToSend = '{"ArtOwnerID":0,"IAgree":true,"Title":"hoangtest14","Category":"78","Description":"asdfasdf","Collections":"ADV","Keywords":["adfasdf","asdf","asd"],"imageFront":"<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" id=\"SvgjsSvg1000\" version=\"1.1\" width=\"2400\" height=\"3200\" viewBox=\"311.00000000008 150 387.99999999984004 517.33333333312\"><text id=\"SvgjsText1052\" font-family=\"Source Sans Pro\" fill=\"#808080\" font-size=\"30\" stroke-width=\"0\" font-style=\"\" font-weight=\"\" text-decoration=\" \" text-anchor=\"start\" x=\"457.39119720458984\" y=\"241.71535301208496\"><tspan id=\"SvgjsTspan1056\" dy=\"39\" x=\"457.39119720458984\">adfasdf</tspan></text><defs id=\"SvgjsDefs1001\"></defs></svg>","imageBack":""'
	$dataToSend &= ',"types":[{"id":8,"name":"Guys Tee","price":19,"colors":["Green"]},{"id":27,"name":"Sweat Shirt","price":31,"colors":["Red"]}],"images":[]}'

	$uploadResult= _HttpRequest(2,$urlUpload,$dataToSend,$cookieFinal)
;~ 	MsgBox(0,0,$uploadResult)

	$viewResult = _HttpRequest(2,$urlEditDesign,'',$cookieFinal)
;~ 	_HttpRequest_Test($viewResult,@ScriptDir&'\Code.html',Default,False)

	$lsImage = StringRegExp($viewResult,'<img src=(.*?) class="img-responsive" style="max-height:65px;" />',3)

	For $item In $lsImage
		$url = 'http:' & StringTrimLeft(StringTrimRight($item,1),1)
;~ 		MsgBox(0,0,$url)
		DownLoadImageFromUrl($url)
	Next

EndFunc

Func DownLoadImageFromUrl($url)

	Local $sFilePath = @ScriptDir & '\Uploaded\'
	If FileExists($sFilePath) = False Then
		DirCreate($sFilePath)
	EndIf

	Local $sFileName = StringSplit($url,'/')[7]

	Local $fileSave = $sFilePath&$sFileName
    ; Download the file in the background with the selected option of 'force a reload from the remote site.'
    Local $hDownload = InetGet($url, $fileSave, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

    ; Close the handle returned by InetGet.
    InetClose($hDownload)
EndFunc

Func ConvertImageToBase64($pathImage)
	$dat=FileRead($pathImage)
	$objXML=ObjCreate("MSXML2.DOMDocument")
	$objNode=$objXML.createElement("b64")
	$objNode.dataType="bin.base64"
	$objNode.nodeTypedValue=$dat
	ClipPut($objNode.Text)

	$data = ClipGet()

	Return $data;
EndFunc
