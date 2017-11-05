#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

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
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <Inet.au3>

Local $appName = 'Sunfrog Shirts'
Local $version = '1.0.0'
Local $tilte = $appName & ' ' & $version
Local $minWidthForm = @DesktopWidth -200
Local $minHeightForm = @DesktopHeight - 200
#Region ===Create GUI===

_Metro_EnableHighDPIScaling()
_SetTheme("DarkGreenV2")

$Form1 = _Metro_CreateGUI($tilte, $minWidthForm, $minHeightForm, -1, -1)
_Metro_SetGUIOption($Form1, True, False,$minWidthForm, $minHeightForm)
;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True
$Control_Buttons = _Metro_AddControlButtons(True,False,True)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
;~ $GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
;~ $GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
;~ $GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]

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
	EndSwitch
WEnd