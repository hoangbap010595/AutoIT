#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         HoangLC

 Script Function:
	Create GUI.

#ce ----------------------------------------------------------------------------
#include <GUIInfomation.au3>

;~ =========================Create GUI=============================
Local $hGUI = createGUI(2);~ Display Center

;~ =========================Add Control GUI=============================
GUICtrlCreateLabel("Hello world! How are you?", 30, 10)

Local $iOKButton = GUICtrlCreateButton("OK", 70, 50, 60)
Local $iCancelButton = GUICtrlCreateButton("Cancel", 140, 50, 60)


Func _excecuteEvent(ByRef $iMsg)
	Switch $iMsg
        Case $iOKButton
            MsgBox($MB_SYSTEMMODAL, $TitleMessage, "You selected the OK button.")
		Case $iCancelButton
            MsgBox($MB_SYSTEMMODAL, $TitleMessage, "You selected the Cancel button.")
		Case $GUI_EVENT_CLOSE
			Local $OK = MsgBox($MB_OKCANCEL, $TitleMessage, "Đóng ứng dụng ?")
			If $OK = 1 Then Exit
	EndSwitch
EndFunc
;~ End
;~ =========================Apply and Show GUI=============================
GUISwitch($hGUI)
GUISetState(@SW_SHOW, $hGUI)
Local $iMsg = 0
While 1
    $iMsg = GUIGetMsg()
	_excecuteEvent($iMsg)
WEnd
;~ End