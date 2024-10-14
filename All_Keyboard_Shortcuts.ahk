SetWorkingDir %A_WorkingDir%  ; Ensures a consistent starting directory.
;SetWorkingDir, D:\AHK\2nd-keyboard\ ;Or you could put the directory here. Whatevs.
; Menu, Tray, Icon, shell32.dll, 216
Menu, Tray, Icon, %A_ScriptDir%\AutoHotKeyV1.png ;changes the taskbar icon to something
SetKeyDelay, 2 ;IDK exactly what this does.


#NoEnv
;;SendMode Input
;#include <CvJoyInterface>
#InstallKeybdHook
#InstallMouseHook ;<--You'll want to use this if you have scripts that use the mouse.
#UseHook On
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 200
#KeyHistory 200 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;prevent taskbar flashing.
; #NoTrayIcon
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetDefaultMouseSpeed, 2




;;The lines below are optional. Delete them if you need to.
;#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm

;;The lines above are optional. Delete them if you need to.



;________________________________________________________________________________________
;
;		    2ND KEYBOARD USING INTERCEPTION AND INTERCEPT.exe (Logitech K120)
;________________________________________________________________________________________

; Please watch https://www.youtube.com/watch?v=y3e_ri-vOIo for a comprehensive tutorial.
;________________________________________________________________________________________

; DANGER: Installing interception may cause your USB devices to stop working sometimes, because it is limited to supporting only 10 of each device class. You have to uninstall it to fix that. Here is a follow up video with new information: https://www.youtube.com/watch?v=Hn18vv--sFY

; For this reason, I now use the Hasu USB to USB keyboard converter. It's sweet.
; https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/

;;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||;;
;;||||||||||||| BEGIN SECOND KEYBOARD INTERCEPTION F23 ASSIGNMENTS ||||||||||||;;
;;|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||;;

;; You should DEFINITELY not be trying to add a 2nd keyboard unless you're already
;; familiar with how AutoHotkey works. I recommend that you at least take this tutorial:
;; https://autohotkey.com/docs/Tutorial.htm

;; You'll probably want the syntax highlighting:  https://stackoverflow.com/questions/45466733/autohotkey-syntax-highlighting-in-notepad

#include <Vis2>

#Include %A_WorkingDir%\Lib\Lib1.ahk

; MsgBox % OCR("D:\AHK\test.jpg")

; Run, "D:\AHK\All_Keyboard_Shortcuts_V2.ahk"

; RunWait, *runas cmd.exe /c taskkill /IM intercept.exe /f, , Hide

; Run, *runas cmd.exe /c "D:\Programs\Intercept\intercept.exe" /apply, ,hide

; WinHide, ahk_class ConsoleWindowClass

; Run D:\AHK\Minimize_To_Tray.ahk

; #Include %A_ScriptDir%.\Second_Keyboard_Shortcuts.ah

; ^F7::
; GoSub,CheckActiveWindow
; return


; #IfWinActive, ahk_exe Photoshop.exe

; WheelUp::
; If GetKeyState("b")
; 	SendInput "]"
; else
; 	SendInput {WheelUp}
; Return

; WheelDown::
; If GetKeyState("b")
; 	SendInput "["
; else
; 	SendInput {WheelDown}
; Return

; ^y::
; SendInput, ^+z
; Return

; #IfWinActive, ahk_exe Adobe Premiere Pro.exe

; ^y::
; SendInput, ^+z
; Return

; #IfWinActive


;;*******************************************************************************************************************************;;
;;============================================================LABELS=============================================================;;

;;*******************************************************************************************************************************;;





;;*******************************************************************************************************************************;;

