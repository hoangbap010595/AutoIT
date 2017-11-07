#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.2
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include "../../JSON/JSON.au3"
#include <MsgBoxConstants.au3>
#include <Array.au3>

Global $maxRowUpload = 100
Global $arrCategoryProduct[22][2]
Global $arrCategoryShirt[21][3]
Global $arrDataUpload[$maxRowUpload][8]


;~ Local $arr = 'mot,hai,ba'
;~ Local $strJon = ['{"id":8,"name":"Guys Tee","price":19,"colors":["Yellow"]', '{"id":12,"name":"Guys Tee","price":31,"colors":["Green"]']

addCategoryGroup()
addCategoryShirt()


;~ _ArrayDisplay($arrCategoryProduct)
;~ _ArrayDisplay($arrCategoryShirt)

;~ MsgBox(0,0, UBound($arrCategoryProduct))
;~ MsgBox(0,0, getIDCatoryProduct("Hobby"))

;~ MsgBox(0,0, convertArrayToJson($arr))

Func convertStringToJson($text)
	$arrayRs = StringSplit($text, ',')
	_ArrayDelete($arrayRs, 0)
	$data = Json_Encode($arrayRs)
	Return $data
EndFunc   ;==>convertStringToJson

Func getIDCatoryProduct($name)
	$id = -1
	For $i = 0 To 22 Step 1
		$temp = $arrCategoryProduct[$i][1]
		If $temp = String($name) Then
			$id = $arrCategoryProduct[$i][0]
			Return $id
		EndIf
	Next
	Return $id
EndFunc   ;==>getIDCatoryProduct

Func addCategoryGroup()
	$arrCategoryProduct[0][0] = 52
	$arrCategoryProduct[0][1] = 'Automotive'
	$arrCategoryProduct[1][0] = 76
	$arrCategoryProduct[1][1] = 'Birth Years'
	$arrCategoryProduct[2][0] = 78
	$arrCategoryProduct[2][1] = 'Drinking'
	$arrCategoryProduct[3][0] = 26
	$arrCategoryProduct[3][1] = 'Faith'
	$arrCategoryProduct[4][0] = 61
	$arrCategoryProduct[4][1] = 'Fitness'
	$arrCategoryProduct[5][0] = 19
	$arrCategoryProduct[5][1] = 'Funny'
	$arrCategoryProduct[6][0] = 13
	$arrCategoryProduct[6][1] = 'Gamer'
	$arrCategoryProduct[7][0] = 24
	$arrCategoryProduct[7][1] = 'Geek-Tech'
	$arrCategoryProduct[8][0] = 82
	$arrCategoryProduct[8][1] = 'Hobby'
	$arrCategoryProduct[9][0] = 35
	$arrCategoryProduct[9][1] = 'Holidays'
	$arrCategoryProduct[10][0] = 79
	$arrCategoryProduct[10][1] = 'Jobs'
	$arrCategoryProduct[11][0] = 43
	$arrCategoryProduct[11][1] = 'LifeStyle'
	$arrCategoryProduct[12][0] = 12
	$arrCategoryProduct[12][1] = 'Movies'
	$arrCategoryProduct[13][0] = 71
	$arrCategoryProduct[13][1] = 'Music'
	$arrCategoryProduct[14][0] = 75
	$arrCategoryProduct[14][1] = 'Names'
	$arrCategoryProduct[15][0] = 81
	$arrCategoryProduct[15][1] = 'Outdoor'
	$arrCategoryProduct[16][0] = 62
	$arrCategoryProduct[16][1] = 'Pets'
	$arrCategoryProduct[17][0] = 17
	$arrCategoryProduct[17][1] = 'Political'
	$arrCategoryProduct[18][0] = 27
	$arrCategoryProduct[18][1] = 'Sports'
	$arrCategoryProduct[19][0] = 77
	$arrCategoryProduct[19][1] = 'States'
	$arrCategoryProduct[20][0] = 34
	$arrCategoryProduct[20][1] = 'TV Shows'
	$arrCategoryProduct[21][0] = 11
	$arrCategoryProduct[21][1] = 'Zombies'
