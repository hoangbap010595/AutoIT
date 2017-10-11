#include <WinHttp.au3>

; Proxy
$proxy = 'http://proxy.hcm.fpt.vn:80'

; Address
$host = 'http://fshare.vn/'

; Initialize and get session handle
Local $hOpen = _WinHttpOpen('Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0',0,$proxy)
; Get connection handle
Local $hConnect = _WinHttpConnect($hOpen, $host)
; Request
Local $hRequest = _WinHttpOpenRequest($hConnect, 'GET', '/', 'HTTP/1.1')

_WinHttpAddRequestHeaders($hRequest, 'Host: fshare.vn')
_WinHttpAddRequestHeaders($hRequest, 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
_WinHttpAddRequestHeaders($hRequest, 'Accept-Language: vi-VN,vi;q=0.8,en-US;q=0.5,en;q=0.3')
_WinHttpAddRequestHeaders($hRequest, 'Accept-Encoding: gzip, deflate')
_WinHttpAddRequestHeaders($hRequest, 'Connection: keep-alive')

_WinHttpSendRequest($hRequest)

; Wait for the response
_WinHttpReceiveResponse($hRequest)
If @error Then
    MsgBox(48, "Error", "Error ocurred for WinHttpReceiveResponse, Error number is " & @error)
Else
    MsgBox(64, "All right!", "Server at 'en.wikipedia.org' processed the request.")
EndIf


; Close handles
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)




;~ http://fshare.vn/

;~ GET / HTTP/1.1
;~ Host: fshare.vn
;~ User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0
;~ Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
;~ Accept-Language: vi-VN,vi;q=0.8,en-US;q=0.5,en;q=0.3
;~ Accept-Encoding: gzip, deflate
;~ Cookie: _ga=GA1.2.442312499.1507530748; _gid=GA1.2.519176744.1507530748; fosp_aid=30e74423f7abfdd7; fosp_location_zone=1
;~ Connection: keep-alive
;~ Upgrade-Insecure-Requests: 1

;~ HTTP/1.1 302 Moved Temporarily
;~ Server: fshare-nginx
;~ Date: Mon, 09 Oct 2017 09:02:08 GMT
;~ Content-Type: text/html
;~ Content-Length: 154
;~ Location: http://www.fshare.vn/
;~ X-Cache: MISS from Squid-Cache
;~ X-Cache-Lookup: MISS from Squid-Cache:80
;~ Via: 1.1 Squid-Cache (squid/3.3.8)
;~ Connection: keep-alive