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
Run "D:\Programs\AHK\Developement\HidMacros\HIDMacros.exe"

global MyGui := ""
global currentMode := 1

AHI := AutoHotInterception()
keyboard1Id := AHI.GetKeyboardId(0x32C2, 0x0012, 1)
interception := AHI.CreateContextManager(keyboard1Id)

numpad_intercepted(){
    return interception.IsActive
}

#HotIf interception.IsActive
NumpadDiv::{
    global currentMode
    currentMode := Mod(currentMode, 2) + 1
    ShowNumpadGUI(MyGui, currentMode)
}

#Include Numpad_Hotkeys.ahk

#HotIf