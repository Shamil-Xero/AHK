#Requires AutoHotkey v2.0
#SingleInstance force
TraySetIcon A_WorkingDir "`\keyboard.png"
; #NoTrayIcon
Persistent
#include Lib\AutoHotInterception.ahk
#include Lib\InterceptionTapHold.ahk
#include Lib\TapHoldManager.ahk

AHI := AutoHotInterception()
i := 1

; keyboardId := AHI.GetKeyboardId(0x048D, 0xC986)
keyboardId := AHI.GetKeyboardId(0xC0F4, 0x04F5)
; AHI.SubscribeKey(keyboardId, GetKeySC("2"), true, Toggle, true)
; AHI.UnsubscribeKey(keyboardId, 3)
; AHI.SendKeyEvent(keyboardId, GetKeySC("a"), 1)
AHI.SubscribeKeyboard(keyboardId, true, TapFunction)

ITH1 := InterceptionTapHold(AHI, keyboardId)
THKeys := [
    "Insert", "End", "Home", "End", "PgUp", "PgDown"
]
for key in THKeys
    ITH1.Add(key, TapHoldFunction)
ToolTip "Interception Enabled"
SetTimer RemoveToolTip, -1000
; ListLines
return

; mouseId := AHI.GetMouseId(0x046D, 0xC00C)
; AHI.SubscribeMouseButtons(mouseId, false, MouseButtonEvent)
; return

TapFunction(sc_code, state) {
    if state = 1 {
        key_name := GetKeyName(Format("sc{:X}", sc_code))
        switch key_name {
            case "NumpadEnd":
            {
                ToolTip "Launching the Apps..."
                RunApplication(" - Microsoft​ Edge", , "#1")
                Sleep 500
                RunApplication(" - Brave", , "#2")
                Sleep 500
                RunApplication("Spotify Free", , "#3")
                Sleep 500
                RunApplication(" - Visual Studio Code", , "#4")
                ToolTip ""
            }
            case "Space": SendInput("{Media_Play_Pause}")
            case "r": ListLines
            case "s": RunApplication("Spotify Free", , SendInput("#3"))
            case "x":
            {
                if WinActive(" - Brave") {
                    SendInput '^{Tab}'
                }
                else {
                    if not WinExist(" - Brave") {
                        SendInput "#1"
                    }
                    else {
                        WinActivate " - Brave"
                    }
                }
            }
            case "z":
            {
                if WinActive(" - Microsoft​ Edge") {
                    SendInput '^{Tab}'
                }
                else {
                    if not WinExist(" - Microsoft​ Edge") {
                        SendInput "#1"
                    }
                    else {
                        WinActivate " - Microsoft​ Edge"
                    }
                }
            }
            
            case "Escape": Reload
            default:
            {
                ToolTip("Keyboard Key : " key_name ", State: " state)

            }
        }
    }
}

TapHoldFunction(keyname, isHold, taps, state) {
    isheld := state
    switch keyname {
        case "End":
        {
            if isheld {
                if (taps == 1) {
                    Run 'cmd /c Shutdown /a', , "Hide"
                    ToolTip "PowerOff cancelled"
                    SetTimer RemoveToolTip, -2000
                }
                else if (taps == 2) {
                    shutdown_time := 10
                    Run 'cmd /c Shutdown /s /t ' shutdown_time, , "Hide"
                    ToolTip "Shutting Down in 10 sec"
                    SetTimer RemoveToolTip, -10000
                }
                else if (taps == 3) {
                    restart_time := 10
                    Run 'cmd /c Shutdown /r /t ' restart_time, , "Hide"
                    ToolTip "Restarting in 10 sec"
                    SetTimer RemoveToolTip, -10000
                }
            }
        }
        default:
            ToolTip("KB 1 Key " keyname "`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state)
    }
}

; MouseButtonEvent(code, state){
; 	ToolTip("Mouse Button - Code: " code ", State: " state)
; }
