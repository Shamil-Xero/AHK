#Requires AutoHotkey v2.0
#SingleInstance force
SendMode "Input"
Persistent
#Include <Lib>
#include Lib\AutoHotInterception.ahk
; #Include "%A_WorkingDir%\V2_Lib.ahk"

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
Numpad9::ToolTip A_ThisHotkey

Numpad0 UP::
Numpad1 UP::
Numpad2 UP::
Numpad3 UP::
Numpad4 UP::
Numpad5 UP::
Numpad6 UP::
Numpad7 UP::
Numpad8 UP::
Numpad9 UP::ToolTip ""