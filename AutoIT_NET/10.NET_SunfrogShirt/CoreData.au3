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


addCategoryGroup()
addCategoryShirt()

#Region =======TESS=======
;~ Local $arr = 'mot,hai,ba'
;~ Local $strJon = ['{"id":8,"name":"Guys Tee","price":19,"colors":["Yellow"]', '{"id":12,"name":"Guys Tee","price":31,"colors":["Green"]']
;~ _ArrayDisplay($arrCategoryProduct)
;~ _ArrayDisplay($arrCategoryShirt)

;~ MsgBox(0,0, UBound($arrCategoryProduct))
;~ MsgBox(0,0, getIDCatoryProduct("Hobby"))

;~ MsgBox(0,0, convertArrayToJson($arr))

;~ 	Local $a = getIDCatoryShirts("Guys Tee")
;~ 	Local $b = $a[0]&','&$a[1]&','&$a[2]
;~ 	MsgBox(0,0, convertStringToJson($b))
#EndRegion =======TESS=======

Func convertStringToJson($text)
	Local $arrayRs = StringSplit($text, ',')
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

Func getIDCatoryShirts($name)
	Local $id[3]
	For $i = 0 To 21 Step 1
		$temp = $arrCategoryShirt[$i][1]
		If $temp = String($name) Then
			$id[0] = $arrCategoryShirt[$i][0]
			$id[1] = $arrCategoryShirt[$i][1]
			$id[2] = $arrCategoryShirt[$i][2]
			Return $id
		EndIf
	Next
	Return $id
EndFunc   ;==>getIDCatoryShirts

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


#Region =====Color=====
Func getColorGuysAndLadies($listView)
	Local $item[19]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Sports Grey", $listView)
	$item[3] = GUICtrlCreateListViewItem("Dark Grey", $listView)
	$item[4] = GUICtrlCreateListViewItem("Brown", $listView)
	$item[5] = GUICtrlCreateListViewItem("Light Pink", $listView)
	$item[6] = GUICtrlCreateListViewItem("Hot Pink", $listView)
	$item[7] = GUICtrlCreateListViewItem("Red", $listView)
	$item[8] = GUICtrlCreateListViewItem("Orange", $listView)
	$item[9] = GUICtrlCreateListViewItem("Yellow", $listView)
	$item[10] = GUICtrlCreateListViewItem("Green", $listView)
	$item[11] = GUICtrlCreateListViewItem("Forest", $listView)
	$item[12] = GUICtrlCreateListViewItem("Light Blue", $listView)
	$item[13] = GUICtrlCreateListViewItem("Royal Blue", $listView)
	$item[14] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[15] = GUICtrlCreateListViewItem("Purple", $listView)
	$item[16] = GUICtrlCreateListViewItem("Black", $listView)
	$item[17] = GUICtrlCreateListViewItem("Maroon", $listView)
EndFunc   ;==>getColorGuysAndLadies

Func getColorYouthTee($listView)
	Local $item[9]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Sports Grey", $listView)
	$item[3] = GUICtrlCreateListViewItem("Dark Grey", $listView)
	$item[4] = GUICtrlCreateListViewItem("Black", $listView)
	$item[5] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[6] = GUICtrlCreateListViewItem("Red", $listView)
	$item[7] = GUICtrlCreateListViewItem("Royal Blue", $listView)
EndFunc   ;==>getColorYouthTee

Func getColorHoodie($listView)
	Local $item[12]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Sports Grey", $listView)
	$item[3] = GUICtrlCreateListViewItem("Maroon", $listView)
	$item[4] = GUICtrlCreateListViewItem("Red", $listView)
	$item[5] = GUICtrlCreateListViewItem("Royal Blue", $listView)
	$item[6] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[7] = GUICtrlCreateListViewItem("Charcoal", $listView)
	$item[8] = GUICtrlCreateListViewItem("Forest", $listView)
	$item[9] = GUICtrlCreateListViewItem("Green", $listView)
	$item[10] = GUICtrlCreateListViewItem("Black", $listView)
EndFunc   ;==>getColorHoodie

Func getColorSweatSirt($listView)
	Local $item[9]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Black", $listView)
	$item[3] = GUICtrlCreateListViewItem("Forest", $listView)
	$item[4] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[5] = GUICtrlCreateListViewItem("Red", $listView)
	$item[6] = GUICtrlCreateListViewItem("Royal Blue", $listView)
	$item[7] = GUICtrlCreateListViewItem("Sports Grey", $listView)
EndFunc   ;==>getColorSweatSirt

Func getColorGuysVNeck($listView)
	Local $item[7]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Black", $listView)
	$item[3] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[4] = GUICtrlCreateListViewItem("Red", $listView)
	$item[5] = GUICtrlCreateListViewItem("Sports Grey", $listView)
EndFunc   ;==>getColorGuysVNeck

Func getColorLadiesVNeck($listView)
	Local $item[9]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Black", $listView)
	$item[3] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[4] = GUICtrlCreateListViewItem("Red", $listView)
	$item[5] = GUICtrlCreateListViewItem("Royal Blue", $listView)
	$item[6] = GUICtrlCreateListViewItem("Dark Grey", $listView)
	$item[7] = GUICtrlCreateListViewItem("Purple", $listView)
EndFunc   ;==>getColorLadiesVNeck

Func getColorUnisex($listView)
	Local $item[8]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Black", $listView)
	$item[3] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[4] = GUICtrlCreateListViewItem("Red", $listView)
	$item[5] = GUICtrlCreateListViewItem("Royal Blue", $listView)
	$item[6] = GUICtrlCreateListViewItem("Sports Grey", $listView)
