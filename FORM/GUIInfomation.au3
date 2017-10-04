#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

Local $_APPNAME = "ApplicationName"
Local $_VERSION = "v1.0.0"

;~ Form
Global $AppTitle = $_APPNAME & ' ' & $_VERSION
Global $AppWidth = 300
Global $AppHeight = 600
Global $AppPosX = 0
Global $AppPosY = 0

;~ MessageBox
Global $TitleMessage = "Thông báo"



Func createGUI(Const ByRef $startPos);~ 0. Default, 1. Left, 2. Right, 3.Center
	Local $hGUI
	Switch $startPos
		Case 0
			$AppPosX = 100
			$AppPosY = 50
			$hGUI = GUICreate($AppTitle, $AppWidth, $AppHeight,$AppPosX,$AppPosY)
		Case 1
			$AppPosX = 0
			$AppPosY = 0
			$hGUI = GUICreate($AppTitle, $AppWidth, $AppHeight,$AppPosX,$AppPosY)
		Case 2
			$AppPosX = @DesktopWidth - $AppWidth -5
			$AppPosY = 0
			$hGUI = GUICreate($AppTitle, $AppWidth, $AppHeight,$AppPosX,$AppPosY)
		Case 3
			$AppPosX = (@DesktopWidth / 2)- ($AppWidth / 2)
			$AppPosY = (@DesktopHeight / 2) - ($AppHeight /2)
			$hGUI = GUICreate($AppTitle, $AppWidth, $AppHeight,$AppPosX,$AppPosY)
	EndSwitch
	Return $hGUI
EndFunc