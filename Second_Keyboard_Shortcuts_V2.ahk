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

ITH1 := InterceptionTapHold(AHI, keyboardId, 300, 300)
THKeys := [
    "Insert", "End", "Home", "End", "PgUp", "PgDown", "1",
    "2", "3", "4", "5", "6"
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
    key_name := GetKeyName(Format("sc{:X}", sc_code))
    if state = 1
        switch key_name {
            case "NumpadEnd":
            {
                ToolTip "Launching the Apps..."
                RunApplication("Microsoft​ Edge", , "#1")
                Sleep 500
                RunApplication("Brave", , "#2")
                Sleep 500
                RunApplication("Spotify Free", , "#3")
                Sleep 500
                RunApplication("Visual Studio Code", , "#4")
                ToolTip ""
            }
                ;========================= NumRow ==============================================;

            case "7": Run("https://github.com/Shamil-Xero")
            case "8":
            case "9":
            case "0": Run("C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE")
            case "-": Run("C:\Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE")
            case "=": Run("C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE")

                ;========================= Alphabets ==============================================;

            case "b": RunApplication("Notion Calendar", "D:\Programs\Notion Calendar.lnk")
            case "c": RunApplication("Visual Studio Code", , "#4", "^{Tab}")
            case "e": Run "C:\Program Files\qBittorrent\qbittorrent.exe"
            case "d": Run "https://www.youtube.com/"
            case "f": Run("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/"
            )
            case "n": RunApplication("ahk_exe Notion.exe", "C:\Users\shami\AppData\Local\Programs\Notion\Notion.exe")
            case "q": RunApplication("WhatsApp", "D:\Programs\WhatsApp.lnk")
            case "r": ListLines
            case "s": RunApplication("Spotify Free", , "#3")
            case "v": RunApplication("TickTick", "D:\Programs\TickTick\TickTick.exe")
            case "w": RunApplication("Telegram", "D:\Programs\Telegram Desktop.lnk")
            case "x": RunApplication("Brave", , "#2", "^{Tab}")
            case "z": RunApplication("Microsoft​ Edge", , "#1", "^{Tab}")

                ;========================= Special keys ==============================================;
            case "[": RunApplication("Adobe Photoshop", "C:\Program Files\Adobe\Adobe Photoshop 2024\Photoshop.exe", ,
                "#{Down}")
            case "]": RunApplication("Adobe Lightroom", "C:\Program Files\Adobe\Adobe Lightroom 2024\Lightroom.exe")
            case ";": RunApplication("Adobe Premiere Pro",
                "C:\Program Files\Adobe\Adobe Premiere Pro 2024\Adobe Premiere Pro.exe")
            case "'": RunApplication("Adobe After Effects",
                "C:\Program Files\Adobe\Adobe After Effects 2024\Adobe After Effects.exe")
            case "\": RunApplication("Davinci Resolve")

            case "Space": SendInput("{Media_Play_Pause}")
            case "LWin": SendInput "{LWin}"
            case "Escape": Reload
            default:
            {
                ToolTip("Keyboard Key : " key_name ", State: " state)
                SetTimer RemoveToolTip, -2000
            }
        }
}

TapHoldFunction(keyname, isHold, taps, state) {
    held := isHold
    switch keyname {
        case "End":
        {
            if held {
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

        case "1":
        {
            if held {
                Run("D:\Code\AHK.code-workspace")
            }
            else {
                Run("D:\Code\AHK")
            }
        }
        case "2":
        {
            if held {
                Run("D:\Code\C.code-workspace")
            }
            else {
                Run("D:\Code\C")
            }
        }
        case "3":
        {
            if held {
                Run("D:\Code\Python.code-workspace")
            }
            else {
                Run("D:\Code\Python")
            }
        }
        case "4":
        {
            if held {
                Run("D:\Code\Java.code-workspace")
            }
            else {
                Run("D:\Code\Java")
            }
        }
        case "5":
        {
            if held {
                Run("D:\Code\JavaScript.code-workspace")
            }
            else {
                Run("D:\Code\JavaScript")
            }
        }
        case "6":
        {
            if held {
                Run("D:\Code\TSMS.code-workspace")
            }
            else {
                Run("D:\Code\TSMS")
            }

        }
        default:
        {
            ToolTip("KB 1 Key " keyname "`n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state
            )
            SetTimer RemoveToolTip, -2000
        }
    }

}

; MouseButtonEvent(code, state){
; 	ToolTip("Mouse Button - Code: " code ", State: " state)
; }
