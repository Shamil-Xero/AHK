#Requires AutoHotkey v2.0  ; Specifies that this script requires AHK version 2.0
#SingleInstance force      ; Ensures only one instance of this script runs at a time
SendMode "Input"          ; Makes Send synonymous with SendInput (faster and more reliable)
Persistent               ; Keeps script running even after auto-execute section completes
#Include <Lib>           ; Include standard library
#include Lib\AutoHotInterception.ahk  ; Include the AutoHotInterception library
; #Include "%A_WorkingDir%\V2_Lib.ahk"  ; Commented out include
TraySetIcon A_WorkingDir "`\Lib\Numpad.png"  ; Sets custom tray icon

; Initialize AutoHotInterception for a specific keyboard
AHI := AutoHotInterception()
; Get keyboard ID for specific vendor/product ID (likely a numpad device)
id1 := AHI.GetKeyboardId(0x32C2, 0x0012, 1)
cm1 := AHI.CreateContextManager(id1)
ToolTip "Interception Enabled"  ; Show temporary tooltip when script starts
SetTimer RemoveToolTip, -500    ; Remove tooltip after 500ms
return

#SuspendExempt
NumpadDot:: {
    Suspend
; if GetKeyState("Numpad0", P)
}
#SuspendExempt False

; Only activate these hotkeys when the specific numpad is active
#HotIf cm1.IsActive

; Define hotkeys for numpad keys
; Most keys currently just show a tooltip with the key name
Numpad0::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9:: ToolTip A_ThisHotkey

; NumpadDiv (/) runs a Python script that presumably selects a random YouTube video
NumpadDiv:: {
    RunWait 'cmd.exe /c python "D:\Programs\AHK\Random-Youtube-Video.py"', , "Hide"
}

; More numpad keys that show tooltips
NumpadMult::
NumpadAdd::
NumpadSub:: ToolTip A_ThisHotkey

; NumpadEnter controls media playback
NumpadEnter::Media_Play_Pause

; Clear tooltips when keys are released
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
NumpadEnter UP:: ToolTip ""