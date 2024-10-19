#Requires AutoHotkey v2.0
#SingleInstance force

; Demonstrates Interception Subscription Mode with TapHoldManager

; Use these includes if you placed the contents of the TapHoldManager and AutoHotInterception Lib folders in the AHK lib folder (My Documents\AutoHotkey\Lib)
; #include <AutoHotInterception>
; #include <InterceptionTapHold>qqqqqqw
; #include <TapHoldManager>

; Use these includes if you placed the contents of the TapHoldManager and AutoHotInterception Lib folders in a lib folder next to this script
; ie copy the AutoHotInterception Lib folder into the TapHoldManager Lib folder
#include Lib\AutoHotInterception.ahk
#include Lib\InterceptionTapHold.ahk
#include Lib\TapHoldManager.ahk

AHI := AutoHotInterception()
; keyboard1Id := AHI.GetDeviceIdFromHandle(false, "HID\VID_03EB&PID_FF02&REV_0008&MI_03")
keyboardId := AHI.GetKeyboardId(0xC0F4, 0x04F5)
; keyboard1Id := 3
ITH1 := InterceptionTapHold(AHI, keyboardId)
THKeys := [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=",
    "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"
    "Insert", "End", "Home", "Delete", "PgUp", "PgDown",
]

Keys := [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
]

i := 1
; Subscribe to the keys and add the TapHoldFunction as the callback function.
for key in Keys {
    ToolTip i
    i++
    ITH1.Add(key, TapFunction, 100)
}
for key in THKeys {
    ToolTip i
    i++
    ITH1.Add(key, TapHoldFunction)

}

ListLines
ToolTip ""
return

TapFunction(keyname, isHold, taps, state) {
    switch keyname {
        case "a":
        {
            MsgBox "a is pressed twise and held"
        }
        default:
            ToolTip("KB 1 Key " keyname "`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state)
    }
}

TapHoldFunction(keyname, isHold, taps, state) {
    switch keyname {
        case "Insert":
        {
            if (taps == 2 && isHold) {
                MsgBox "Insert key pressed"
            }
        }
        default:
            ToolTip("KB 1 Key " keyname "`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state)
    }
}

^Esc:: {
    Reload
    ExitApp
}