EndFunc   ;==>addCategoryGroup

Func addCategoryShirt()
	$arrCategoryShirt[0][0] = 8
	$arrCategoryShirt[0][1] = 'Guys Tee'
	$arrCategoryShirt[0][2] = 19
	$arrCategoryShirt[1][0] = 34
	$arrCategoryShirt[1][1] = 'Ladies Tee'
	$arrCategoryShirt[1][2] = 19
	$arrCategoryShirt[2][0] = 35
	$arrCategoryShirt[2][1] = 'Youth Tee'
	$arrCategoryShirt[2][2] = 19
	$arrCategoryShirt[3][0] = 19
	$arrCategoryShirt[3][1] = 'Hoodie'
	$arrCategoryShirt[3][2] = 34
	$arrCategoryShirt[4][0] = 27
	$arrCategoryShirt[4][1] = 'Sweat Shirt'
	$arrCategoryShirt[4][2] = 31
	$arrCategoryShirt[5][0] = 50
	$arrCategoryShirt[5][1] = 'Guys V-Neck'
	$arrCategoryShirt[5][2] = 23
	$arrCategoryShirt[6][0] = 116
	$arrCategoryShirt[6][1] = 'Ladies V-Neck'
	$arrCategoryShirt[6][2] = 23
	$arrCategoryShirt[7][0] = 118
	$arrCategoryShirt[7][1] = 'Unisex Tank Top'
	$arrCategoryShirt[7][2] = 19
	$arrCategoryShirt[8][0] = 119
	$arrCategoryShirt[8][1] = 'Unisex Long Sleeve'
	$arrCategoryShirt[8][2] = 25
	$arrCategoryShirt[9][0] = 120
	$arrCategoryShirt[9][1] = 'Leggings'
	$arrCategoryShirt[9][2] = 14
	$arrCategoryShirt[10][0] = 129
	$arrCategoryShirt[10][1] = 'Coffee Mug (colored)'
	$arrCategoryShirt[10][2] = 14
	$arrCategoryShirt[11][0] = 129
	$arrCategoryShirt[11][1] = 'Coffee Mug (white)'
	$arrCategoryShirt[11][2] = 14
	$arrCategoryShirt[12][0] = 145
	$arrCategoryShirt[12][1] = 'Coffee Mug (color change)'
	$arrCategoryShirt[12][2] = 14
	$arrCategoryShirt[13][0] = 137
	$arrCategoryShirt[13][1] = 'Posters 16x24'
	$arrCategoryShirt[13][2] = 14
	$arrCategoryShirt[14][0] = 137
	$arrCategoryShirt[14][1] = 'Posters 16x24'
	$arrCategoryShirt[14][2] = 14
	$arrCategoryShirt[15][0] = 138
	$arrCategoryShirt[15][1] = 'Posters 24x16'
	$arrCategoryShirt[15][2] = 14
	$arrCategoryShirt[16][0] = 139
	$arrCategoryShirt[16][1] = 'Posters 11x17'
	$arrCategoryShirt[16][2] = 14
	$arrCategoryShirt[17][0] = 140
	$arrCategoryShirt[17][1] = 'Posters 17x11'
	$arrCategoryShirt[17][2] = 14
	$arrCategoryShirt[18][0] = 143
	$arrCategoryShirt[18][1] = 'Canvas 16x20'
	$arrCategoryShirt[18][2] = 14
	$arrCategoryShirt[19][0] = 147
	$arrCategoryShirt[19][1] = 'Hat'
	$arrCategoryShirt[19][2] = 15
	$arrCategoryShirt[20][0] = 148
	$arrCategoryShirt[20][1] = 'Trucker Cap'
	$arrCategoryShirt[20][2] = 18
EndFunc   ;==>addCategoryShirt


