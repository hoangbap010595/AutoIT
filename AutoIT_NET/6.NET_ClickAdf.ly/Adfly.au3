
#NoTrayIcon
#include "..\..\MetroGUI\MetroGUI_UDF.au3"
#include "..\..\MetroGUI\_GUIDisable.au3"
#include <_HttpRequest.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <Inet.au3>

Local $appName = 'Click Adf.ly'
Local $version = '1.0.0'
Local $tilte = $appName & ' ' & $version
Local $minWidthForm = 400
Local $minHeightForm = @DesktopHeight - 200
Local $imgApp = @ScriptDir &"\image.jpg"

#Region ===Create GUI===
_Metro_EnableHighDPIScaling()
_SetTheme("DarkGreenV2")
;~ _SetTheme("LightGreen")
$Form1 = _Metro_CreateGUI($tilte, $minWidthForm, $minHeightForm, -1, -1)
_Metro_SetGUIOption($Form1, True, False,$minWidthForm, $minHeightForm)
;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
$Control_Buttons = _Metro_AddControlButtons(True,False,True,False,False)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
;~ $GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
;~ $GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
;~ $GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]


;~ $Pic1 = GUICtrlCreatePic($imgApp, 50, 40, 300, 300)
$Group1 = GUICtrlCreateGroup("",5,30,390,125)
$txtUsername = GUICtrlCreateInput("", 10, 50, 280, 40)
GUICtrlSetFont(-1, 16, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $ButtonBKColor);0x800080
GUICtrlSetTip(-1, "Username")
$txtPassword = GUICtrlCreateInput("", 10, 100, 280, 40, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
GUICtrlSetFont(-1, 16, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $ButtonBKColor);0x800080
GUICtrlSetTip(-1, "Password")
;~ $ckRemember = _Metro_CreateCheckboxEx2("Remember Login", 10, 154, 150, 25)
;~ GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
GUICtrlCreateLabel($tilte, 10, 5, 300, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Segoe UI")
GUICtrlSetColor(-1, $FontThemeColor);0xFFFFFF
$btnLogin = _Metro_CreateButtonEx2("Login", 295, 47, 95, 95, $ButtonBKColor,'0xFFFFFF', 'Segoe UI', 12)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ===End Create GUI===

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
;~ 		Case $ckRemember
;~ 			If _Metro_CheckboxIsChecked($ckRemember) Then
;~ 				_Metro_CheckboxUnCheck($ckRemember)
;~ 				ConsoleWrite("Checkbox unchecked!" & @CRLF)
;~ 			Else
;~ 				_Metro_CheckboxCheck($ckRemember)
;~ 				ConsoleWrite("Checkbox checked!" & @CRLF)
;~ 			EndIf
		Case $btnLogin
			 _Metro_MsgBox(1, "Message", "Login successfully!", 300, 11, $Form1)
	EndSwitch
WEnd
