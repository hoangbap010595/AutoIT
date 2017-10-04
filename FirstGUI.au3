#include <File.au3>
#include <GUIConstants.au3>


loadGUI()

Func loadGUI()
	Local $Form

	GUICreate("First GUI",600,400,100,100)
	Local $ButtonCancel = GUICtrlCreateButton("Kết thúc",20,350,100,30)
	Local $ButtonHello = GUICtrlCreateButton("ShowMessage",140,350,100,30)
	GUICtrlCreateCheckbox("Check Box",10,10,100,30,2)
	GUICtrlCreateCombo("ComBoBox",115,10,100,30)
	GUICtrlCreateDate("",220,10,300,30)
	GUICtrlCreateGraphic(10,50,200,20)
	Local $txtInput = GUICtrlCreateInput("haha",20,40,300,20)

	GUICtrlCreateTab(10,100,200,100)
	GUICtrlCreateTabItem("afe")
	GUICtrlCreateTabItem("afegfsdfg")

;~ 	Hiển thị GUI
	GUISetState()

	While True
;~ 		Gán MessageBox vào GUI
		$Form = GUIGetMsg()

		IF $Form = $GUI_EVENT_CLOSE Then ExitLoop

		IF $Form = $ButtonCancel Then ExitLoop
		IF $Form = $ButtonHello Then _callFunction($txtInput)
	WEnd

	MsgBox(0,"Thông báo","Thoát chương trình ?",10)
EndFunc

Func _callFunction($txtInput)
	Local $mess
	$mess = GUICtrlRead($txtInput)

;~ 	Gán giá trị vào control
;~ 	UICtrlSetData($txtInput,$mess)

	MsgBox(1, "Hello", $mess)
EndFunc