/*

programs_loc := ["C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe", "C:\Users\Shamil\AppData\Local\Programs\Opera GX\opera.exe", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe"]
programs_exe := ["brave.exe", "opera.exe", "spotify.exe"]
SysGet, Mon1, Monitor, 1
SysGet, Mon2, Monitor, 2
SysGet, Mon3, Monitor, 3

for index, value in programs_loc
{
	; msgbox, %index%
	; IfWinExist, ahk_exe %value%
	; {
	; 	IfWinActive, ahk_exe %value%
	; 	{
	; 		; Send, #{Down}
	; 	}
	; 	Else
	; 	{
	; 		WinActivate, ahk_exe %value%
	; 	}
	; }
	; Else
	; {
		Run, %value%
	; }
	sleep 2000
}

	WinActivate, ahk_exe brave.exe
	sleep 500
	WinMove, ahk_exe brave.exe, %Mon1Left%, %Mon1Top%
	sleep 500
	SendInput, #{Up}
	sleep 500
	WinActivate, ahk_exe opera.exe
	sleep 500
	WinMove, ahk_exe opera.exe, %Mon2Left%, %Mon3Top%
	sleep 500
	SendInput, #{Up}
	sleep 500
	WinActivate, ahk_exe Spotify.exe
	sleep 500
	WinMove, ahk_exe Spotify.exe, %Mon3Left%, %Mon3Top%
	sleep 500
	SendInput, #{Up}
	sleep 500
*/

; RunWait, notepad.exe
; ; WinWait, notepad.exe
; SysGet, Mon2, Monitor, 2
; SysGet, Mon1, Monitor, 1
; sleep 500
; MsgBox, Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
; Winactivate, ahk_exe Notepad.exe
; sleep 500
; Mon2Half := (Abs(Mon2Left-Mon2Right)/2)+Mon2Left
; test1:=%Mon2Left%+1000
; test2:=%Mon2Top%+1000
; WinMove, ahk_exe notepad.exe, ,3000, 900
; Return


;;*******************************************************************************************************************************;;





;;*******************************************************************************
;;~~~~~~~~~~~~~DEFINE YOUR NORMAL KEY ASSIGNMENTS BELOW THIS LINE~~~~~~~~~~~~~~~~
;;*******************************************************************************
; ~^del::
; p := Morse()
; If (p = "0") {
; 	Run, *runas cmd.exe /c "D:\Programs\Intercept\intercept.exe" /apply, ,hide
; }
; Else If (p = "00") {
; 	Run, *runas cmd.exe /c taskkill /IM intercept.exe /f, , Hide
; }
; Return

; ~!del::
; p := Morse()
; If (p = "0"){
; 	;pnputil /enable-device /class Display //To find the display;
; 	Run, *runas cmd.exe /c pnputil /enable-device "ROOT\UNKNOWN\0000"
; }
; Else If (p = "00"){
; 	Run, *runas cmd.exe /c pnputil /disable-device "ROOT\UNKNOWN\0000"
; }
; Else If (p = "1")
; {
; 	Run, "D:\ADB\Sunshine.bat"
; 	; Run, *runas cmd.exe cd /d "C:\Program Files\Sunshine" && tools\dxgi-info.exe
; }

;======================================================================================================================================================================================================


;========================================================================================================================================================================================================;


; F1::
; If FolderPathHotkey = 1
; {
	; KeyWait, F1		; wait release
	; KeyWait, F1, D T0.2	; and pressed again within 0.2 seconds
	; if ErrorLevel { ; timed-out (only a single press)
		; Try Run, %SelectedDir3%
	; } 
	; else 
	; {
	; SendInput, ^+c
	; SelectedDir3 := Clipboard
	;~ hWnd := WinExist("A")
		;~ for obj in ComObjCreate("Shell.Application").Windows
			;~ if (obj.hwnd==hwnd)
				;~ SelectedDir3 := obj.Document.Folder.Self.Path
	;~ Try Tooltip, % obj.Document.Folder.Title
	;~ Sleep 1000
	;~ Tooltip,
	;~ IniWrite, %SelectedDir3%, folderpath.ini, LastInfo, path
	; }
; }
; else{
	; SendInput, {F1}
; }
; return

; ^!Numpad1::

; RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "D:\AHK\All_Keyboard_Shortcuts_Compile_&_Run.ahk" /out "D:\AHK\All_Keyboard_Shortcuts_Compile_&_Run.exe" /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /compress 0

