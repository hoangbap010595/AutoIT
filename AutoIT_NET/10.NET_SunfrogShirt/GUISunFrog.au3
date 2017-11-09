#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.15.0 (Beta)
	Author:         HoangLC3

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#NoTrayIcon
#include "..\..\MetroGUI\MetroGUI_UDF.au3"
#include "..\..\MetroGUI\_GUIDisable.au3"
#include <_HttpRequest.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <ComboConstants.au3>
#include <AutoItConstants.au3>
#include <GuiListView.au3>
#include <Excel.au3>
#include <Inet.au3>
#include "CoreSunFrog.au3"
#include <Array.au3>

Local $appName = 'Sunfrog Shirts'
Local $version = '1.0.0'
Local $tilte = $appName & ' ' & $version
Local $minWidthForm
Local $minHeightForm
Local $aArrayData ;
Local $rangeValue = "A1:H1000"
Local $filePath = ''
#Region ===Create GUI===
If @DesktopWidth > 1800 Then
	$minWidthForm = @DesktopWidth - 500
Else
	$minWidthForm = @DesktopWidth - 265
EndIf
If @DesktopWidth > 1800 Then
	$minHeightForm = @DesktopHeight - 200
Else
	$minHeightForm = @DesktopHeight - 90
EndIf
_Metro_EnableHighDPIScaling()
_SetTheme("LightGreen")
;~ _SetTheme("DarkGreenV2")

$Form1 = _Metro_CreateGUI($tilte, $minWidthForm, $minHeightForm, -1, -1)
_Metro_SetGUIOption($Form1, True, False, $minWidthForm, $minHeightForm)

;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
$Control_Buttons = _Metro_AddControlButtons(True, True, True, False, False)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
;~ $GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
;~ $GUI_FSRestore_BUTTON = $Control_Buttons[5]
;~ $GUI_MENU_BUTTON = $Control_Buttons[6]

;~ Add Control
$lblTitle = GUICtrlCreateLabel("Auto Upload Sunfrog", 5, 0, 198, 28)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)

