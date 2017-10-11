#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.15.0 (Beta)
	Author:         HoangLe

	Script Function:

#ce ----------------------------------------------------------------------------
#NoTrayIcon
#include "..\MetroGUI\MetroGUI_UDF.au3"
#include "..\MetroGUI\_GUIDisable.au3" ; For dim effects when msgbox is displayed
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <IE.au3>
#include <Inet.au3>


Local $appName = 'Auto Fill Data'
Local $version = '1.0.0'
Local $tilte = $appName & ' ' & $version
Local $aArrayData
Local $filePath = @ScriptDir & '\FileData.xlsx'
Local $fileConfig = @LocalAppDataDir & '\AutoFillData\' & $version & '\config.ini'
Local $filePathConfig = @LocalAppDataDir & '\AutoFillData\' & $version & '\'
Local $countSubmit = 0 ;
Local $rangeValue = "A1:AD10"
;~ Local $urlAddress = 'http://laodongkynghi.dolab.gov.vn/bizsoft/softdolab/html/formregister'
Local $urlAddress = 'https://www.google.com.vn/'
Local $minWidthForm = @DesktopWidth - 100
Local $minHeightForm = 512;
#Region ### START GUI section ### Form=
_Metro_EnableHighDPIScaling()
_SetTheme("LightCyan")
$Form1 = _Metro_CreateGUI($tilte, $minWidthForm, $minHeightForm, -1, -1)
_Metro_SetGUIOption($Form1,True,True,$minWidthForm,$minHeightForm)
;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
$Control_Buttons = _Metro_AddControlButtons(True, False, True, False, False)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
;~ $Form1 = GUICreate($tilte, @DesktopWidth - 100, 512, -1, -1) ;,BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_TABSTOP)

$Group1 = GUICtrlCreateGroup("System", 8, 8, 330, 240)
$Label1 = GUICtrlCreateLabel("Link Target", 25, 33, 60, 17)
Local $txtSUrlTarget = GUICtrlCreateInput("", 85, 28, 245, 21)
Local $txtSPassword = GUICtrlCreateInput("", 85, 58, 245, 21)
$Label2 = GUICtrlCreateLabel("Password", 25, 63, 50, 17)
Local $ckSAutoLogin = _Metro_CreateCheckbox("Auto Login", 20, 95, 125, 25)
Local $ckCAutoEnterData = _Metro_CreateCheckbox("Auto Enter Data", 20, 123, 160, 25)
Local $ckCAutoSubmit = _Metro_CreateCheckbox("Auto Submit", 20, 150, 135, 25)
Local $ckCClearCache = _Metro_CreateCheckbox("Clear cookie, cache", 20, 178, 180, 25)
Local $ckCCloseForm = _Metro_CreateCheckbox("Close form after finish", 20, 205, 200, 25)
Local $btnCHelp = _Metro_CreateButtonEx2("Help", 230, 210, 100, 25)
GUICtrlSetCursor(-1, 0)
Local $btnCAbout = _Metro_CreateButtonEx2("About", 230, 180, 100, 25)
GUICtrlSetCursor(-1, 0)
Local $btnCUpdate = _Metro_CreateButtonEx2("Update", 230, 150, 100, 25)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group2 = GUICtrlCreateGroup("Data", 8, 250, 330, 111)
Local $txtDFilePath = GUICtrlCreateInput("", 25, 290, 265, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY))
Local $btnDOpenFile = _Metro_CreateButtonEx2("...", 295, 289, 35, 23, $BS_CENTER)
GUICtrlSetCursor(-1, 0)
$Label3 = GUICtrlCreateLabel("Choose file data (*.xlsx, *.xls)", 25, 270, 138, 17)
Local $btnDView = _Metro_CreateButtonEx2("View", 215, 320, 115, 25)
GUICtrlSetCursor(-1, 0)
Local $btnDGetForm = _Metro_CreateButtonEx2("Get Form", 100, 320, 115, 25)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group3 = GUICtrlCreateGroup("", 8, 365, 330, 141)
Local $btnExit = _Metro_CreateButtonEx2("Exit", 215, 450, 89, 49)
GUICtrlSetCursor(-1, 0)
Local $btnEStop = _Metro_CreateButtonEx2("Stop", 120, 450, 89, 49)
GUICtrlSetCursor(-1, 0)
Local $btnEStart = _Metro_CreateButtonEx2("Start", 25, 450, 89, 49)
GUICtrlSetCursor(-1, 0)
$Label5 = GUICtrlCreateLabel("Submited", 25, 400, 101, 30, $SS_CENTER)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
Local $lblESubmited = GUICtrlCreateLabel("0", 130, 390, 50, 29, $SS_CENTER)
GUICtrlSetFont(-1, 25, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$lblIpIE = GUICtrlCreateLabel("IE...", 351, 25, @DesktopWidth - 460, 22)
Local $oIE = _IECreateEmbedded()
GUICtrlCreateObj($oIE, 350, 45, @DesktopWidth - 460, 460)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKRIGHT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM)

