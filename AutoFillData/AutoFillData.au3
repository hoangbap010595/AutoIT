#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <Excel.au3>
#include <MsgBoxConstants.au3>



HotKeySet("{esc}", '_exit')
HotKeySet("{F4}", "OpenChrome")
HotKeySet("{F7}", "ReadExcel")
HotKeySet("{F8}", "EnterData")
HotKeySet("{F9}", "NextValue")
$title = "[REGEXPTITLE: (?i)(.*Google Chrome.*)]"
$count = 0
$filePathExcel = ""
Local $i = 1
Local $j = 1
Local $aArray = Null
Local $tooltip = "[Starting] Đang thực hiện nhập dữ liệu" & @CR
		$tooltip = $tooltip & @TAB &"[ESC]: Kết thúc"& @CR
		$tooltip = $tooltip & @TAB &"[F4]: Mở Chrome"& @CR
		$tooltip = $tooltip & @TAB &"[F7]: Mở file Excel"& @CR
		$tooltip = $tooltip & @TAB &"[F8]: Enter dữ liệu"& @CR
		$tooltip = $tooltip & @TAB &"[F9]: Bỏ qua"& @CR
		$tooltip = $tooltip & "[----------------------------------------]"& @CR
Local $text = $tooltip
ToolTip($text,0,0)
Sleep(3000)

Func _exit()
	Exit
EndFunc

Func EnterData()
	$value = $aArray[$i][$j]
	$nextValue = $aArray[$i+1][$j]
	$col = $aArray[$i+1][0]
	ControlSend($title,"",0,$value)
	$text = $text & '['&$j&'] '& $value & @CR & "[Next]---[" & $col & "]:" & $nextValue & @CR
	ToolTip($text,0,0)
	$i+= 1
	If $aArray[$i][0] = "END" Then
		$j += 1
		$i = 1
		$text = $tooltip
	EndIf
EndFunc

Func NextValue()
	$value = $aArray[$i][$j]
	$nextValue = $aArray[$i+1][$j]
	$col = $aArray[$i+1][0]
;~ 	ControlSend($title,"",0,$value)
	$text = $text & '['&$j&'] '& $value & @CR & "[Next]---[" & $col & "]:" & $nextValue & @CR
	ToolTip($text,0,0)
	$i+= 1
	If $aArray[$i][0] = "END" Then
		$j += 1
		$i = 1
		$text = $tooltip
	EndIf
EndFunc

Func OpenChrome()
	TrayItemSetState('UniKey 4.2 RC4',0)
	Send("#r")
	Sleep(200)
	Send("Chrome.exe{enter}")
;~ 	Run("chrome.exe")
	$wait = WinWait($title)
	WinActivate($wait)
	WinMove($wait,"",100,0)
	Sleep(2000)
 	ControlClick($wait,"",0,"left",1,400,60)
;~ 	ControlSend($wait,"",0,"^a")
	ControlSend($wait,"",0,"http://laodongkynghi.dolab.gov.vn/bizsoft/softdolab/html/formregister{enter}")
	$text = $text & "[F4] Mở chrome thành công"& @CR
	$text = $text & "[----------------------------------------]"& @CR
	ToolTip($text,0,0)
EndFunc

Func ReadExcel()
	Local $oExcel2 = _Excel_Open()
	$oExcel = _Excel_BookOpen($oExcel2,@ScriptDir & "\FileImportData.xlsx",False,False)
	$aArray = $oExcel.Activesheet.Range("A1:AD10").Value
	_ArrayColDelete($aArray,1)
;~ 	If IsArray($aArray) Then _ArrayDisplay($aArray, "$aArray","",0)
	_Excel_BookClose($oExcel)
	_Excel_Close($oExcel2)
	$text = $text & "[F7] Mở file excel thành công" & @CR
	$text = $text & "[----------------------------------------]"& @CR
	ToolTip($text,0,0)
EndFunc

While 1
;~ 	$FullName = "Le Cong Hoang"
WEnd


