#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <MsgBoxConstants.au3>

; Press Esc to terminate script, Pause/Break to "pause"

Global $g_bPaused = False

HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("+!d", "ShowMessage") ; Shift-Alt-d

Func TogglePause()
    $g_bPaused = Not $g_bPaused
    While $g_bPaused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
    Exit
EndFunc   ;==>Terminate

Func ShowMessage()
    MsgBox($MB_SYSTEMMODAL, "", "This is a message.")
EndFunc   ;==>ShowMessage


;~ While 1
;~ 	$findZombie = PixelSearch(349, 306,948, 632,'0xCC0000')
;~ 	If IsArray($findZombie) Then MouseClick("main",$findZombie[0]+4,$findZombie[1]+4 )
;~ 	$NapDan = PixelSearch(325, 600,353, 680,'0xFFFFBF')
;~ 	If IsArray($NapDan) = False Then
;~ 		Sleep(800)
;~ 		Send('{Space}')
;~ 	EndIf
;~ WEnd

While 1
	$findZombie = PixelSearch(437, 337,869, 585,'0x895F57')
	If IsArray($findZombie) Then MouseClick("main",$findZombie[0],$findZombie[1])
	$findZombie2 = PixelSearch(437, 337,869, 585,'0x756714')
	If IsArray($findZombie2) Then MouseClick("main",$findZombie2[0],$findZombie2[1])

	$findZombie3 = PixelSearch(437, 337,869, 585,'0x765647')
	If IsArray($findZombie3) Then MouseClick("main",$findZombie3[0],$findZombie3[1])

	$NapDan = PixelSearch(302, 628,325, 659,'0xE8E6E6')
	If IsArray($NapDan) = False Then
		MouseClick("main",338, 592)
	EndIf
WEnd