; Run, "D:\AHK\All_Keyboard_Shortcuts_Compile_&_Run.exe"

; Return

; ^!Numpad2::
; RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "D:\AHK\Other_Shortcuts_Compile_&_Run.ahk" /out "D:\AHK\Other_Shortcuts_Compile_&_Run.exe" /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /compress 0

; Run, "D:\AHK\Other_Shortcuts_Compile_&_Run.exe"

; Return

; ^!Numpad3::
; RunWait "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in "D:\AHK\All_Keyboard_Shortcuts_&_Other_Shortcuts_Compile_&_Run.ahk" /out "D:\AHK\All_Keyboard_Shortcuts_&_Other_Shortcuts_Compile_&_Run.exe" /bin "C:\Program Files\AutoHotkey\Compiler\Unicode 64-bit.bin" /compress 0

; Run, "D:\AHK\All_Keyboard_Shortcuts_&_Other_Shortcuts_Compile_&_Run.exe"


; Insert::
; if (num_mode != "Normal_Numpad")
; 	num_mode := "Normal_Numpad"
; else
; 	num_mode := "Num_Media_Control"
; Tooltip, %num_mode%
; SetTimer, RemoveToolTip, -1000
; Return

; Numpad1::
; If (num_mode != "Normal_Numpad")
; {
; t := !t 
; if t=1
; {
;     SetDefaultEndpoint(GetDeviceID(Devices, "Headphone"))
;     ToolTip, "Buds"
; }
; else
; {
;     SetDefaultEndpoint(GetDeviceID(Devices, "Speakers")) 
;     ToolTip, "Speakers"
; }
; SetTimer, RemoveToolTip, -1000
; }
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad2::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Media_Play_Pause}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad3::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Media_Next}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad4::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Media_Prev}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad5::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Media_Play_Pause}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad6::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Media_Next}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad7::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Volume_Down}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad8::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Volume_Mute}
; else
; 	SendInput {%A_ThisHotKey%}
; Return

; Numpad9::
; If (num_mode != "Normal_Numpad")
; 	SendInput {Volume_Up}
; else
; 	SendInput {%A_ThisHotKey%}
; Return


; ^!x::

; p := Morse()
; If (p = "0")
; {
; IfWinNotExist, ahk_exe vlc.exe
; 	Run, "C:\Program Files\VideoLAN\VLC\vlc.exe"
; if WinActive("ahk_exe vlc.exe")
; {
; 	SendInput f
; 	sleep 500
; 	SendInput #{Down}
; }
; else
; 	WinActivate, ahk_exe vlc.exe
; }
; Else If (p = "00")
; 	SendInput {Space}
; Else
; 	{
; 	Tooltip, Press pattern %p%
; 	SetTimer, RemoveToolTip, -1000
; }
Return

; #IfWinActive, ahk_exe Overwatch.exe
; :*:asdf::
; SetKeyDelay, 30
; sleep 500
; Send, swimmingshamil@gmail.com
; sleep 100
; SendInput {Tab}
; sleep 100
; Send swimsham123{Enter}
; SetKeyDelay, 0
; Return
; #IfWinActive


; #e::
; KeyWait, e, T0.2
; if !ErrorLevel
; {
; 	GroupAdd, ExplorerGroup, ahk_class CabinetWClass
; 	IfWinNotExist, ahk_class CabinetWClass
; 		Run, explorer.exe
; 		GroupAdd, myexplorers, ahk_class CabinetWClass
; 	If WinActive("ahk_exe explorer.exe")
; 		GroupActivate, ExplorerGroup, r
; 	else
; 		WinActivate ahk_class CabinetWClass
; 	return
; }
; else
; {	
; 	KeyWait, e, T1
; 	Run, explorer.exe
; }
; Return

; ^+'::
; Run *runas cmd.exe /c cd D:\ADB && dir /s /b D:\Shared > D:\Shared.bat
; Run *runas cmd.exe /c cd D:\ADB && adb push D:\.Shared /sdcard/
; Return


========================================================================================================================================================




