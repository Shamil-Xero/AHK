#Requires AutoHotkey v2.0
#Include Credentials.ahk

Keyboard_Codes() {
    global key, Macro
    ToolTip key
    SetTimer RemoveToolTip, -500
    switch key {
        case "w":
        {
            exe_name := "WhatsApp"
            exe_location := "D:\Programs\WhatsApp.lnk"

            if WinActive(exe_name) {
                WinMinimize
            }
            else {
                if not WinExist(exe_name) {
                    Run exe_location
                }
                else {
                    Run exe_location
                }
            }
        }
        case "ww":
        {
            exe_name := "Telegram"
            exe_process := "ahk_exe Telegram.exe"
            exe_location := "D:\Programs\Telegram Desktop.lnk"

            if WinActive(exe_name) {
                WinMinimize
            }
            else {
                Run exe_location
                ; if not WinExist(exe_name) {
                ; }
                ; else {
                ;     WinActivate(exe_name)
                ; }
            }
        }
        case "t":
        {
            Run "F:\Pictures\TimeTable.png"
            return
        }
        case "tt":
        {
            Run "F:\Pictures\FootTableV2.jpg"
            return
        }
        case "a":
        {
            exe_process := "AutoHotkey Help"
            exe_location := "C:\Program Files\AutoHotkey\v1.1.37.02\AutoHotkey.chm"
            if WinActive(exe_process) {
                SendInput '^'
            }
            else {
                if not WinExist(exe_process) {
                    Run exe_location
                    ; SendInput "#1"
                }
                else {
                    WinActivate exe_process
                    ; SendInput "#1"
                }
            }
        }
        case "aa":
        {
            exe_process := "AutoHotkey v2 Help"
            exe_location := "C:\Program Files\AutoHotkey\v2\AutoHotkey.chm"
            if WinActive(exe_process) {
                SendInput '^'
            }
            else {
                if not WinExist(exe_process) {
                    Run exe_location
                    ; SendInput "#1"
                }
                else {
                    WinActivate exe_process
                    ; SendInput "#1"
                }
            }
        }
        case "1n":
        {
            Run "D:\AHK\Null Movement 2.ahk"
        }
        case "1nn":
        {
            WinClose "\Null Movement 2.ahk - AutoHotkey ahk_class AutoHotkey"
        }

            ;================================================================

        case "n":
            Run "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
        case "nn":
            Run "C:\Users\Shamil\AppData\Local\Programs\cron-web\Notion Calendar.exe"
        case "j":
            Run "http://localhost:8096/web/index.html"
        case "s":
            Run "https://localhost:47990/config#"
        case "c":
            Run "calc.exe"
        case "y":
            Run "http://youtube.com/"
        case "yy":
            Run "https://www.youtube.com/feed/subscriptions"
        case "z":
            Send "#{Tab}"
        case "Left":
            SendInput "{Media_Play_Pause}"
        case "Right":
            SendInput "{Media_Next}"
        case "Up":
            SendInput "{Volume_Up}"
        case "Down":
            SendInput "{Volume_Down}"
        case "ama":
            Run "https://www.amazon.in/"
        case "fli":
            Run "https://www.flipkart.com/"
    }

    Credentials_Codes(key)

    key := ""
    Macro := False

}

Overwatch_Login() {
    SetKeyDelay 30
    sleep 500
    Send "swimmingshamil@gmail.com"
    sleep 100
    SendInput "{Tab}"
    sleep 100
    Send "swimsham123{Enter}"
    SetKeyDelay 0
}
