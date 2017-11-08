#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.15.0 (Beta)
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

;~ #NoTrayIcon
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
Local $minWidthForm = @DesktopWidth - 500
Local $minHeightForm = @DesktopHeight - 200
Local $aArrayData ;
Local $rangeValue = "A1:H1000"
Local $filePath = ''
#Region ===Create GUI===

_Metro_EnableHighDPIScaling()
_SetTheme("LightGreen")

$Form1 = _Metro_CreateGUI($tilte, $minWidthForm, $minHeightForm, -1, -1)
_Metro_SetGUIOption($Form1, True, False, $minWidthForm, $minHeightForm)
;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
$Control_Buttons = _Metro_AddControlButtons(True, False, True)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
;~ $GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
;~ $GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
;~ $GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]

;~ Add Control
$lblTitle = GUICtrlCreateLabel("Auto Upload Sunfrog", 5, 0, 198, 28)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x000000)

;~ Group Themes
$Themes = GUICtrlCreateGroup("", $minWidthForm - 205, 38, 200, $minHeightForm - 48)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
$idComboBox = GUICtrlCreateCombo("", $minWidthForm - 200, 60, 145, 30, $CBS_DROPDOWNLIST)
$idListview = GUICtrlCreateListView("Select Color                       ", $minWidthForm - 200, 90, 190, $minHeightForm - 110, -1, $LVS_EX_CHECKBOXES)
$idButtonAddColor = _Metro_CreateButtonEx2("+", $minWidthForm - 50, 58, 40, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ Group Login
GUICtrlCreateGroup("", 16, 40, 217, 153)
$txtAccount = GUICtrlCreateInput("", 26, 75, 193, 21)
$lblAccount = GUICtrlCreateLabel("Account", 26, 58, 44, 15)
$txtPassword = GUICtrlCreateInput("", 26, 122, 193, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
$lblPassword = GUICtrlCreateLabel("Password", 26, 105, 50, 17)
$btnLogin = _Metro_CreateButtonEx2("Login", 56, 155, 129, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)

;~ Group Infomation
$Infomation = GUICtrlCreateGroup("", 16, 195, 217, $minHeightForm - 205)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateLabel("Title", 24, 225, 30, 20)
$txtTitle = GUICtrlCreateInput("", 24, 245, 201, 24)
GUICtrlCreateLabel("Category", 24, 275, 59, 20)
$txtCollection = GUICtrlCreateInput("", 24, 395, 201, 24)
GUICtrlCreateLabel("Description", 24, 327, 72, 20)
$Input1 = GUICtrlCreateInput("", 24, 345, 201, 24)
GUICtrlCreateLabel("Collection", 24, 375, 63, 20)
$cbbCategory = GUICtrlCreateCombo("", 24, 295, 201, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlCreateLabel("Keyword", 24, 426, 56, 20)
$txtKeyword = GUICtrlCreateInput("", 24, 445, 201, 24)
GUICtrlCreateLabel("Path Image", 24, 480, 72, 20)
$txtPathImage = GUICtrlCreateInput("", 24, 500, 201, 24)
$ckFrontBack = _Metro_CreateCheckboxEx("Front/Back", 24, 544, 120, 25)
$btnReset = _Metro_CreateButtonEx2("Reset", 24, $minHeightForm - 45, 75, 25)
$btnSetting = _Metro_CreateButtonEx2("Setting", 104, $minHeightForm - 45, 115, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)


GUICtrlCreateGroup("", 240, 40, 650, 250)
$lvSelectTheme = GUICtrlCreateListView("Name|Color 1|Color 2|Color 3|Color 4|Color 5", 242, 48, 645, 238)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 120)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 4, 100)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 5, 100)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("", 240, 290, 650, 100)
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
$Group3 = GUICtrlCreateGroup("", 240, 390, 650, 300)
$lvLog = GUICtrlCreateListView("", 243, 398, 638, 288, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_NOCOLUMNHEADER))
_GUICtrlListView_InsertColumn($lvLog, 0, "Content", 630)
GUICtrlCreateGroup("", -99, -99, 1, 1)

getColorGuysAndLadies($idListview)
getCategoryThemes($idComboBox)
getCategoryProduct($cbbCategory)
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
		Case $GUI_RESTORE_BUTTON
			GUISetState(@SW_RESTORE, $Form1)
		Case $GUI_MENU_BUTTON
			;Create an Array containing menu button names
			Local $MenuButtonsArray[5] = [" Home", "Settings", "About", "Contact", "Exit"]
			; Open the metro Menu. See decleration of $MenuButtonsArray above.
			Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
			Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
				Case "0"
					ConsoleWrite("Returned 0 = Starting themes demo. Please note that the window border colors are not updated during this demo." & @CRLF)
				Case "1"
					ConsoleWrite("Returned 1 = Settings button clicked." & @CRLF)
				Case "2"
					ConsoleWrite("Returned 2 = About button clicked." & @CRLF)
				Case "3"
					ConsoleWrite("Returned 3 = Contact button clicked." & @CRLF)
				Case "4"
					Local $OK = _Metro_MsgBox(4, "Message", "Do you want to exit ?", 300, 11, $Form1)
					If $OK = "Yes" Then
						_Metro_GUIDelete($Form1)
						Exit
					EndIf
			EndSwitch
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
			addThemes($idComboBox, $idListview)
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
	EndSwitch
