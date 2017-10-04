#include <Array.au3>
#include <MsgBoxConstants.au3>

_PixelSearch()

Func _PixelSearch()
;~ 	$aArray =	WinList("[REGEXPTITLE:(?i)(.*SciTE.*|.*Google Chrome.*)]")
;~ 	_ArrayDisplay($aArray)
	Run("notepad.exe")
	WinWaitActive("Untitled - Notepad")
	Send("This is some text.")
	WinClose("Untitled - Notepad")
	WinWaitActive("Notepad", "Save")
	;WinWaitActive("Notepad", "Do you want to save") ; When running under Windows XP
	Send("!n")
EndFunc