; ^F1::
; t := !t 
; if t=1
; {
;     SetDefaultEndpoint(GetDeviceID(Devices, "Headphone"))
;     ToolTip, "Buds"
; 	SetTimer, RemoveToolTip, -1000
; }
; else
; {
;     SetDefaultEndpoint(GetDeviceID(Devices, "Speakers")) 
;     ToolTip, "Speakers"
; 	SetTimer, RemoveToolTip, -1000
; }
; return



==============================================================================================================================================================
; Return

; ~MButton & LButton::
; CoordMode, Mouse  ; Switch to screen/absolute coordinates.
; MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
; WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
; WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
; if EWD_WinState = 0  ; Only if the window isn't maximized
; 	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
; return

; EWD_WatchMouse:
; GetKeyState, EWD_LButtonState, LButton, P
; if EWD_LButtonState = U  ; Button has been released, so drag is complete.
; {
; 	SetTimer, EWD_WatchMouse, Off
; 	return
; }
; GetKeyState, EWD_EscapeState, Escape, P
; if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
; {
; 	SetTimer, EWD_WatchMouse, Off
; 	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
; 	return
; }
; ; Otherwise, reposition the window to match the change in mouse coordinates
; ; caused by the user having dragged the mouse:
; CoordMode, Mouse
; MouseGetPos, EWD_MouseX, EWD_MouseY
; WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
; SetWinDelay, -1   ; Makes the below move faster/smoother.
; WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
; EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
; EWD_MouseStartY := EWD_MouseY
; Return

; ; This is the setting that runs smoothest on my
; ; system. Depending on your video card and cpu
; ; power, you may want to raise or lower this value.
; SetWinDelay,1

; CoordMode,Mouse
; return




;;If you assign them BEFORE the second keyboard, they'll overrule it. You don't want that.
;#ifwinactive ahk_exe ahk_exe Adobe Premiere Pro.exe
;F2::Tooltip, , You pressed F2 on your normal keyboard while inside of Premiere Pro. `nThis is an autohotkey script by the way - in case you forgot.`nCheck your taskbar to find it.
;; You can of course delete the above line.
#ifwinactive

;;~~~~~~~~~~~~~~~~~DEFINE YOUR FUNCTIONS BELOW THIS LINE~~~~~~~~~~~~~~~~~~~~~~~~~




