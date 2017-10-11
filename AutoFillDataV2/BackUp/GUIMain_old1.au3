#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         HoangLe

 Script Function:


#ce ----------------------------------------------------------------------------
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <IE.au3>

#AutoIt3Wrapper_Icon=default.icon

Local $appName = 'Auto Fill Data'
Local $version = '1.0.0'
Local $tilte = $appName & ' ' & $version
Local $aArrayData
Local $filePath = @ScriptDir & '\FileData.xlsx'
Local $fileConfig = @LocalAppDataDir & '\AutoFillData\'& $version & '\config.ini'
Local $filePathConfig = @LocalAppDataDir & '\AutoFillData\'& $version & '\'
Local $countSubmit = 0;
Local $rangeValue = "A1:AD10"
;~ Local $urlAddress = 'http://laodongkynghi.dolab.gov.vn/bizsoft/softdolab/html/formregister'
Local $urlAddress = 'https://www.google.com.vn/'

#Region ### START GUI section ### Form=
$Form1 = GUICreate($tilte, @DesktopWidth - 100, 512, -1, -1);,BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_TABSTOP)

$Group1 = GUICtrlCreateGroup("System", 8, 8, 330, 240)
$Label1 = GUICtrlCreateLabel("Url Target", 31, 33, 51, 17)
Local $txtSUrlTarget = GUICtrlCreateInput("", 85, 28, 245, 21)
Local $txtSPassword = GUICtrlCreateInput("", 85, 58, 245, 21)
$Label2 = GUICtrlCreateLabel("Password", 30, 63, 50, 17)
Local $ckSAutoLogin = GUICtrlCreateCheckbox("Auto Login", 28, 96, 137, 17)
Local $ckCAutoEnterData = GUICtrlCreateCheckbox("Auto Enter Data", 28, 128, 137, 17)
Local $ckCAutoSubmit = GUICtrlCreateCheckbox("Auto Submit", 28, 155, 137, 17)
Local $ckCClearCache = GUICtrlCreateCheckbox("Clear cookie, cache", 28, 184, 137, 17)
Local $ckCCloseForm = GUICtrlCreateCheckbox("Close form after finish", 28, 214, 137, 17)
Local $btnCHelp = GUICtrlCreateButton("Help", 230, 210, 100, 25)
GUICtrlSetCursor (-1, 0)
Local $btnCAbout = GUICtrlCreateButton("About", 230, 180, 100, 25)
GUICtrlSetCursor (-1, 0)
Local $btnCUpdate = GUICtrlCreateButton("Update", 230, 150, 100, 25)
GUICtrlSetCursor (-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group2 = GUICtrlCreateGroup("Data", 8, 250, 330, 111)
Local $txtDFilePath = GUICtrlCreateInput("", 25, 290, 265, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
Local $btnDOpenFile = GUICtrlCreateButton("...", 295, 289, 35, 23, $BS_CENTER)
GUICtrlSetCursor (-1, 0)
$Label3 = GUICtrlCreateLabel("Choose file data (*.xlsx, *.xls)", 25, 270, 138, 17)
Local $btnDView = GUICtrlCreateButton("View", 215, 320, 115, 25)
GUICtrlSetCursor (-1, 0)
Local $btnDGetForm = GUICtrlCreateButton("Get Form", 100, 320, 115, 25)
GUICtrlSetCursor (-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Group3 = GUICtrlCreateGroup("", 8, 365, 330, 141)
Local $btnExit = GUICtrlCreateButton("Exit", 215, 450, 89, 49)
GUICtrlSetCursor (-1, 0)
Local $btnEStop = GUICtrlCreateButton("Stop", 120, 450, 89, 49)
GUICtrlSetCursor (-1, 0)
Local $btnEStart = GUICtrlCreateButton("Start", 25, 450, 89, 49)
GUICtrlSetCursor (-1, 0)
$Label5 = GUICtrlCreateLabel("Submited", 25, 400, 101, 30, $SS_CENTER)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
Local $lblESubmited = GUICtrlCreateLabel("0", 130, 390, 50, 29, $SS_CENTER)
GUICtrlSetFont(-1, 25, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)

Local $oIE = _IECreateEmbedded()
GUICtrlCreateObj($oIE, 350, 15,@DesktopWidth - 460,490)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKRIGHT+$GUI_DOCKTOP+$GUI_DOCKBOTTOM)

GUICtrlSetState($btnEStop, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion ### END GUI section ###
;~ writeConfig()
;load config
readConfig()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Local $OK = MsgBox($MB_OKCANCEL, "Message", "Do you want exit ?")
			If $OK = 1 Then Exit
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
	EndSwitch
WEnd

#Region ===Function Event===
;~ Tab System
; Update config system
Func updateSystem()
	writeConfig()
	MsgBox($MB_TOPMOST, "Message", "Update successfully!")
EndFunc

Func _about()
	$text = 'Application: '& @TAB & $appName & @CR
	$text &= 'Description:' & @TAB & '...' & @CR
	$text &= 'Date:' & @TAB&@TAB & '2017.10.10' & @CR
	$text &= 'Version:' & @TAB&@TAB& $version & @CR
	$text &= 'Author:' & @TAB&@TAB & 'HoangLe' & @CR
	$text &= 'Email:' & @TAB&@TAB & 'lchoang1995@gmail.com' & @CR
	MsgBox($MB_OK,'About',$text,10)
EndFunc

;~ Tab Data
Func openFileExcel()
	$file = FileOpenDialog("Choose file data","%programdata%","Excel (*.xlsx; *.xls)",1)
	If $file <> Null And $file <> '' Then
		GUICtrlSetData($txtDFilePath,$file)
		$oExcel2 = _Excel_Open()
		$oExcel = _Excel_BookOpen($oExcel2,$filePath,True,False)
		$aArrayData = $oExcel.Activesheet.Range($rangeValue).Value
		_ArrayColDelete($aArrayData,1)
		_Excel_BookClose($oExcel)
		_Excel_Close($oExcel2)
	EndIf
EndFunc

Func getFormExcel()
	$folder = FileSelectFolder("Choose folder to save","%programdata%")
	If $folder <> Null And $folder <> '' Then
		FileCopy($filePath,$folder&'\FileData.xlsx')
		Local $OK = MsgBox($MB_OKCANCEL, "Message", "Do you want to open file ?")
		If $OK = 1 Then
			Local $oExcel2 = _Excel_Open()
			$oExcel = _Excel_BookOpen($oExcel2,$filePath)
		EndIf
	EndIf
EndFunc

Func viewDataExcel()
	$file = GUICtrlRead($txtDFilePath)
	If $file <> Null And $file <> '' Then
		If $aArrayData <> Null And UBound($aArrayData) > 0 Then
			_ArrayDisplay($aArrayData, "Data","",16)
		Else
			MsgBox($MB_TOPMOST, "Message", 'File is empty! Not found data.')
		EndIf
	Else
		MsgBox($MB_TOPMOST, "Message", 'File not found. Please choose your file to open!')
	EndIf
EndFunc

;~ Tab Setting
Func _exit()
	Local $OK = MsgBox($MB_OKCANCEL, "Message", "Do you want exit ?")
	If $OK = 1 Then Exit
EndFunc

Func updateSetting()
	writeConfig()
	MsgBox($MB_TOPMOST, "Message", "Update successfully!")
EndFunc

;~ Tab Execute
Func _start()
	GUICtrlSetState($btnEStop, $GUI_ENABLE)
	GUICtrlSetState($btnEStart, $GUI_DISABLE)
	$timeRight = 0
;~ 	$countSubmit = 0;
	initBrowser()
	settingSubmit()
EndFunc

Func _stop()
	GUICtrlSetState($btnEStop, $GUI_DISABLE)
	GUICtrlSetState($btnEStart, $GUI_ENABLE)
	_IEAction($oIE, "stop")
	MsgBox($MB_TOPMOST, "Message", "Stopped IE.")
EndFunc

; Submited
Func settingSubmit()
	$countSubmit += 1
	GUICtrlSetData($lblESubmited,$countSubmit)
EndFunc

; Config
Func writeConfig()
	$url = GUICtrlRead($txtSUrlTarget)
	$pass = GUICtrlRead($txtSPassword)
	$autoLogin = GUICtrlRead($ckSAutoLogin)
	$autEnter = GUICtrlRead($ckCAutoEnterData)
	$autoSubmit = GUICtrlRead($ckCAutoSubmit)
	$clearCache = GUICtrlRead($ckCClearCache)
	$closeForm = GUICtrlRead($ckCCloseForm)

	$fOpen = FileOpen($fileConfig,2)
	FileWriteLine($fOpen,'url:'&$url)
	FileWriteLine($fOpen,'pass:'&$pass)
	FileWriteLine($fOpen,'autoLogin:'&$autoLogin)
	FileWriteLine($fOpen,'autoEnter:'&$autEnter)
	FileWriteLine($fOpen,'autoSubmit:'&$autoSubmit)
	FileWriteLine($fOpen,'clearCache:'&$clearCache)
	FileWriteLine($fOpen,'closeForm:'&$closeForm)
	FileClose($fOpen)
EndFunc

Func readConfig()
	$iFileExists = FileExists($fileConfig)
	If Not $iFileExists Then
;~ 		RunWait("explorer /root, "& $filePathConfig &"")
		$a = DirCreate($filePathConfig)
		writeConfig()
	EndIf
	Local $data[7]
	$fOpen = FileOpen($fileConfig,0)
	$data[0] = StringSplit(FileReadLine($fOpen,1),':')[2]
	$data[1] =	StringSplit(FileReadLine($fOpen,2),':')[2]
	$data[2] =	StringSplit(FileReadLine($fOpen,3),':')[2]
	$data[3] =	StringSplit(FileReadLine($fOpen,4),':')[2]
	$data[4] =	StringSplit(FileReadLine($fOpen,5),':')[2]
	$data[5] =	StringSplit(FileReadLine($fOpen,6),':')[2]
	$data[6] =	StringSplit(FileReadLine($fOpen,7),':')[2]
	FileClose($fOpen)
	GUICtrlSetData($txtSUrlTarget,$data[0])
	GUICtrlSetData($txtSPassword,$data[1])
	GUICtrlSetState($ckSAutoLogin,$data[2])
	GUICtrlSetState($ckCAutoEnterData,$data[3])
	GUICtrlSetState($ckCAutoSubmit,$data[4])
	GUICtrlSetState($ckCClearCache,$data[5])
	GUICtrlSetState($ckCCloseForm,$data[6])
EndFunc
#EndRegion ===End Function Event===

#Region ===Execute Browser===
Func initBrowser()
	_IENavigate($oIE, $urlAddress)
	_IELoadWait($oIE)

	Local $oDiv = _IEGetObjById($oIE, "lst-ib")
	_IEFormElementSetValue($oDiv, "Hey! This works!")
	Local $oForm = _IEGetObjByName($oIE, "f")
	Sleep(3000)

	_IEFormSubmit($oForm)
EndFunc

#EndRegion ===End Browser===