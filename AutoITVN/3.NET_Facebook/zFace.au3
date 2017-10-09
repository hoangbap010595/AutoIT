#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <_HttpRequest.au3>

$proxy = 'http://proxy.hcm.fpt.vn:80'
_HttpRequest_SetProxy($proxy)

$url = 'https://www.facebook.com/'
$urlLogin = 'https://www.facebook.com/login.php?login_attempt=1&lwv=110'
$email = '0901479784'
$pass = 'Thienan@111'
$dataToSend = 'email='&_URIEncode($email)&'&pass='&_URIEncode($pass)&''

$filePath = @ScriptDir & '\code.html'

$hRequest = _HttpRequest(1,$url)
;~ MsgBox(1,0,$hRequest)
$cookie = _GetCookie($hRequest)

$dataFinal = _HttpRequest(2,$urlLogin,$dataToSend,$cookie)

MsgBox(1,0,$cookie)


postStatus($dataFinal,$cookie)

Func postStatus($dataFinal, $cookieFinal)
;~ 	fb_dtsg=AQGZD6NXqQoM%3AAQHmEL-MqFWU&privacyx=286958161406148&target=100004699989342&c_src=feed&cwevent=composer_entry&referrer=feed&ctype=inline&cver=amber&rst_icv=&xc_message=abcTestPost&view_post=%C4%90%C4%83ng: undefined
	$urlPost = 'https://m.facebook.com/composer/mbasic/?av=100004699989342&refid=8'
	$fb_dtsg = StringRegExp($dataFinal,'<input type="hidden" name="fb_dtsg" value="(.*?)"',1)[0]
;~ MsgBox(1,0,$fb_dtsg[0])
	$content = 'leconghoang'
	$dataPost = 'fb_dtsg='& $fb_dtsg &'privacyx=286958161406148&target=100004699989342&c_src=feed&cwevent=composer_entry&referrer=feed&ctype=inline&cver=amber&rst_icv=&'
	$dataPost &= 'xc_message='& _URIEncode($content) &'&view_post=%C4%90%C4%83ng'
MsgBox(1,0,$dataPost)
	_HttpRequest(2,$urlPost,$dataPost,$cookieFinal)
EndFunc