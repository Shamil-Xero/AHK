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
; ITH2 := InterceptionTapHold(AHI, keyboardId, 50, 2000)
THKeys := [
    "Insert", "End", "Home", "End", "PgUp", "PgDown",
    "1", "2", "3", "4", "5", "6",
    "e", "h",
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

            case "a": RunApplication("VLC media player", "C:\Program Files\VideoLAN\VLC\vlc.exe")
            case "b": RunApplication("Notion Calendar", "D:\Programs\Notion Calendar.lnk")
            case "c": RunApplication("Visual Studio Code", , "#4", "^{Tab}")
            case "d": Run "https://www.youtube.com/"
            case "f": Run '"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/"'
            case "g": Run "http://localhost:8096/web/#/home.html"
            case "i": Run "http://instagram.com/"
            case "n": RunApplication("ahk_exe Notion.exe", "C:\Users\shami\AppData\Local\Programs\Notion\Notion.exe")
            case "o": RunApplication("ahk_class TankWindowClass",
                "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Steam\Overwatch® 2.url")
            case "p": RunApplication("ahk_class TankWindowClas",
                "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Steam\Marvel Rivals.url")
            case "q": RunApplication("WhatsApp", "D:\Programs\WhatsApp.lnk")
            case "r": ListLines
            case "s": RunApplication("Spotify Free", , "#3")
            case "t": RunApplication(" - Discord",
                "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk")
            case "v": Run("D:\Programs\TickTick\TickTick.exe")
            case "w": RunApplication("Unigram", "D:\Programs\Unigram.lnk")
            case "x": RunApplication("Brave", , "#2", "^{Tab}")
            case "y": Run("C:\Users\Shamil\AppData\Local\Playnite\Playnite.DesktopApp.exe")
                ; case "y": Run("D:\Games")
            case "z": RunApplication("Microsoft​ Edge", , "#1", "^{Tab}")

                ;========================= Special keys ==============================================;
            case "[": RunApplication("Adobe Photoshop", "C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe", ,
                "#{Down}")
            case "]": RunApplication("Adobe Lightroom", "C:\Program Files\Adobe\Adobe Lightroom 2024\Lightroom.exe")
            case ";": RunApplication("Adobe Premiere Pro",
                "C:\Program Files\Adobe\Adobe Premiere Pro 2024\Adobe Premiere Pro.exe")
            case "'": RunApplication("Adobe After Effects",
                "C:\Program Files\Adobe\Adobe After Effects 2024\Adobe After Effects.exe")
            case "\": RunApplication("Davinci Resolve")
            case "/": Run("calc.exe")

            case "Space": SendInput("{Media_Play_Pause}")
            case "LWin": SendInput "{LWin}"
            case "Escape": Reload

            case "Left":
            {
                Current_Window := WinGetTitle("A")
                WinActivate(" - YouTube - Brave")
                ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
                ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
                Sleep 10
                SendInput "{Right}"
                WinActivate(Current_Window)
            }
            case "Right":
            {
                Current_Window := WinGetTitle("A")
                WinActivate(" - YouTube - Brave")
                ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
                ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
                Sleep 10
                SendInput "{Right}"
                WinActivate(Current_Window)
            }
            case "Up":
            {
                ; SendInput "{Media_Play_Pause}"
                Current_Window := WinGetTitle("A")
                WinActivate(" - YouTube - Brave")
                ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
                ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
                Sleep 10
                SendInput "d"
                WinActivate(Current_Window)
            }
            case "Down":
            {
                ; SendInput "{Media_Play_Pause}"
                Current_Window := WinGetTitle("A")
                WinActivate(" - YouTube - Brave")
                ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
                ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
                Sleep 10
                SendInput "s"
                WinActivate(Current_Window)
            }
            default:
            {
                ToolTip("Keyboard Key : " key_name ", State: " state)
                SetTimer RemoveToolTip, -2000
            }
        }
}

TapHoldFunction(keyname, isHold, taps, state) {
    held := isHold
    if state != 1
        switch keyname {
            case "End":
            {
                if (taps == 3) {
                    Run 'cmd /c Shutdown /a', , "Hide"
                    ToolTip "PowerOff cancelled"
                    SetTimer RemoveToolTip, -2000
                }
                else if (taps == 1) {
                    shutdown_time := 0
                    Run 'cmd /c Shutdown /s /t ' shutdown_time, , "Hide"
                    ToolTip "Shutting Down in " shutdown_time " sec"
                    SetTimer RemoveToolTip, -10000
                }
                else if (taps == 2) {
                    restart_time := 0
                    Run 'cmd /c Shutdown /r /t ' restart_time, , "Hide"
                    ToolTip "Restarting in " restart_time " sec"
                    SetTimer RemoveToolTip, -10000

                }
            }
            case "e":
            {
                if held {
                    Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
                }
                else {

                    Run "C:\Program Files\qBittorrent\qbittorrent.exe"
                }
            }

            case "h":
            {
                if held {
                    Run("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
                }
                else {
                    Run("C:\Windows\System32\cmd.exe")
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
