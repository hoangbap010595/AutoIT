



;~ @CR 	;Xuống dòng trong 1 đoạn text ~ \n
;~ @LF 	;
;~ @CRLF ;

;~ _ViDu()
#include <IE.au3>
#include <File.au3>
#include <Array.au3>

Local $file = "D:/Test.txt"
;~ saveFile()
;~ readFile()
$titleUnikey = '[REGEXPTITLE: (?i)(.*UniKey.*)]'

WinKill($titleUnikey)
Local $iPID = WinGetProcess('UnikeyNT.exe')
; Display the PID of the window.
MsgBox($MB_SYSTEMMODAL, "", "The PID is: " & $iPID)

Func saveFile()
	$hFile = FileOpen($file,2+8+128)
;~ 	_FileCreate($file)

	For $i = 0 To 10 Step 1
		FileWriteLine($file,"Le Cong Hoang|" & $i)
	Next

	Switch $file
		Case "a"
			Break
	EndSwitch

	MsgBox("","Save File","Done")
	FileClose($file)
EndFunc

Func readFile()
	Local $Data
	$hFile = FileOpen($file,0+8+128)

	$Data = FileRead($hFile)
	$ArrayData = StringSplit($Data,'|')

;~ 	MsgBox("","$Data",$Data)
;~ 	MsgBox("","Open File",$ArrayData)
_ArrayDisplay($ArrayData)
	FileClose($hFile)
EndFunc
;~ _OpenLink("google.com")



Func _OpenLink($url)
	Local $oIE =_IECreate($url)
EndFunc

Func _ViDu()

$a = "MessageBox"
$Ho = "Le"
$LOT = "Cong"
$Ten = "Hoang"
$fullName = $Ho &' '& $LOT &' '& $Ten
	MsgBox("",$a,"Hello" & @CRLF &$fullName)
EndFunc
