

#include "JSON.au3"
#include <MsgBoxConstants.au3>

Local $fileName = 'C:\Users\HoangLe\Desktop\AutoIT\trunk\AutoIT_NET\10.NET_SunfrogShirt\result.txt'
Local $dataTemp = '{theme: 1, color: "yellow", status: 200}'
Local $arr = ['mot','hai','Ba']

Local $temp  = jsonFile($fileName)

test()
Func test()
;~ 	$object = Json_Decode(Json_Encode($temp))
;~ 	MsgBox(0,0, $object)

;~ 	$data = Json_ObjGetKeys($object)
;~ 	MsgBox(0,0, $data)
	$data2  = Json_Encode($arr)
	MsgBox(0,0, $data2)
EndFunc

Func jsonFile($filePath)
	$file = FileOpen($filePath,0)
	$data = FileRead($file)
	FileClose($file)
	Return $data
EndFunc

