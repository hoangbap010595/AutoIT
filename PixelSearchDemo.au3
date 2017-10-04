#include <Array.au3>
#include <MsgBoxConstants.au3>

_PixelSearch()

Func _PixelSearch()
	Local $pos = PixelSearch(0,0,@DesktopWidth,@DesktopHeight, '0xFFFFFF')
	ConsoleWrite($pos[0] &'-'&$pos[1])
EndFunc