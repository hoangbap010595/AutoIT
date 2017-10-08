#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         HoangLC

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <WinAPIFiles.au3>
#include <Array.au3>
#include <SqlServer.au3>

Local $filePath = @ScriptDir & '\EventLog.txt'

;~ deleteLog()
;~ writeLog('Lê Công Hoàng')
;~ readLog()

Func writeLog(Const ByRef $data)
	FileOpen($filePath,1)
	FileWriteLine($filePath, '['&@HOUR&':'&@MIN&':'&@SEC&' '&@MDAY&'-'&@MON&'-'&@YEAR&']' & ' ' & $data)
	FileClose($filePath)
EndFunc

Func readLog()
	FileOpen($filePath)
	$data = FileRead($filePath)
	ConsoleWrite($data)
	FileClose($filePath)
EndFunc

Func deleteLog()
	FileDelete($filePath)
EndFunc


;~ // create connection to MSSQL
_SqlConnect()
Func _SqlConnect() ; connects to the database specified
	Local $adCN
	Local $server = 'HOANG-PC\SQLEXPRESS'
;~ 	Local $server = 'W00123695-ISC\SQLEXPRESS'

	$constrim="DRIVER={SQL Server};SERVER="&$server&";DATABASE=DBStorage;uid=sa;pwd=Hoang911;"
	$adCN = ObjCreate ("ADODB.Connection") ; <== Create SQL connection
	$adCN.Open ($constrim) ; <== Connect with required credentials
;~ 	MsgBox(0,"",$constrim )

	if @error Then
		MsgBox(0, "ERROR", "Failed to connect to the database")
		Exit
	Else
		MsgBox(0, "Success!", "Connection to database successful!")
	EndIf

	$sQuery = "select database_id, name from sys.databases"

	$result = $adCN.Execute($sQuery)
	Local $aResult,$iRows,$iColumns
	$iRval = _SQL_GetTable2D($adCN,$sQuery,$aResult,$iRows,$iColumns)
	_ArrayDelete($aResult,0)
	_ArrayDisplay($aResult,"Warehouse", "",0,Default,"ID|Name")
;~ 	MsgBox(0, "", $result.Fields( "Barcode" ).Value)
	$adCN.Close ; ==> Close the database

EndFunc
