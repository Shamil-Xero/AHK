#Requires AutoHotkey v2.0

; // cspell:disable (This is for disabling the spell check in VSCode)

#SingleInstance force
SendMode "Input"
Persistent
#Include <Lib>
#include <AutoHotInterception>
#include <InterceptionTapHold>
#include <TapHoldManager>

; Run "cmd.exe /c regsvr32 HIDMacros.exe", , "Hide"

global MyGui := ""
global currentMode := 2

AHI := AutoHotInterception()
keyboard1Id := AHI.GetKeyboardId(0x32C2, 0x0012, 1)
; keyboard1Id := AHI.GetKeyboardId(0x048D, 0xC986, 1) ; Laptop(For Testing)
interception := AHI.CreateContextManager(keyboard1Id)
Run "D:\Programs\AHK\Developement\HidMacros\HIDMacros.exe"
ToolTip "Interception Enabled"
SetTimer RemoveToolTip, -1000

numpad_intercepted() {
    return interception.IsActive
}

#HotIf interception.IsActive
NumpadDiv:: {
    global currentMode
    currentMode := Mod(currentMode, 2) + 1
    ShowNumpadGUI()
}

#Include Numpad_Hotkeys.ahk

#HotIf