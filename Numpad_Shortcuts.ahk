#Requires AutoHotkey v2.0
#SingleInstance force
SendMode "Input"
Persistent
#Include <Lib>
#include Lib\AutoHotInterception.ahk
; #Include "%A_WorkingDir%\V2_Lib.ahk"
TraySetIcon A_WorkingDir "`\Lib\Numpad.png"

AHI := AutoHotInterception()
id1 := AHI.GetKeyboardId(0x32C2, 0x0012, 1)
cm1 := AHI.CreateContextManager(id1)
ToolTip "Interception Enabled"
SetTimer RemoveToolTip, -500
return

#HotIf cm1.IsActive

Numpad0::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
NumpadDot::ToolTip A_ThisHotkey
NumpadDiv:: {
    RunWait 'cmd.exe /c python "D:\Programs\AHK\Random-Youtube-Video.py"', , "Hide"
}
NumpadMult::
NumpadAdd::
NumpadSub::ToolTip A_ThisHotkey
NumpadEnter::Media_Play_Pause


Numpad1 UP::
Numpad2 UP::
Numpad3 UP::
Numpad4 UP::
Numpad5 UP::
Numpad6 UP::
Numpad7 UP::
Numpad8 UP::
Numpad9 UP::
NumpadDot UP::
NumLock UP::
NumpadDiv UP::
NumpadMult UP::
NumpadAdd UP::
NumpadSub UP::
NumpadEnter UP::ToolTip ""