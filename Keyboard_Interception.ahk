#Requires AutoHotkey v2.0
#SingleInstance force      ; Ensures only one instance of this script runs at a time
SendMode "Input"          ; Makes Send synonymous with SendInput (faster and more reliable)
Persistent               ; Keeps script running even after auto-execute section completes
#Include <Lib>           ; Include standard library
#include <AutoHotInterception>
#include <InterceptionTapHold>
#include <TapHoldManager>

try {
    RemoveToolTips() {
        ToolTip ; Removes the tooltip
    }
}

; // cspell:disable (This is for disabling the spell check in VSCode)

; Initialize AutoHotInterception for a specific keyboard
AHI := AutoHotInterception()

; Get keyboard ID for specific vendor/product ID (likely a numpad device)
id1 := AHI.GetKeyboardId(0x32C2, 0x0012, 1) ; Numpad
; id1 := AHI.GetKeyboardId(0x048D, 0xC986, 1) ; Laptop

ITH := InterceptionTapHold(AHI, id1, 10)
ToolTip "Interception Enabled"  ; Show temporary tooltip when script starts
SetTimer RemoveToolTips, -1000    ; Remove tooltip after 1000ms

numpadKeys := [
    "Numpad0",
    "Numpad1",
    "Numpad2",
    "Numpad3",
    "Numpad4",
    "Numpad5",
    "Numpad6",
    "Numpad7",
    "Numpad8",
    "Numpad9",
    "NumpadDot",
    "NumpadAdd",
    "NumpadSub",
    "NumpadMult",
    "NumpadDiv",
    "NumpadEnter"
]

for key in numpadKeys {
    ; Add(keyName, callback, tapTime?, holdTime?, maxTaps?)
    ITH.Add(key, Numpad)
}

; Numpad(keyName, isHold, taps, state) {
;     Tooltip "Key: " keyName "`nIsHold: " isHold "`nTaps: " taps "`nState: " state
;     SetTimer RemoveToolTips, -1000
; }

Numpad(keyName, isHold, taps, state) {
    switch keyName, false {
        case "Numpad0":
            if (state) {
                Send "{Media_Play_Pause}"
            }

        default:
            Tooltip "Key: " keyName "`nIsHold: " isHold "`nTaps: " taps "`nState: " state
            ; SetTimer RemoveToolTips, -1000
    }
}

#HotIf