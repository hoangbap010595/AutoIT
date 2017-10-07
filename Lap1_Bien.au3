
#include <GUIConstants.au3>
#include <File.au3>
#include <AutoItConstants.au3>
#include <ImageSearch.au3>

;~ _Lap1_Bien()
;~ _Lap2_Mang()
;~ _Lap3_Loop()
;~ _Lap4_String()
;~ _Lap5_File()
;~ _Lap6_Mouse()
;~ _Lap7_KeyBoard()
_Lap8_Window()
;~ _Lap9_PixcelSearch()

Func _Lap1_Bien()

;~ 	Đặt tên biến
;~ Khai báo biến
	Local $x
;~ 	Khai báo biến gán giá trị
	Local $y = 1995

;~ 	Screen Width Height
	Local $width = @DesktopWidth
	Local $height = @DesktopHeight
;~ Lấy đương dẫn thu mục hiện tại
	Local $var = @ScriptDir
	$var = @ScriptFullPath
	$var = @ScriptLineNumber
	$var = @ScriptName

;~ Ngày và giờ
	$var = @SEC
	$var = @MDAY & '-' & @MON & '-' & @YEAR



	MsgBox(0,"Show kết quả",$var)
;~ 	MsgBox(0,"Show", $width & 'x' & $height)
EndFunc

Func _Lap2_Mang()
;~ 	Khai báo mảng rồi gán giá trị
	Local $arr[10]
	$arr[0] = 'Phần tử thứ 1'
	$arr[1] = 'Phần tử thứ 2'
	$arr[2] = 'Phần tử thứ 3'
	$arr[9] = 'Phần tử thứ 10'


	Dim $arr2[5] = [1,3,4,'23',4]

	MsgBox(0,"Show kết quả",$arr2[1])
EndFunc

Func _Lap3_Loop()
;~ 	If điều kiện
;~ 		Câu lệnh 1
;~ 		Câu lệnh 2
;~ 	Else
;~ 		Câu lệnh 1
;~ 		Câu lệnh 2
;~ 	EndIf

Local $x = 4
	Switch $x
		Case 1
			ConsoleWrite("Case 1")
		Case 2
			ConsoleWrite("Case 2")
		Case 3
			ConsoleWrite("Case 3")
		Case Else
			ConsoleWrite("Case Else")
	EndSwitch
;~ Vòng lặp for
	For $i = 0 To $x Step 1
		ConsoleWrite("Vòng lặp: " & $i & @CR)
;~ 		Exit = Break ..Thoát khỏi vòng lặp
	Next

;~ Vòng lặp While
	While $x > 0
		ConsoleWrite("Vòng lặp While: " & $x & @CR)
		$x = $x - 1
;~ 		ExitLoop = Break ..Thoát khỏi vòng lặp
	WEnd

EndFunc

Func _Lap4_String()
;~ 	StringLeft
;~ 	StringRight
;~ 	StringLen
;~ 	StringSplit
;~ 	StringRegExp
	$string = StringRegExp("Le Cong Hoang", "Le (.*?) Hoang",1)
	ConsoleWrite($string & @CR)
EndFunc

Func _Lap5_File()
	Local $file = @ScriptDir&'\file.txt'
;~ 	Ghi de file
;~ 	FileWrite($file,"Hoang dang hoc AutoIT")
;~ 	Ghi theo từng dòng file
;~ 	FileWriteLine($file,"Hoang dang hoc AutoIT2")

;~ 	$read = FileRead($file) Đọc file
;~ 	$read = FileReadLine($file,2) Đọc theo dòng

;~ 	$read = _FileCountLines($file) Đếnm số dòng

;~ 	FileDelete($file) Xóa file

;~ 	FileOpen($file,0) 0: Đọc, 1: Ghi thêm nội dung, 2: Xóa dữ liệu ghi mới
;~ 	FileOpen($file,0)
;~ 	$read = FileWriteLine($file,"Hoang dang hoc AutoIT")
;~ 	FileClose($file)

	$file = FileOpenDialog("Chọn file",@AppDataDir,"Excel(*.xlsx)|Excel(*.xls)|All(*.*)")
	$read = FileRead($file)
	ConsoleWrite($read)
	ConsoleWrite(@CR&'DONE'&@CR)
EndFunc

Func _Lap6_Mouse()
;~ 	MouseClick("right",117,40,1)
;~ 	Sleep(3000)
;~ 	MouseClick("right",35,36,1)
;~ 	Sleep(3000)
;~ 	MouseClick("left",857, 879,1)
;~ 	MouseMove(857, 879)
;~ 	MouseDown($MOUSE_CLICK_LEFT)
;~ 	Sleep(3000)
;~ 	MouseUp($MOUSE_CLICK_LEFT)
;~ 	Scroll leen xuoong
	MouseWheel($MOUSE_WHEEL_UP, 10)
	Sleep(1000)
	MouseWheel($MOUSE_WHEEL_DOWN, 10)
EndFunc

Func _Lap7_KeyBoard()
;~ 	Giar lap bàn phíM
;~ 	MouseClick("main",541, 215)
;~ 	Send("Auto Post Status")
;~ 	Send('{Enter}')
;~ 	Sleep(1000)
;~ 	Send("Auto Post Status2")
;~ 	Send('{Enter}')
;~ 	Sleep(1000)
	MouseClick("main",51, 215)
	ControlClick("file.txt - Notepad", '[CLASS:Edit; INSTANCE:1]',"left",1)
	Sleep(1000)
	Send('^a')
	Send('{Delete}')
	Sleep(1000)
	ControlSend("file.txt - Notepad","", '[CLASS:Edit; INSTANCE:1]',"Hoang dang học AutoIT")
;~ 	MouseMove(831, 521)
EndFunc

Func _Lap8_Window()
;~ 	WinActivate('file.txt - Notepad')
;~ 	WinWait('file.txt - Notepad')
;~ 	WinMove('file.txt - Notepad','',0,0)
;~ 	WinSetState('file.txt - Notepad', "",@SW_ENABLE)
;~ 	WinSetTitle('file.txt - Notepad','', 'Le Cong Hoang')

;~ 	$u = ProcessList("UniKeyNT.exe")
;~ 	$pid = $u[1][1]
;~ 	MsgBox(0,0,$pid)
;~ 	WinActivate('UniKey 4.2 RC4')
;~ 	WinClose("UniKey 4.2 RC4")
;~ 	$pid = WinGetProcess('UniKeyNT.exe')
;~ 	WinKill('UniKeyNT.exe')
;~ 	WinSetOnTop($title,"",1)
;~ 	MsgBox(0,0,$pid)

EndFunc

Func _Lap9_PixcelSearch()
	$rs = PixelSearch(415, 100,760,@DesktopHeight-200,'0x4267B2')
	if IsArray($rs) Then MouseMove($rs[0],$rs[1])
EndFunc



















