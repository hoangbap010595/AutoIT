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
#include <Timers.au3>
#include <Date.au3>

#Region ### START Koda GUI section ### Form=
Local $aArray
Local $filePath = @ScriptDir & '\FileData.xlsx'
Local $timeRight = 0
Global $countSubmit = 0;
Local $appName = 'Auto Fill Data'
Local $version = '1.0.0'

$Form1 = GUICreate($appName & ' ' & $version, 722, 312, -1, -1)
$Group1 = GUICtrlCreateGroup("System", 8, 8, 329, 121)
$btnSUpdate = GUICtrlCreateButton("Update", 232, 88, 90, 25)
GUICtrlSetCursor (-1, 0)
$Label1 = GUICtrlCreateLabel("Url Target", 31, 33, 51, 17)
$txtSUrlTarget = GUICtrlCreateInput("", 85, 28, 240, 21)
$txtSPassword = GUICtrlCreateInput("", 85, 58, 240, 21)
$Label2 = GUICtrlCreateLabel("Password", 30, 63, 50, 17)
$ckSAutoLogin = GUICtrlCreateCheckbox("Auto Login", 32, 96, 137, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Data", 352, 8, 345, 121)
$txtDFilePath = GUICtrlCreateInput("", 360, 49, 289, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$btnDOpenFile = GUICtrlCreateButton("...", 656, 48, 35, 22, $BS_CENTER)
GUICtrlSetCursor (-1, 0)
$Label3 = GUICtrlCreateLabel("Choose file data (*.xlsx, *.xls)", 363, 27, 138, 17)
$btnDView = GUICtrlCreateButton("View", 573, 87, 115, 25)
GUICtrlSetCursor (-1, 0)
$btnDGetForm = GUICtrlCreateButton("Get Form", 445, 87, 115, 25)
GUICtrlSetCursor (-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Setting", 8, 144, 329, 153)
$ckCAutoEnterData = GUICtrlCreateCheckbox("Auto Enter Data", 28, 168, 137, 17)
$ckCAutoSubmit = GUICtrlCreateCheckbox("Auto Submit", 28, 195, 137, 17)
$ckCClearCache = GUICtrlCreateCheckbox("Clear cookie, cache", 28, 224, 137, 17)
$ckCCloseForm = GUICtrlCreateCheckbox("Close form after finish", 28, 254, 137, 17)
$btnExit = GUICtrlCreateButton("Exit", 232, 240, 89, 49)
GUICtrlSetCursor (-1, 0)
$btnCUpdate = GUICtrlCreateButton("Update", 232, 160, 89, 25)
GUICtrlSetCursor (-1, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 352, 144, 345, 153)
$btnEStop = GUICtrlCreateButton("Stop", 367, 240, 89, 49)
GUICtrlSetCursor (-1, 0)
$btnEStart = GUICtrlCreateButton("Start", 367, 168, 89, 49)
GUICtrlSetCursor (-1, 0)
$Label4 = GUICtrlCreateLabel("Time", 480, 160, 200, 29, $SS_CENTER)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
$Label5 = GUICtrlCreateLabel("Submited", 484, 222, 191, 29, $SS_CENTER)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
$lblESubmited = GUICtrlCreateLabel("0", 481, 257, 200, 29, $SS_CENTER)
GUICtrlSetFont(-1, 15, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
$lblETime = GUICtrlCreateLabel("0s", 480, 192, 203, 29, $SS_CENTER)
GUICtrlSetFont(-1, 15, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;load config
readConfig()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Local $OK = MsgBox($MB_OKCANCEL, "Message", "Do you want exit ?")
			If $OK = 1 Then Exit
		Case $btnSUpdate
			updateSystem()
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
		Case $btnEStart
			_start()
		Case $btnEStop
			_stop()
	EndSwitch
WEnd

;~ Tab System
; Update config system
Func updateSystem()
	writeConfig()
	MsgBox($MB_TOPMOST, "Message", "Update successfully!")
EndFunc

;~ Tab Data
Func openFileExcel()
	$file = FileOpenDialog("Choose file data","%programdata%","Excel (*.xlsx; *.xls)",1)
	GUICtrlSetData($txtDFilePath,$file)
	Local $oExcel2 = _Excel_Open()
	$oExcel = _Excel_BookOpen($oExcel2,$filePath,False,False)
	$aArray = $oExcel.Activesheet.Range("A1:AD10").Value
	_ArrayColDelete($aArray,1)
	_Excel_BookClose($oExcel)
	_Excel_Close($oExcel2)
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
		_ArrayDisplay($aArray, "$aArray","",16)
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
	$timeRight = 0
;~ 	$countSubmit = 0;
	settingSubmit()
EndFunc

Func _stop()
	MsgBox($MB_TOPMOST, "Message", "_stop")
EndFunc

; Timer
Func settingTimer()
	$timeRight += 1
	GUICtrlSetData($lblETime,$timeRight & 's')
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

	$file = @ScriptDir&'\config.ini'
	$fOpen = FileOpen($file,2)
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
	Local $data[7]
	$file = @ScriptDir&'\config.ini'
	$fOpen = FileOpen($file,0)
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