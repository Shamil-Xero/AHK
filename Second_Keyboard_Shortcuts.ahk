#NoEnv
#SingleInstance Force
SetDefaultMouseSpeed, 5

#Include <Lib>

#If (getKeyState("F23", "P")) ;<--Everything after this line will only happen on the secondary keyboard that uses F23.
F23::
Tooltip, 2nd key
settimer, RemoveToolTip, -200
return ;this line is mandatory for proper functionality


escape::Return ;<--to disable a key, just use a "return," like so.

;==================================================================================================================================
; IfWinNotExist, ahk_exe Photoshop.exe
	; Run, "C:\Program Files\Adobe\Adobe Photoshop 2023\photoshop.exe"

; if WinActive("ahk_exe Photoshop.exe")
	; Send, #{Down}
; else
	; WinActivate, ahk_exe Photoshop.exe
; Return

; IfWinNotExist, ahk_exe Adobe Premiere Pro.exe
	; Run, "C:\Program Files\Adobe\Adobe Premiere Pro 2022\Adobe Premiere Pro.exe"

; if WinActive("ahk_exe Adobe Premiere Pro.exe")
	; Send, #{Down}
; else
	; WinActivate, ahk_exe Adobe Premiere Pro.exe
; Return

; IfWinNotExist, ahk_exe DCv2.exe
	; Run, "E:\Programs\Dragon Center.lnk"

; if WinActive("ahk_exe DCv2.exe")
	; Send, #{Down}
; else
	; WinActivate, ahk_exe DCv2.exe
; Return

; F1::
; mode := "default"
; Tooltip, Mode : Default
; SetTimer, RemoveToolTip, -1000
; Return
	
; F2::
; mode := "work"
; Tooltip, Mode : Work
; SetTimer, RemoveToolTip, -1000
; Return

; F3::
; mode := "game"
; Tooltip, Mode : Game
; SetTimer, RemoveToolTip, -1000
; Return

; F4::
; F5::
; F6::
; F7::
; F8::
; F9::
; F10::
; F11::
; F12::
; GetHotKey()
; Return

;;Note that the assignment on the above line will apply to ALL prior lines ending in "::"
;;...which you should know from the AHK tutorial I linked you to.

;;------------------------Numbers--------------------------;;

; Run, https://web.classplusapp.com/newApp/store/course/206873/7043818?section=content

