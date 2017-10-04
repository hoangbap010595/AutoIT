#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

ToolTip("starting",0,0)
Sleep(3000)

HotKeySet("{esc}", '_exit')

$title = "[REGEXPTITLE: (?i)(.*Google Chrome.*)]"
$count = 0

While 1
	$FullName = "Le Cong Hoang"

	ControlClick($title,"",-1,"left",200,100)
	ControlSend($title,"",0,"asdfasdfasdf")
WEnd