WEnd


Func addThemes($combobox, $listview)
	$sData = GUICtrlRead($combobox)
	$arrDataTheme = getIDCatoryShirts($sData)
	$arrDataColor = ''
	For $x = 1 To 20
		If _GUICtrlListView_GetItemChecked($listview, $x - 1) Then
			$arrDataColor &= _GUICtrlListView_GetItemTextString($listview, $x - 1) & ','
		EndIf
	Next
	$arrDataColor = StringTrimRight($arrDataColor, 1)
	$strJon = '[{"id":' & $arrDataTheme[0] & ',"name":"' & $arrDataTheme[1] & '","price":' & $arrDataTheme[2] & ',"colors":' & convertStringToJson($arrDataColor) & '}]'
	MsgBox(0, 0, $strJon)
EndFunc   ;==>addThemes

Func actionLogin()
	$username = GUICtrlRead($txtAccount)
	$password = GUICtrlRead($txtPassword)
	$login = Login($username, $password)
	If $login = Null Then
		_Metro_MsgBox(4, "Message", "Login is disabled, and the password is incorrect!", 300, 11, $Form1)
	Else
		GUICtrlDelete($txtAccount)
		GUICtrlDelete($txtPassword)
		GUICtrlDelete($lblAccount)
		GUICtrlDelete($lblPassword)
		GUICtrlDelete($btnLogin)
		$lblMyID = GUICtrlCreateLabel("", 26, 125, 196, 37, $SS_CENTER, $WS_EX_STATICEDGE)
		GUICtrlSetFont(-1, 23, 800, 0, "MS Sans Serif")
		GUICtrlSetColor(-1, 0x008000)
		GUICtrlCreateLabel("Your Seller ID", 24, 80, 204, 33, $SS_CENTER)
		GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
		GUICtrlSetColor(-1, 0x000080)
		GUICtrlSetData($lblMyID, $login)
	EndIf
EndFunc   ;==>actionLogin

Func actionOpenFile()
	$filePath = FileOpenDialog("Choose file data", @ScriptDir & '\', "Excel (*.xls;*.xlsx)", 1)
	If $filePath <> Null And $filePath <> '' Then
		GUICtrlSetData($txtFilePathExcel, $filePath)
		$oExcel2 = _Excel_Open()
		$oExcel = _Excel_BookOpen($oExcel2, $filePath, True, False)
		$aArrayData = $oExcel.Activesheet.Range($rangeValue).Value
;~ 		_ArrayColDelete($aArrayData, 0)
		_Excel_BookClose($oExcel)
		_Excel_Close($oExcel2)

		_Excel_BookOpen(
	EndIf
	Local $iRows = UBound($aArrayData, $UBOUND_ROWS)
	Local $iCols = UBound($aArrayData, $UBOUND_COLUMNS)
	For $x = $iCols - 1 To 0 Step -1
		If $aArrayData[1][$x] = '' Then
			_ArrayColDelete($aArrayData, $x)
		EndIf
	Next
EndFunc   ;==>actionOpenFile

Func actionViewData()
	If UBound($aArrayData) = 0 Then
		_Metro_MsgBox(0, "Message", "Data is not found!", 200, 11, $Form1)
		Return
	EndIf
	_ArrayDisplay($aArrayData, "", "", 0)
EndFunc   ;==>actionViewData

Func actionClearLog()
	_GUICtrlListView_DeleteAllItems($lvLog)
	writeLog('Clear', 1)
EndFunc   ;==>actionClearLog

Func actionClearThemes()
	_GUICtrlListView_DeleteAllItems($lvSelectTheme)
	updateStatusFileExcel(1)
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
	_GUICtrlListView_AddItem($lvLog, $data, 0)
EndFunc   ;==>writeLog

Func updateStatusFileExcel($index)
	If $filePath <> Null And $filePath <> '' Then
		Local $oExcel = _Excel_Open()
		Local $oWorkbook = _Excel_BookNew($oExcel)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeWrite Example", "Error creating the new workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
			_Excel_Close($oExcel)
			Exit
		EndIf
		_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, "Done",'H'&$index)
		_Excel_Close($oExcel)
		writeLog('Update Status',1)
	EndIf
EndFunc