EndFunc   ;==>getColorUnisex

Func getColorHat($listView)
	Local $item[7]
	$item[1] = GUICtrlCreateListViewItem("Black", $listView)
	$item[2] = GUICtrlCreateListViewItem("Green", $listView)
	$item[3] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[4] = GUICtrlCreateListViewItem("Red", $listView)
	$item[5] = GUICtrlCreateListViewItem("Royal Blue", $listView)
EndFunc   ;==>getColorHat

Func getColorTruckerCap($listView)
	Local $item[6]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
	$item[2] = GUICtrlCreateListViewItem("Black", $listView)
	$item[3] = GUICtrlCreateListViewItem("Navy Blue", $listView)
	$item[4] = GUICtrlCreateListViewItem("Dark Grey", $listView)
EndFunc   ;==>getColorTruckerCap

Func getColorWhite($listView)
	Local $item[2]
	$item[1] = GUICtrlCreateListViewItem("White", $listView)
EndFunc   ;==>getColorWhite

Func getColorBlack($listView)
	Local $item[6]
	$item[1] = GUICtrlCreateListViewItem("Black", $listView)
EndFunc   ;==>getColorBlack
#EndRegion =====Color=====

#Region ===Category===
Func getCategoryThemes($combobox)
	GUICtrlSetData($combobox, "Guys Tee", "Guys Tee")
	GUICtrlSetData($combobox, "Ladies Tee")
	GUICtrlSetData($combobox, "Youth Tee")
	GUICtrlSetData($combobox, "Hoodie")
	GUICtrlSetData($combobox, "Sweat Shirt")
	GUICtrlSetData($combobox, "Guys V-Neck")
	GUICtrlSetData($combobox, "Ladies V-Neck")
	GUICtrlSetData($combobox, "Unisex Tank Top")
	GUICtrlSetData($combobox, "Unisex Long Sleeve")
	GUICtrlSetData($combobox, "Leggings")
	GUICtrlSetData($combobox, "Coffee Mug (colored)")
	GUICtrlSetData($combobox, "Coffee Mug (white)")
	GUICtrlSetData($combobox, "Coffee Mug (color change)")
	GUICtrlSetData($combobox, "Posters 16x24")
	GUICtrlSetData($combobox, "Posters 24x16")
	GUICtrlSetData($combobox, "Posters 11x17")
	GUICtrlSetData($combobox, "Posters 17x11")
	GUICtrlSetData($combobox, "Canvas 16x20")
	GUICtrlSetData($combobox, "Hat")
	GUICtrlSetData($combobox, "Trucker Cap")
EndFunc   ;==>getCategoryThemes

Func getCategoryProduct($combobox)
	GUICtrlSetData($combobox, "Automotive", "Automotive")
	GUICtrlSetData($combobox, "Birth Years")
	GUICtrlSetData($combobox, "Drinking")
	GUICtrlSetData($combobox, "Faith")
	GUICtrlSetData($combobox, "Fitness")
	GUICtrlSetData($combobox, "Funny")
	GUICtrlSetData($combobox, "Gamer")
	GUICtrlSetData($combobox, "Geek-Tech")
	GUICtrlSetData($combobox, "Hobby")
	GUICtrlSetData($combobox, "Holidays")
	GUICtrlSetData($combobox, "Jobs")
	GUICtrlSetData($combobox, "LifeStyle")
	GUICtrlSetData($combobox, "Movies")
	GUICtrlSetData($combobox, "Music")
	GUICtrlSetData($combobox, "Names")
	GUICtrlSetData($combobox, "Outdoor")
	GUICtrlSetData($combobox, "Pets")
	GUICtrlSetData($combobox, "Political")
	GUICtrlSetData($combobox, "Sports")
	GUICtrlSetData($combobox, "States")
	GUICtrlSetData($combobox, "TV Shows")
	GUICtrlSetData($combobox, "Zombies")
EndFunc   ;==>getCategoryProduct

Func loadColorFromCategory($category, $listView)
	Switch $category
		Case 'Guys Tee'
			getColorGuysAndLadies($listView)
		Case 'Ladies Tee'
			getColorGuysAndLadies($listView)
		Case 'Youth Tee'
			getColorYouthTee($listView)
		Case 'Hoodie'
			getColorHoodie($listView)
		Case 'Sweat Shirt'
			getColorSweatSirt($listView)
		Case 'Guys V-Neck'
			getColorGuysVNeck($listView)
		Case 'Ladies V-Neck'
			getColorLadiesVNeck($listView)
		Case 'Unisex Tank Top'
			getColorUnisex($listView)
		Case 'Unisex Long Sleeve'
			getColorUnisex($listView)
		Case 'Leggings'
			getColorBlack($listView)
		Case 'Coffee Mug (colored)'
			getColorBlack($listView)
		Case 'Coffee Mug (white)'
			getColorWhite($listView)
		Case 'Coffee Mug (color change)'
			getColorWhite($listView)
		Case 'Posters 16x24'
			getColorWhite($listView)
		Case 'Posters 24x16'
			getColorWhite($listView)
		Case 'Posters 11x17'
			getColorWhite($listView)
		Case 'Posters 17x11'
			getColorWhite($listView)
		Case 'Canvas 16x20'
			getColorWhite($listView)
		Case 'Hat'
			getColorHat($listView)
		Case 'Trucker Cap'
			getColorTruckerCap($listView)
	EndSwitch
EndFunc   ;==>loadColorFromCategory
#EndRegion ===Category===
