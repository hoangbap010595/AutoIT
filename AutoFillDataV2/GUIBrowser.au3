#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         HoangLe


 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <IE.au3>
#include <Array.au3>

#Region ### START Koda GUI section ### Form=

Local $title = "Executing script..."

$Form1 = GUICreate($title, 615, 437, 192, 124, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_TABSTOP))
Local $oIE = _IECreateEmbedded()
GUICtrlCreateObj($oIE, 10, 0,595,435)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKRIGHT+$GUI_DOCKTOP+$GUI_DOCKBOTTOM)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$a = 'http://laodongkynghi.dolab.gov.vn/bizsoft/softdolab/html/formregister'

_IENavigate($oIE, $a)
;~ _IENavigate($oIE, "https://www.google.com.vn/")

;~ _IEAction($oIE, "stop")
getDatatest()
;~ a()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Local $OK = MsgBox($MB_OKCANCEL, "Message", "Do you want exit ?")
			If $OK = 1 Then Exit

	EndSwitch
WEnd


Func getDatatest()
	Local $oDiv = _IEGetObjById($oIE, "lst-ib")
	_IEFormElementSetValue($oDiv, "Hey! This works!")
	$oDiv = _IEGetObjById($oIE, "lst-ib")
	Local $oForm1 = _IEGetObjByName($oIE, "f")
;~ 	_IEFormSubmit($oForm1)

	Local $oForms = _IEFormGetCollection($oIE)
	MsgBox($MB_SYSTEMMODAL, "Forms Info", "There are " & @extended & " form(s) on this page")
	For $oForm In $oForms
		MsgBox($MB_SYSTEMMODAL, "Form Info", $oForm.name)
	Next
	Local $oForm = _IEFormGetCollection($oIE, 0)
	Local $oQuery = _IEFormElementGetCollection($oForm, 0)
	_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
	_IEFormSubmit($oForm)

;~ 	MsgBox(0,0,$oDiv)
;~ 	MsgBox(0,0,$oForm)
EndFunc

Func a()
	Local $oForm = _IEFormGetObjByName($oIE, "sky-form-tracuu")
;~ 	Local $oQuery = _IEFormElementGetCollection($oForm, 1)
	Local $oQuery = _IEFormElementGetObjByName($oForm, "cusinfor[name]")

	_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
;~ 	_IEFormSubmit($oForm)

EndFunc