; Globals
DesktopCount = 2 ; Windows starts with 2 desktops at boot
CurrentDesktop = 1 ; Desktop count is 1-indexed (Microsoft numbers them this way)
;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
;
mapDesktopsFromRegistry() {
 global CurrentDesktop, DesktopCount
 ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
 IdLength := 32
 SessionId := getSessionId()
 if (SessionId) {
 RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
 if (CurrentDesktopId) {
 IdLength := StrLen(CurrentDesktopId)
 }
 }
 ; Get a list of the UUIDs for all virtual desktops on the system
 RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
 if (DesktopList) {
 DesktopListLength := StrLen(DesktopList)
 ; Figure out how many virtual desktops there are
 DesktopCount := DesktopListLength / IdLength
 }
 else {
 DesktopCount := 1
 }
 ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
 i := 0
 while (CurrentDesktopId and i < DesktopCount) {
 StartPos := (i * IdLength) + 1
 DesktopIter := SubStr(DesktopList, StartPos, IdLength)
 OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.
 ; Break out if we find a match in the list. If we didn't find anything, keep the
 ; old guess and pray we're still correct :-D.
 if (DesktopIter = CurrentDesktopId) {
 CurrentDesktop := i + 1
 OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
 break
 }
 i++
 }
}
;
; This functions finds out ID of current session.
;
getSessionId()
{
 ProcessId := DllCall("GetCurrentProcessId", "UInt")
 if ErrorLevel {
 OutputDebug, Error getting current process id: %ErrorLevel%
 return
 }
 OutputDebug, Current Process Id: %ProcessId%
 DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
 if ErrorLevel {
 OutputDebug, Error getting session id: %ErrorLevel%
 return
 }
 OutputDebug, Current Session Id: %SessionId%
 return SessionId
}
;
; This function switches to the desktop number provided.
;
switchDesktopByNumber(targetDesktop)
{
 global CurrentDesktop, DesktopCount
 ; Re-generate the list of desktops and where we fit in that. We do this because
 ; the user may have switched desktops via some other means than the script.
 mapDesktopsFromRegistry()
 ; Don't attempt to switch to an invalid desktop
 if (targetDesktop > DesktopCount || targetDesktop < 1) {
 OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
 return
 }
 ; Go right until we reach the desktop we want
 while(CurrentDesktop < targetDesktop) {
 Send ^#{Right}
 CurrentDesktop++
 OutputDebug, [right] target: %targetDesktop% current: %CurrentDesktop%
 }
 ; Go left until we reach the desktop we want
 while(CurrentDesktop > targetDesktop) {
 Send ^#{Left}
 CurrentDesktop--
 OutputDebug, [left] target: %targetDesktop% current: %CurrentDesktop%
 }
}
;
; This function creates a new virtual desktop and switches to it
;
createVirtualDesktop()
{
 global CurrentDesktop, DesktopCount
 SendInput #^d
 DesktopCount++
 CurrentDesktop = %DesktopCount%
 OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
}
;
; This function deletes the current virtual desktop
;
deleteVirtualDesktop()
{
 global CurrentDesktop, DesktopCount
 SendInput #^{F4}
 DesktopCount--
 CurrentDesktop--
 OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
}
; Main
SetKeyDelay, 75
mapDesktopsFromRegistry()
OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%
; User config!
; This section binds the key combo to the switch/create/delete actions
;LWin & 1::switchDesktopByNumber(1)
;LWin & 2::switchDesktopByNumber(2)
;LWin & 3::switchDesktopByNumber(3)
;LWin & 4::switchDesktopByNumber(4)
;LWin & 5::switchDesktopByNumber(5)
;LWin & 6::switchDesktopByumber(6)
;LWin & 7::switchDesktopByNumber(7)
;LWin & 8::switchDesktopByNumber(8)
;LWin & 9::switchDesktopByNumber(9)
CapsLock & 1::switchDesktopByNumber(1)
CapsLock & 2::switchDesktopByNumber(2)
CapsLock & 3::switchDesktopByNumber(3)
CapsLock & 4::switchDesktopByNumber(4)
CapsLock & 5::switchDesktopByNumber(5)
;CapsLock & 6::switchDesktopByNumber(6)
;CapsLock & 7::switchDesktopByNumber(7)NNn
;CapsLock & 8::switchDesktopByNumber(8)C
;CapsLock & 9::switchDesktopByNumber(9)
^!NumPadAdd::switchDesktopByNumber(CurrentDesktop + 1)
^!NumPadSub::switchDesktopByNumber(CurrentDesktop - 1)
;CapsLock & s::switchDesktopByNumber(CurrentDesktop + 1)
;CapsLock & a::switchDesktopByNumber(CurrentDesktop - 1)
CapsLock & c::createVirtualDesktop()
CapsLock & d::deleteVirtualDesktop()
; Alternate keys for this config. Adding these because DragonFly (python) doesn't send CapsLock correctly.
;^!1::switchDesktopByNumber(1)
;>^>!1::switchDesktopByNumber(1)
;^!2::switchDesktopByNumber(2)
;>^>!2::switchDesktopByNumber(2)
;^!3::switchDesktopByNumber(3)
;^!4::switchDesktopByNumber(4)
;^!5::switchDesktopByNumber(5)
;^!6::switchDesktopByNumber(6)
;^!7::switchDesktopByNumber(7)
;^!8::switchDesktopByNumber(8)
;^!9::switchDesktopByNumber(9)
;^!n::switchDesktopByNumber(CurrentDesktop + 1)
;^!p::switchDesktopByNumber(CurrentDesktop - 1)
;^!s::switchDesktopByNumber(CurrentDesktop + 1)
;^!a::switchDesktopByNumber(CurrentDesktop - 1)
;^!c::createVirtualDesktop()
;^!d::deleteVirtualDesktop()