`::
SendInput, #m
Return

1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
GetHotKey()
Return
;;------------------------Alphabets--------------------------;;

a::
GetHotKey()
Return

b::
GetHotKey()
Return

c::
IfWinNotExist, ahk_exe notepad++.exe
	Run, C:\Program Files\Notepad++\notepad++.exe

if WinActive("ahk_exe notepad++.exe")
	Send, #{Down}
else
	WinActivate, ahk_exe notepad++.exe
Return

d::
^d::
+!^d::
!d::
+!d::
+^d::
GetHotKey()
Return

e::
SendInput, {Ctrl Down}c{Ctrl Up}
Return

f::
IfWinNotExist, ahk_exe FortniteClient-Win64-Shipping.exe
		Run, "D:\Programs\Shortcuts\Fortnite.url"
	
		if WinActive("ahk_exe FortniteClient-Win64-Shipping.exe")
		SendInput {Ctrl}
	else
		WinActivate ahk_exe FortniteClient-Win64-Shipping.exe
Return

g::
Run, D:\Games
Return

h::
i::
GetHotKey()
Return
j::
Run, "C:\Program Files\Jellyfin\Server\Jellyfin.Windows.Tray.exe"
Run, http://localhost:8096/
Return

k::
KeyHistory
Return

; Run, C:\Users\Shamil\shortcuts\Dragon Center.lnk
; WinWait, Dragon Center
; CoordMode, Mouse, Relative
; MouseGetPos, x, y
; sleep, 500
; MouseClick, left, 1250, 75
; sleep, 500
; MouseClick, left, 1250, 255
; sleep, 500
; MouseClick, left, 1523, 18

; Run, *runas cmd.exe /c powercfg -setactive scheme_max

; Run, "C:\Users\Shamil\shortcuts\48.lnk"

; sleep 2000
; MouseMove, x, y


l::
m::
GetHotKey()
Return

; n::
; IfWinNotExist, ahk_exe Notion.exe
; 	Run, "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
; else
; {
; 	if WinActive("ahk_exe Notion.exe")
; 		WinMinimize, ahk_exe Notion.exe
; 	else
; 		WinActivate ahk_exe Notion.exe
; }
; Return

o::
IfWinNotExist, ahk_exe Overwatch.exe
	Run, "E:\Games\Overwatch\_retail_\Overwatch.exe"

if WinActive("ahk_exe Overwatch.exe")
	Send +
else
	WinActivate, ahk_exe Overwatch.exe
Return

p::
IfWinNotExist, ahk_exe Photoshop.exe
	Run, "C:\Program Files\Adobe\Adobe Photoshop 2024\Photoshop.exe"

if WinActive("ahk_exe Photoshop.exe")
	Send +
else
	WinActivate, ahk_exe Photoshop.exe
Return

+p::
Run, "C:\Users\Shamil\Pictures\Photoshop"
Return

q::
GetHotKey()
Return

r::
SendInput, {Ctrl Down}v{Ctrl Up}
sleep 250
SendInput, {Ctrl}
sleep 100
SendInput, m
Return

s::
	IfWinNotExist, ahk_exe Spotify.exe
		Run, "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe"

	if WinActive("ahk_exe Spotify.exe")
		Send, #{Down}
	else
		WinActivate, ahk_exe Spotify.exe
Return

t::
u::
GetHotKey()
Return

v::
IfWinNotExist, ahk_exe Code.exe
	Run, "C:\Users\Shamil\AppData\Local\Programs\Microsoft VS Code\Code.exe"
else
{
	if WinActive("ahk_exe Code.exe")
		Sendinput {Ctrl}
	else
		WinActivate ahk_exe Code.exe
}
Return

w::
GetHotKey()
Return

x::
IfWinNotExist, ahk_exe opera.exe
	Run, "C:\Users\Shamil\AppData\Local\Programs\Opera GX\opera.exe"

if WinActive("ahk_exe opera.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe opera.exe
Return

y::
If WinActive("ahk_exe opera.exe")
	{
	CoordMode, Mouse, Window
	MouseGetPos, x, y
	MouseClick, Middle, 118, 115,,0
	MouseMove, x, y
	sleep 1000
	SendInput, {LCtrl}{Tab}
	Return
}
Else
	{
	IfWinNotExist, ahk_exe brave.exe
		Run, "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

	if WinActive("ahk_exe brave.exe")
		Run, https://www.youtube.com/feed/subscriptions
	else
		WinActivate ahk_exe brave.exe
}
Return

z::
IfWinNotExist, ahk_exe brave.exe
	Run, "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

if WinActive("ahk_exe brave.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe brave.exe
Return
	
;=================================================================================;

; SendInput, {LWin down}{PrintScreen down}{PrintScreen up}{LWin up}
[::	
]::
\::
'::
enter::
,::
.::
/::
GetHotKey()
Return

space::
SendInput {Media_Play_Pause}
Return

Backspace::
PrintScreen::
insert::
GetHotKey()
Return

del::
SendInput, #^d
Return

home::
end::
pgup::
pgdn::
GetHotKey()
Return

;;===================== MODIFIERS =========================;;


;^z::tooltip, you pressed CTRL Z on the F23 keyboard.
;!z::tooltip, you pressed ALT Z on the F23 keyboard. I don't recommend this... ALT is dangerous because of menu acceleration, even if you try to disable it like I have
;^!z::tooltip, you pressed CTRL SHIFT Z on the F23 keyboard.
;;Etc.
;;However, I use few to no modifiers on my secondary keyboards... I prefer tap dance instead. The decision is up to you.

;;Keep these commented out, as they are!
;Lshift::tooltip, do not use
;Lctrl::tooltip, do not use
;Lwin::tooltip, do not use
;Lalt::tooltip, do not use
;Ralt::tooltip, do not use
;Rwin::tooltip, do not use
;appskey::tooltip, This is not a modifier, but I replaced it with INTERNATIONAL4 (SC079) anyway, because it was able to misbehave.
;Rctrl::tooltip, do not use
;Rshift::tooltip, do not use

;; https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=824607963


;;LShift
SC070::SendInput, {LShift}

;;LCtrl
SC071::SendInput, {LCtrl}

;;LWin
SC072::SendInput, {LWin}

;;LAlt
SC073::SendInput, {LAlt}

;;RAlt
SC077::SendInput, {RAlt}

;;RWin
SC078::SendInput, {RWin}

;;AppsKey
SC079::SendInput, {AppsKey}

;;RCtrl
SC07B::SendInput, {RCtrl}

;;RShift
SC07D::SendInput, {RShift}

;;================= LOCKING KEYS ======================;;

F20::tooltip, [F23] CapsLock -to-> SC06B-F20
SC05C::
;Numlock is an AWFUL key. I prefer to leave it permanently on.
;It's been changed to International 6, so you can use it with no fear that it'll mess up your numpad.

;Scroll Lock
SC061::
Run, *runas cmd.exe /c taskkill /IM intercept.exe /f
Return

;;================= NEXT SECTION ======================;;


;;Don't use the 3 keys below for your 2nd keyboard!
;Pause::msgbox, The Pause/Break key is a huge PITA. That's why I remapped it to SC07E
;Break::msgbox, Or is it THIS key? WHO KNOWS!
;CtrlBreak::msgbox, I have no idea what Ctrlbreak is. But it shows up sometimes.
;;Don't use the 3 keys above for your 2nd keyboard! Just don't!!


;;================= NEXT SECTION ======================;;




;;================== THE NUMPAD ======================;;

numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::
numpadDot::
GetHotKey()
Return

;;NumLock::tooltip, DO NOT USE THIS IN YOUR 2ND KEYBOARD!

up::
IfWinActive, ahk_exe Spotify.exe
	SendInput, ^{Up}
else
	SendInput, {Up}
Return
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY,,, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, f
WinActivate, % "AHK_ID" Current_Window

down::
IfWinActive, ahk_exe Spotify.exe
	SendInput, ^{Down}
else
	SendInput, {Down}
Return

left::
IfWinActive, ahk_exe Spotify.exe
	SendInput, ^{Left}
else
	SendInput, {Left}
Return
WinGet, Current_Window, ID, A
WinActivate, - YouTube
Send, j
WinActivate, % "AHK_ID" Current_Window
	
right::
IfWinActive, ahk_exe Spotify.exe
	SendInput, +{Right}
else
	SendInput, {Right}
Return
WinGet, Current_Window, ID, A
WinActivate, - YouTube
Send,l
WinActivate, % "AHK_ID" Current_Window

#if ;this line will end the F23 secondary keyboard assignments.

;;;--------------------IMPORTANT: HOW TO USE #IF THINGIES----------------------

;;You can use more than one #if thingy at a time, but it must be done like so:
;#if (getKeyState("F23", "P")) and if WinActive("ahk_exe Adobe Premiere Pro.exe")
;F1::msgbox, You pressed F1 on your secondary keyboard while inside of Premiere Pro

;; HOWEVER, You still would still need to block F1 using #if (getKeyState("F23", "P"))
;; If you don't, it'll pass through normally, any time Premiere is NOT active.
;; Does that make sense? I sure hope so.

;; Alternatively, you can use the following: (Comment it in, and comment out other instances of F1::)
; #if (getKeyState("F23", "P"))
; F1::
; if WinActive("ahk_exe Adobe Premiere Pro.exe")	
; {
	; msgbox, You pressed F1 on your secondary keyboard while inside of Premiere Pro
	; msgbox, And you did it by using if WinActive()
; }
; else
	; msgbox, You pressed F1 on your secondary keyboard while NOT inside of Premiere Pro
;;This is easier to understand, but it's not as clean of a solution.

;; #if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so, but I don't.

;; Here is a discussion about all this:
;; https://github.com/TaranVH/2nd-keyboard/issues/65

;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;;+|||||||||+ END OF INTERCEPTION SECOND KEYBOARD F23 ASSIGNMENTS +|||||||||||||+
;;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;;Note that this whole script was written for North American keyboard layouts.
;;IDK what you foreign language peoples are gonna have to do!
;;At the very least, you'll have some duplicate keys.


#if
