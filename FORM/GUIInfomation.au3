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

Global $AppTitle = $_APPNAME & ' ' & $_VERSION
Global $AppWidth = 300
Global $AppHeight = 600
Global $AppPosX = @DesktopWidth - $AppWidth -5
Global $AppPosY = 0

;~ MessageBox
Global $TitleMessage = "Thông báo"