Return

;;======================PORTED TO V2===============================;;

/*

^+w::
p := Morse()
If (p = "0")
	{
IfWinNotExist, ahk_exe WhatsApp.exe
Run, "D:\Programs\WhatsApp.lnk"

if WinActive("ahk_exe WhatsApp.exe")
	SendInput #{Down}
else
	WinActivate ahk_exe WhatsApp.exe
Return
}
Else If (p = "00")
	{
IfWinNotExist, ahk_exe Telegram.exe
Run, "D:\Programs\Telegram Desktop.lnk"

if WinActive("ahk_exe Telegram.exe")
	SendInput #{Down}
else
	WinActivate ahk_exe Telegram.exe
Return
}
Else
	{
Tooltip, Press pattern %p%
SetTimer, RemoveToolTip, -1000
}
Return

$^+z::
KeyWait, z, T0.2
if !ErrorLevel
{
	GroupAdd, BraveGroup, ahk_exe brave.exe
	IfWinNotExist, ahk_exe brave.exe
		Run, "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
		GroupAdd, mybrave, ahk_exe brave.exe
	If WinActive("ahk_exe brave.exe")
		GroupActivate, BraveGroup, r
	else
		Run, "D:\AHK\Brave.ahk"
	return
}
else
{	
	KeyWait, e, T1
	Run, "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
}
Return
; IfWinNotExist, ahk_exe brave.exe
; 	Run, "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

; if WinActive("ahk_exe brave.exe")
; 	Sendinput ^{tab}
; else
; 	WinActivate ahk_exe brave.exe
; Return

$^+x::
IfWinNotExist, ahk_exe opera.exe
		Run, "C:\Users\Shamil\AppData\Local\Programs\Opera GX\opera.exe"

	if WinActive("ahk_exe opera.exe")
		Sendinput ^{tab}
	else
		Run, "D:\AHK\Opera.ahk"
Return

>^Up::
If WinActive("ahk_exe Spotify.exe")
	SendInput, {Ctrl Down}{Up}{Ctrl Up}
else
	SendInput, {Volume_Up}
Return

>^Down::
If WinActive("ahk_exe Spotify.exe")
	SendInput, {Ctrl Down}{Down}{Ctrl Up}
else
	SendInput, {Volume_Down}
Return

>^+Left::Media_Play_Pause

>^+Right::Media_Next

#IfWinActive ahk_class Qt5QWindowIcon

^Left::
SendInput {Ctrl Down}{Left}{Ctrl Up}
Return

^Right::
SendInput {Ctrl Down}{Right}{Ctrl Up}
Return

^+e::
; KeyWait, e, T0.2
; if !ErrorLevel
; {
	IfWinNotExist, ahk_exe Notion.exe
		Run, "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
	if WinActive("ahk_exe Notion.exe")
		WinMinimize, ahk_exe Notion.exe
	else
		WinActivate ahk_exe Notion.exe
; }
; else
; {
;     p := Morse()
; 	If (p = "1")
; 		SendInput ^+c
; }
Return

#IfWinActive ahk_exe brave.exe

!q::
MouseGetPos, x, y
MouseClick, Left, 1755, 922,,0
MouseMove, x, y, 0
Return


^+q::
p := Morse()
KeyWait, q, T0.2
if !ErrorLevel
{
Run, "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
}
else
{
p := Morse()
If (p = "1")
{
tooltip, qbittorrent
SetTimer, RemoveToolTip, -200
IfWinNotExist, ahk_exe qbittorrent.exe
		Run, "C:\Program Files\qBittorrent\qbittorrent.exe"

	if WinActive("ahk_exe qbittorrent.exe")
		WinMinimize, ahk_exe qbittorrent.exe
	else
		WinActivate ahk_exe qbittorrent.exe
Return
}
Else If (p = "11")
	Run, "D:\Programs\Steam Big Picture.lnk"
Else
{
	Tooltip, Press pattern %p%
	SetTimer, RemoveToolTip, -1000
}
}
Return

^+f::
KeyWait, f, T0.2
if !ErrorLevel
{
IfWinNotExist, ahk_exe WindowsTerminal.exe
{
	; Run, "C:\Users\Shamil\Shortcuts\Terminal - Shortcut.lnk"
	Run, cmd.exe /k cd D:\ && cd adb
}
	if WinActive("ahk_exe WindowsTerminal.exe")
		SendInput ^{tab}
	else if WinActive("ahk_exe cmd.exe")
		SendInput ^{tab}
	else
		WinActivate, ahk_exe WindowsTerminal.exe
		WinActivate, ahk_exe cmd.exe
Return
}
else
{
p := Morse()
If (p = "100")
{
	Run, cmd /c ipconfig | find "IPv4" | find "192.168" > ip.txt, ,Hide,
	sleep 1000
	FileName := "D:\AHK\ip.txt"
	FileRead, ipadd, %FileName%
	i := 0
	Loop, parse, ipadd, " ", :
	{
		i++
		if (i==17){
			tooltip, Local IP: %A_LoopField%
		}
	}
	SetTimer, RemoveToolTip, -3000
}
Else If (p = "10")
{
	Run, cmd /c cd /d "C:\Program Files\Sunshine\tools" && dxgi-info.exe | find "Output Name" > "D:\AHK\disp.txt", ,Hide,
	sleep 1000
	FileName := "D:\AHK\disp.txt"
	FileRead, ipadd, %FileName%
	i := 0
	Loop, parse, ipadd, " ", :
	{	
		i++
		if (i==27){
			tooltip, Display ID: %A_LoopField%
		}
	}
	SetTimer, RemoveToolTip, -3000
}
Else
{
	Tooltip, Press pattern %p%
	SetTimer, RemoveToolTip, -1000
}
}
Return


^+d::
IfWinNotExist, ahk_exe Code.exe
	Run, "C:\Program Files\Microsoft VS Code\Code.exe"
else
{
	if WinActive("ahk_exe Code.exe")
		Sendinput {Ctrl}
	else
		WinActivate ahk_exe Code.exe
}
Return

^+y::
If WinActive("ahk_exe opera.exe")
{
	Run, "C:\Users\Shamil\AppData\Local\Programs\Opera GX\opera.exe" https://www.youtube.com/feed/subscriptions
	Return
}
Else
	Run, https://www.youtube.com/feed/subscriptions
Return


!1::Menu, MyMenu3, Show
Return

!2::
IfWinNotActive ahk_exe vlc.exe
    {
		for g_name, g_location in Games
			Menu, Game, Add, %g_name%, GamesHandler
		Menu, MyMenu1, Add, Games, :Game
		Menu, MyMenu1, Show
	}
Else
	SendInput, {Ctrl Down}1{Ctrl Up}
return

!3::
IfWinNotActive ahk_exe vlc.exe
	Menu, MyMenu2, Show
Else
	SendInput, {Ctrl Down}2{Ctrl Up}
Return

!4::
IfWinNotActive ahk_exe vlc.exe
	Menu, MyMenu7, Show
Else
	SendInput, {Ctrl Down}3{Ctrl Up}
Return

!5::
IfWinNotActive ahk_exe vlc.exe
	Menu, MyMenu4, Show
Else
	SendInput, {Ctrl Down}4{Ctrl Up}
Return

^+!z::
p := Morse()
If (p = "0")
{
Run, cmd.exe /c E: && cd D:\Programs\Display Changer && dc64.exe -refresh=144
Run, powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e
}
Else If (p = "00")
{
Run, powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e
Run, cmd.exe /c E: && cd D:\Programs\Display Changer && dc64.exe -refresh=144
}
Else If (p = "000")
{
Run, cmd.exe /c E: && cd D:\Programs\Display Changer && dc64.exe -refresh=48
Run, powercfg -s a1841308-3541-4fab-bc81-f71556f20b4a
}
Else
	{
	Tooltip, Press pattern %p%
	SetTimer, RemoveToolTip, -1000
}
Return



*/