GUICtrlSetState($btnEStop, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion ### START GUI section ### Form=
;~ writeConfig()
;load config
readConfig()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_MINIMIZE_BUTTON
			GUISetState(@SW_MINIMIZE, $Form1)
		Case $GUI_EVENT_CLOSE,$GUI_CLOSE_BUTTON
			Local $OK = _Metro_MsgBox(4, "Message", "Do you want exit ?",300,11,$Form1)
			If $OK = "Yes" Then
				_Metro_GUIDelete($Form1)
				Exit
			EndIf
		Case $btnDOpenFile
			openFileExcel()
		Case $btnDGetForm
			getFormExcel()
		Case $btnDView
			viewDataExcel()
		Case $btnExit
			_exit()
		Case $btnCUpdate
			updateSetting()
		Case $btnCAbout
			_about()
		Case $btnEStart
			_start()
		Case $btnEStop
			_stop()
		Case $ckSAutoLogin
			If _Metro_CheckboxIsChecked($ckSAutoLogin) Then
				_Metro_CheckboxUnCheck($ckSAutoLogin)
			Else
				_Metro_CheckboxCheck($ckSAutoLogin)
			EndIf
		Case $ckCAutoEnterData
			If _Metro_CheckboxIsChecked($ckCAutoEnterData) Then
				_Metro_CheckboxUnCheck($ckCAutoEnterData)
			Else
				_Metro_CheckboxCheck($ckCAutoEnterData)
			EndIf
		Case $ckCAutoSubmit
			If _Metro_CheckboxIsChecked($ckCAutoSubmit) Then
				_Metro_CheckboxUnCheck($ckCAutoSubmit)
			Else
				_Metro_CheckboxCheck($ckCAutoSubmit)
			EndIf
		Case $ckCClearCache
			If _Metro_CheckboxIsChecked($ckCClearCache) Then
				_Metro_CheckboxUnCheck($ckCClearCache)
			Else
				_Metro_CheckboxCheck($ckCClearCache)
			EndIf
		Case $ckCCloseForm
			If _Metro_CheckboxIsChecked($ckCCloseForm) Then
				_Metro_CheckboxUnCheck($ckCCloseForm)
			Else
				_Metro_CheckboxCheck($ckCCloseForm)
			EndIf
	EndSwitch
WEnd

#Region ===Function Event===
;~ Tab System
; Update config system
Func updateSystem()
	writeConfig()
	_Metro_MsgBox(0, 'Message', 'Update successfully!',300,11)
EndFunc   ;==>updateSystem

Func _about()
	$text = 'Application: ' & @TAB & $appName & @LF
	$text &= 'Description:' & @TAB & '...' & @LF
	$text &= 'Date:' & @TAB & @TAB & '2017.10.10' & @LF
	$text &= 'Version:' & @TAB & $version & @LF
	$text &= 'Author:' & @TAB & @TAB & 'HoangLe' & @LF
	$text &= 'Email:' & @TAB & '            lchoang1995@gmail.com' & @LF
	_Metro_MsgBox(0, 'About', $text, 350,11,$Form1)
EndFunc   ;==>_about

;~ Tab Data
Func openFileExcel()
	$file = FileOpenDialog("Choose file data", "%programdata%", "Excel (*.xlsx; *.xls)", 1)
	If $file <> Null And $file <> '' Then
		GUICtrlSetData($txtDFilePath, $file)
		$oExcel2 = _Excel_Open()
		$oExcel = _Excel_BookOpen($oExcel2, $filePath, True, False)
		$aArrayData = $oExcel.Activesheet.Range($rangeValue).Value
		_ArrayColDelete($aArrayData, 1)
		_Excel_BookClose($oExcel)
		_Excel_Close($oExcel2)
	EndIf
EndFunc   ;==>openFileExcel

Func getFormExcel()
	$folder = FileSelectFolder("Choose folder to save", "%programdata%")
	If $folder <> Null And $folder <> '' Then
		FileCopy($filePath, $folder & '\FileData.xlsx')
		Local $OK = _Metro_MsgBox(1, "Message", "Do you want to open file ?",400,11,$Form1)
		If $OK = "OK" Then
			Local $oExcel2 = _Excel_Open()
			$oExcel = _Excel_BookOpen($oExcel2, $filePath)
		EndIf
	EndIf
EndFunc   ;==>getFormExcel

Func viewDataExcel()
	$file = GUICtrlRead($txtDFilePath)
	If $file <> Null And $file <> '' Then
		If $aArrayData <> Null And UBound($aArrayData) > 0 Then
			_ArrayDisplay($aArrayData, "Data", "", 16)
		Else
			_Metro_MsgBox(0, "Message", 'File is empty! Not found data.',400,11,$Form1)
		EndIf
	Else
		_Metro_MsgBox(0, "Message", 'File not found. Please choose your file to open!',400,11,$Form1)
	EndIf
EndFunc   ;==>viewDataExcel

;~ Tab Setting
Func _exit()
	Local $OK = _Metro_MsgBox(4, "Message", "Do you want exit ?",300,11,$Form1)
	If $OK = "Yes" Then Exit
EndFunc   ;==>_exit

Func updateSetting()
	writeConfig()
	_Metro_MsgBox(0, 'Message', 'Update successfully!',300,11,$Form1)
EndFunc   ;==>updateSetting

;~ Tab Execute
Func _start()
	GUICtrlSetState($btnEStop, $GUI_ENABLE)
	GUICtrlSetState($btnEStart, $GUI_DISABLE)
	$timeRight = 0
;~ 	$countSubmit = 0;
	initBrowser()
	settingSubmit()
EndFunc   ;==>_start

Func _stop()
	GUICtrlSetState($btnEStop, $GUI_DISABLE)
	GUICtrlSetState($btnEStart, $GUI_ENABLE)
	_IEAction($oIE, "stop")
	MsgBox($MB_TOPMOST, "Message", "Stopped IE.")
EndFunc   ;==>_stop

; Submited
Func settingSubmit()
	$countSubmit += 1
	GUICtrlSetData($lblESubmited, $countSubmit)
EndFunc   ;==>settingSubmit

; Config
Func writeConfig()
	$url = GUICtrlRead($txtSUrlTarget)
	$pass = GUICtrlRead($txtSPassword)
	$autoLogin = _Metro_CheckboxIsChecked($ckSAutoLogin)
	$autEnter = _Metro_CheckboxIsChecked($ckCAutoEnterData)
	$autoSubmit = _Metro_CheckboxIsChecked($ckCAutoSubmit)
	$clearCache = _Metro_CheckboxIsChecked($ckCClearCache)
	$closeForm = _Metro_CheckboxIsChecked($ckCCloseForm)

	$fOpen = FileOpen($fileConfig, 2)
	FileWriteLine($fOpen, 'url:' & $url)
	FileWriteLine($fOpen, 'pass:' & $pass)
	FileWriteLine($fOpen, 'autoLogin:' & $autoLogin)
	FileWriteLine($fOpen, 'autoEnter:' & $autEnter)
	FileWriteLine($fOpen, 'autoSubmit:' & $autoSubmit)
	FileWriteLine($fOpen, 'clearCache:' & $clearCache)
	FileWriteLine($fOpen, 'closeForm:' & $closeForm)
	FileClose($fOpen)
EndFunc   ;==>writeConfig

Func readConfig()
	$iFileExists = FileExists($fileConfig)
	If Not $iFileExists Then
;~ 		RunWait("explorer /root, "& $filePathConfig &"")
		$a = DirCreate($filePathConfig)
		writeConfig()
	EndIf
	Local $data[7]
	$fOpen = FileOpen($fileConfig, 0)
	$data[0] = StringSplit(FileReadLine($fOpen, 1), ':')[2]
	$data[1] = StringSplit(FileReadLine($fOpen, 2), ':')[2]
	$data[2] = StringSplit(FileReadLine($fOpen, 3), ':')[2]
	$data[3] = StringSplit(FileReadLine($fOpen, 4), ':')[2]
	$data[4] = StringSplit(FileReadLine($fOpen, 5), ':')[2]
	$data[5] = StringSplit(FileReadLine($fOpen, 6), ':')[2]
	$data[6] = StringSplit(FileReadLine($fOpen, 7), ':')[2]
;~ 	MsgBox(0,0,$data[2])
	FileClose($fOpen)
	GUICtrlSetData($txtSUrlTarget, $data[0])
	GUICtrlSetData($txtSPassword, $data[1])
	If $data[2] = 'True' Then _Metro_CheckboxCheck($ckSAutoLogin)
	If $data[3] = 'True' Then _Metro_CheckboxCheck($ckCAutoEnterData)
	If $data[4] = 'True' Then _Metro_CheckboxCheck($ckCAutoSubmit)
	If $data[5] = 'True' Then _Metro_CheckboxCheck($ckCClearCache)
	If $data[6] = 'True' Then _Metro_CheckboxCheck($ckCCloseForm)

	Local $aVersion = _IE_VersionInfo()
	Local $sPublicIP = _GetIP()
	$ieVer = $aVersion[5]
	$ieSubVer = $aVersion[3]
	GUICtrlSetData($lblIpIE,'IE Version: ' & $ieVer & ' | SubVersion: '& $ieSubVer &' | Your IP: ' & $sPublicIP)
EndFunc   ;==>readConfig
#EndRegion ===Function Event===

#Region ===Execute Browser===
Func initBrowser()
	_IENavigate($oIE, $urlAddress)
	_IELoadWait($oIE)

	Local $oDiv = _IEGetObjById($oIE, "lst-ib")
	_IEFormElementSetValue($oDiv, "Hey! This works!")
	Local $oForm = _IEGetObjByName($oIE, "f")
	Sleep(3000)

	_IEFormSubmit($oForm)
EndFunc   ;==>initBrowser

#EndRegion ===Execute Browser===
