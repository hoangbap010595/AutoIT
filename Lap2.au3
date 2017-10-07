#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.15.0 (Beta)
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <MsgBoxConstants.au3>

; Counting the number of open shell windows
;~ _func3()

Example()

Func Example()
;~     Beep(5000)
	SoundPlay("E:\ImageDesign\Sound\game_5_screen_background_sound.mp3",1)
EndFunc   ;==>Example


Func _func1()
	Local $oExcel = ObjCreate("Excel.Application") ; Create an Excel Object
	$oExcel.Visible = 1 ; Let Excel show itself
	$oExcel.WorkBooks.Add ; Add a new workbook
	$oExcel.ActiveWorkBook.ActiveSheet.Cells(1, 1).Value = "Text" ; Fill a cell
	Sleep(4000) ; Display the results for 4 seconds
	$oExcel.ActiveWorkBook.Saved = 1 ; Simulate a save of the Workbook
	$oExcel.Quit ; Quit Excel
EndFunc

Func _func2()
	Local $sString = "" ; A string for displaying purposes
	Local $aArray[4]
	$aArray[0] = "A" ; We fill an array
	$aArray[1] = 0 ; with several
	$aArray[2] = 1.3434 ; different
	$aArray[3] = "Example Text" ; example values.

	For $iElement In $aArray ; Here it starts...
		$sString &= $iElement & @CRLF
	Next

	; Display the results
	MsgBox($MB_OK, "For..In Array Example", "Result: " & @CRLF & $sString)
EndFunc

Func _func3()
	Local $oExcel = ObjCreate("Excel.Application") ; Create an Excel Object

	$oExcel.Visible = 1 ; Let Excel show itself
	$oExcel.WorkBooks.Add ; Add a new workbook

	Local $aArray[16][16] ; These lines
	For $i = 0 To 15 ; are just
		For $j = 0 To 15 ; an example to
			$aArray[$i][$j] = $i ; create some
		Next ; cell contents.
	Next

	$oExcel.activesheet.range("A1:O16").value = $aArray ; Fill cells with example numbers

	Sleep(2000) ; Wait a while before continuing

	For $iCell In $oExcel.ActiveSheet.Range("A1:O16")
		If $iCell.Value < 5 Then
			$iCell.Value = 0
		EndIf
	Next

	$oExcel.ActiveWorkBook.Saved = 1 ; Simulate a save of the Workbook
	Sleep(2000) ; Wait a while before closing
;~ 	$oExcel.Quit ; Quit Excel
EndFunc