;~ Group Themes
$Themes = GUICtrlCreateGroup("Themes", $minWidthForm - 205, 38, 200, $minHeightForm - 48)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$idComboBox = GUICtrlCreateCombo("", $minWidthForm - 200, 60, 145, 30, $CBS_DROPDOWNLIST)
$idListview = GUICtrlCreateListView("Select Color                       ", $minWidthForm - 200, 90, 190, $minHeightForm - 110, -1, $LVS_EX_CHECKBOXES)
$idButtonAddColor = _Metro_CreateButtonEx2("+", $minWidthForm - 50, 58, 40, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ Group Login
$groupSession = GUICtrlCreateGroup("System", 16, 40, 217, 153)
$txtAccount = GUICtrlCreateInput("", 26, 75, 193, 21)
$lblAccount = GUICtrlCreateLabel("Account", 26, 58, 44, 15)
$txtPassword = GUICtrlCreateInput("", 26, 122, 193, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
$lblPassword = GUICtrlCreateLabel("Password", 26, 105, 50, 17)
$btnLogin = _Metro_CreateButtonEx2("Login", 56, 155, 129, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ Group Infomation
$Infomation = GUICtrlCreateGroup("Upload Image", 16, 195, 217, $minHeightForm - 205)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateLabel("Title", 24, 225, 30, 20)
$txtTitle = GUICtrlCreateInput("", 24, 245, 201, 24)
GUICtrlCreateLabel("Category", 24, 275, 59, 20)
$cbbCategory = GUICtrlCreateCombo("", 24, 295, 201, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlCreateLabel("Description", 24, 327, 72, 20)
$txtDescription = GUICtrlCreateInput("", 24, 345, 201, 24)
GUICtrlCreateLabel("Collection", 24, 375, 63, 20)
$txtCollection = GUICtrlCreateInput("", 24, 395, 201, 24)
GUICtrlCreateLabel("Keyword", 24, 426, 56, 20)
$txtKeyword = GUICtrlCreateInput("", 24, 445, 201, 24)
GUICtrlCreateLabel("Path Image", 24, 480, 72, 20)
$txtPathImage = GUICtrlCreateInput("", 24, 500, 201, 24)
$ckFrontBack = _Metro_CreateCheckboxEx("Front/Back", 24, 544, 120, 25)
_Metro_CheckboxCheck($ckFrontBack, True)
$btnReset = _Metro_CreateButtonEx2("Reset", 24, $minHeightForm - 45, 75, 25)
$btnSetting = _Metro_CreateButtonEx2("Setting", 104, $minHeightForm - 45, 115, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)


$groupSelectThemes = GUICtrlCreateGroup("Selected Themes", 240, 40, 650, 250)
$lvSelectTheme = GUICtrlCreateListView("Name|Color 1|Color 2|Color 3|Color 4|Color 5", 242, 55, 645, 230)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 120)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 100)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$groupAction = GUICtrlCreateGroup("Action", 240, 290, 650, 100)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateLabel("File path (*.xls, *.xlsx)", 250, 305, 126, 20)
$txtFilePathExcel = GUICtrlCreateInput("", 250, 325, 330, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY))
$btnOpen = _Metro_CreateButtonEx2("Open", 250, 360, 75, 25)
$btnView = _Metro_CreateButtonEx2("View data", 327, 360, 75, 25)
$btnClearLog = _Metro_CreateButtonEx2("Clear log", 406, 360, 75, 25)
$btnClearThemes = _Metro_CreateButtonEx2("Clear Themes", 483, 360, 99, 25)
$btnUpload = _Metro_CreateButtonEx2("Upload", 744, 312, 131, 33)
$btnUploadALL = _Metro_CreateButtonEx2("Upload From File", 744, 352, 131, 33)
$btnSaveThemes = _Metro_CreateButtonEx2("Save Themes", 607, 312, 131, 33)
$btnLoadTheme = _Metro_CreateButtonEx2("Load Themes", 607, 352, 131, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupLog = GUICtrlCreateGroup("Progress", 240, 390, 650, 280)
$lvLog = GUICtrlCreateListView("", 243, 410, 638, 255, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_NOCOLUMNHEADER))
_GUICtrlListView_InsertColumn($lvLog, 0, "Content", 630)
GUICtrlCreateGroup("", -99, -99, 1, 1)

getColorGuysAndLadies($idListview)
getCategoryThemes($idComboBox)
getCategoryProduct($cbbCategory)
writeLog('Your session has expired and you are no longer logged in.',1)
GUICtrlSetState($btnUpload, $GUI_DISABLE)
GUICtrlSetState($btnUploadALL, $GUI_DISABLE)

GUICtrlSetState($GUI_MAXIMIZE_BUTTON, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion ===Create GUI===

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
			Local $OK = _Metro_MsgBox(4, "Message", "Do you want to exit ?", 300, 11, $Form1)
			If $OK = "Yes" Then
				_Metro_GUIDelete($Form1)
				Exit
			EndIf
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)
		Case $GUI_MAXIMIZE_BUTTON
			GUISetState(@SW_MAXIMIZE, $Form1)
		Case $ckFrontBack
			If _Metro_CheckboxIsChecked($ckFrontBack) Then
				_Metro_CheckboxUnCheck($ckFrontBack)
			Else
				_Metro_CheckboxCheck($ckFrontBack)
			EndIf
		Case $idComboBox
			$sComboRead = GUICtrlRead($idComboBox)
			_GUICtrlListView_DeleteAllItems($idListview)
			loadColorFromCategory($sComboRead, $idListview)
		Case $idButtonAddColor
			addThemes()
		Case $btnLogin
			actionLogin()
		Case $btnOpen
			actionOpenFile()
		Case $btnClearLog
			actionClearLog()
		Case $btnClearThemes
			actionClearThemes()
		Case $btnView
			actionViewData()
		Case $btnUpload
			actionUpload()
		Case $btnUploadALL
			actionUploadAll()
		Case $btnSaveThemes
			actionSaveTheme()
		Case $btnLoadTheme
			actionLoadTheme()
	EndSwitch
WEnd

Func actionSaveTheme()

EndFunc   ;==>actionSaveTheme

Func actionLoadTheme()

EndFunc   ;==>actionLoadTheme

Func actionUpload()
	If getThemes() = "[]" Then
		_Metro_MsgBox(0, "Message", "You have not selected a themes", 300, 11, $Form1)
		Return
	EndIf
	Local $dataToSend[8]
	$Front = _Metro_CheckboxIsChecked($ckFrontBack)
	$dataToSend[0] = $Front = True ? "F" : "B"
	$dataToSend[1] = GUICtrlRead($txtPathImage)
	$dataToSend[2] = GUICtrlRead($txtTitle)
	$dataToSend[3] = GUICtrlRead($cbbCategory)
	$dataToSend[4] = GUICtrlRead($txtDescription)
	$dataToSend[5] = GUICtrlRead($txtCollection)
	$dataToSend[6] = GUICtrlRead($txtKeyword)
	$dataToSend[7] = getThemes()
	If $dataToSend[1] = "" Or $dataToSend[2] = "" Or $dataToSend[4] = "" Or $dataToSend[5] = "" Or $dataToSend[6] = "" Then
		_Metro_MsgBox(0, "Message", "Data upload is not empty!", 300, 11, $Form1)
		Return
	EndIf
	writeLog('Uploading ' & GUICtrlRead($txtTitle), 2)
	$result = UploadImageToSunFrog($dataToSend)
	writeLog($result[0], 1)
	writeLog('Uploaded ' & GUICtrlRead($txtTitle), 1)
EndFunc   ;==>actionUpload

Func actionUploadAll()
	If getThemes() = "[]" Then
		_Metro_MsgBox(0, "Message", "You have not selected a themes", 300, 11, $Form1)
		Return
	EndIf
	Local $iRows = UBound($aArrayData, $UBOUND_ROWS)
	Local $iCols = UBound($aArrayData, $UBOUND_COLUMNS)
	For $j = 1 To $iCols - 1
		Local $dataToSend[8]
		$dataToSend[0] = $aArrayData[0][$j] ;Front Back
		$dataToSend[1] = $aArrayData[1][$j] ;Image
		$dataToSend[2] = $aArrayData[2][$j] ;Title
		$dataToSend[3] = $aArrayData[3][$j] ;Category
		$dataToSend[4] = $aArrayData[4][$j] ;Description
		$dataToSend[5] = $aArrayData[5][$j] ;Collection
		$dataToSend[6] = $aArrayData[6][$j] ;Keyword
		$dataToSend[7] = getThemes()
		_ArrayDisplay($dataToSend)
		writeLog('Uploading ' & $aArrayData[2][$j], 2)
		$result = UploadImageToSunFrog($dataToSend)
		writeLog($result, 1)
		writeLog('Uploaded ' & $aArrayData[2][$j], 1)
	Next
EndFunc   ;==>actionUploadAll

Func getThemes()
	$totalItem = _GUICtrlListView_GetItemCount($lvSelectTheme)
	$strJon = '['
	$dataItem = ''
	For $i = 0 To $totalItem - 1
		$dataItem &= _GUICtrlListView_GetItemTextString($lvSelectTheme, $i) & '|'
		$temp = StringSplit($dataItem, '|')
		$arrDataTheme = getIDCatoryShirts($temp[1])
		$arrDataColor = $temp[2] & ',' & $temp[3] & ',' & $temp[4] & ',' & $temp[5] & ',' & $temp[6]
		$data = '{"id":' & $arrDataTheme[0] & ',"name":"' & $arrDataTheme[1] & '","price":' & $arrDataTheme[2] & ',"colors":' & convertStringToJson($arrDataColor) & '}'
		$strJon &= $data & ','
		$dataItem = ''
	Next
	$strJon = StringTrimRight($strJon, 1)
	$strJon &= ']'
	If $totalItem = 0 Then
		$strJon = '[]'
	EndIf
	Return $strJon
EndFunc   ;==>getThemes

Func addThemes()
	$sData = GUICtrlRead($idComboBox)
	$dataItem = $sData
	$countColor = 0
	For $x = 1 To _GUICtrlListView_GetItemCount($idListview)-1
		If _GUICtrlListView_GetItemChecked($idListview, $x - 1) Then
			$dataItem &= '|' & _GUICtrlListView_GetItemTextString($idListview, $x - 1)
			$countColor = $countColor + 1
		EndIf
	Next
	If $countColor = 0 Then
		_Metro_MsgBox(0, "Message", "You have not selected a color", 300, 11, $Form1)
		Return
	EndIf
	If $countColor > 5 Then
		_Metro_MsgBox(0, "Message", "Choose less than 5 colors", 300, 11, $Form1)
		Return
	EndIf
	; Search for target item
	$iI = _GUICtrlListView_FindText($lvSelectTheme, $sData)
	If $iI < 0 Then
		GUICtrlCreateListViewItem($dataItem, $lvSelectTheme)
	EndIf
EndFunc   ;==>addThemes

Func actionLogin()
	$username = GUICtrlRead($txtAccount)
	$password = GUICtrlRead($txtPassword)
	$login = Login($username, $password)
	If $login = 1 Then
		writeLog('Login is disabled, and the password is incorrect', 3)
		_Metro_MsgBox(4, "Message", "Login is disabled, and the password is incorrect", 400, 11, $Form1)
	Else
		$lblMyID = GUICtrlCreateLabel("", 26, 125, 196, 37, $SS_CENTER, $WS_EX_STATICEDGE)
		GUICtrlSetFont(-1, 23, 800, 0, "MS Sans Serif")
		GUICtrlSetColor(-1, 0x008000)
		GUICtrlCreateLabel("Your Seller ID", 24, 80, 204, 33, $SS_CENTER)
		GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
		GUICtrlSetColor(-1, 0x000080)
		GUICtrlSetData($lblMyID, $login)
		GUICtrlSetData($groupSession, "Session")
		GUICtrlSetState($btnUpload, $GUI_ENABLE)
		GUICtrlSetState($btnUploadALL, $GUI_ENABLE)
		GUICtrlDelete($txtAccount)
		GUICtrlDelete($txtPassword)
		GUICtrlDelete($lblAccount)
		GUICtrlDelete($lblPassword)
		GUICtrlDelete($btnLogin)
		writeLog('Login success', 1)
	EndIf
EndFunc   ;==>actionLogin

Func actionOpenFile()
	$filePath = FileOpenDialog("Choose file data", @ScriptDir & '\', "Excel (*.xls;*.xlsx)", 1)
	If $filePath <> Null And $filePath <> '' Then
		writeLog('Reading content', 2)
		GUICtrlSetData($txtFilePathExcel, $filePath)
		$oExcel2 = _Excel_Open(False)
		$oExcel = _Excel_BookOpen($oExcel2, $filePath, True, False)
		$aArrayData = $oExcel.Activesheet.Range($rangeValue).Value
;~ 		_ArrayColDelete($aArrayData, 0)
		_Excel_BookClose($oExcel)
		_Excel_Close($oExcel2)
	EndIf
	Local $iRows = UBound($aArrayData, $UBOUND_ROWS)
	Local $iCols = UBound($aArrayData, $UBOUND_COLUMNS)
	For $x = $iCols - 1 To 0 Step -1
		If $aArrayData[1][$x] = '' Then
			_ArrayColDelete($aArrayData, $x)
		EndIf
	Next
	Local $iCols2 = UBound($aArrayData, $UBOUND_COLUMNS)
	writeLog('Success ' & $iCols2 - 1 & ' record(s) is opened', 1)
EndFunc   ;==>actionOpenFile

Func actionViewData()
	If UBound($aArrayData) = 0 Then
		_Metro_MsgBox(0, "Message", "Data is empty!", 200, 11, $Form1)
		Return
	EndIf
	_ArrayDisplay($aArrayData, "Data From File Excel", "", 1 + 32, Default, "", Default, Default)
EndFunc   ;==>actionViewData

Func actionClearLog()
	_GUICtrlListView_DeleteAllItems($lvLog)
	writeLog('Clear Log', 1)
EndFunc   ;==>actionClearLog

Func actionClearThemes()
	_GUICtrlListView_DeleteAllItems($lvSelectTheme)
	writeLog('Clear Themes', 1)
EndFunc   ;==>actionClearThemes

Func writeLog($message, $status)
	$time = '[' & @HOUR & ':' & @MIN & ':' & @SEC & '] '
	$result = ''
	Switch $status
		Case 1
			$result = '..............................DONE'
		Case 2
			$result = '..............................In Progress'
		Case 3
			$result = '..............................Faild'
	EndSwitch
	$data = $time & $message & $result
	_GUICtrlListView_InsertItem($lvLog, $data, 0)
EndFunc   ;==>writeLog

Func updateStatusFileExcel($index)
	If $filePath <> Null And $filePath <> '' Then
		Local $oExcel = _Excel_Open(False)
		Local $oWorkbook = _Excel_BookNew($oExcel)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example", "Error creating the new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
			_Excel_Close($oExcel)
			Exit
		EndIf
		MsgBox(0, 0, "H" & $index)
		_Excel_RangeWrite($oWorkbook, Default, "Done", "H" & $index)
		; Save changed workbook
		_Excel_BookSave($oWorkbook)
;~ 		_Excel_Close($oExcel)
		writeLog('Update Status', 1)
	EndIf
EndFunc   ;==>updateStatusFileExcel
