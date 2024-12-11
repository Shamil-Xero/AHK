#Requires AutoHotkey v2.0
SetWorkingDir A_WorkingDir  ; Ensures a consistent starting directory.
TraySetIcon A_WorkingDir "`\AutoHotKeyV2.png"
Persistent

;====================== ====================================;;
#Include <Lib>

; Run(A_WorkingDir "\Second_Keyboard_Shortcuts_V2.ahk")

Run A_WorkingDir "\Second_Keyboard_Shortcuts_V2.ahk"

; Run "*RunAs " A_WorkingDir "\Minimize_To_Tray.ahk"

; Run A_WorkingDir "\All_Keyboard_Shortcuts.ahk"

; RunWait '*RunAs cmd.exe /c taskkill /IM intercept.exe /F', , "Hide"

; Run '*RunAs cmd.exe /c "Intercept\intercept.exe " /apply', , "Hide"

;===============================SPECIAL KEYS===================================::

!`:: {
    Reload
    ; Run, cmd.exe /c "taskkill /f /im autohotkey.exe"
}

Browser_Favorites:: {
    ; Speach := "dooooooont press this"
    ; Runwait A_WorkingDir '\voice.exe' ' -r' ' 2' ' -d' Speach,,'Hide'
    SendInput "^+{Esc}"
    ; MsgBox A_ThisHotKey
}

Launch_Mail:: return

;Media_Play_Pause::Return

Media_Stop:: return

;Media_Prev::Return

;Media_Next::Return

~Volume_Up:: return

~Volume_Down:: return

;Volume_Mute::Return

Launch_App1:: Msgbox "Hi"

;===============================END OF SPECIAL KEYS============================;;

#HotIf WinActive("ahk_class CabinetWClass") ;Clicks the Folder path in File explorer like clicking the url in browsers

^e:: SendInput "^l"

#HotIf !WinActive("ahk_exe Overwatch.exe")
~^c:: {
    ToolTip "Copied"
    SetTimer RemoveTooltip, -250
}

~^v:: {
    ToolTip "Pasted"
    SetTimer RemoveToolTip, -250
}

~^x:: {
    ToolTip "Cuted"
    SetTimer RemoveToolTip, -250
}
#HotIf

; #e::Run "explorer.exe"

!i:: SendInput "{Up}"
!k:: SendInput "{Down}"
!l:: SendInput "{Right}"
!j:: SendInput "{Left}"

>^\::AltTab
RCtrl & RAlt::AppsKey
$CapsLock::Backspace
+CapsLock::CapsLock

;===================== Tap, Press & Hold Shortcuts ======================;

; ~LWin:: {
;     if (KeyWait(GetFilteredHotKey(), "T0.4")) {
;         ; SendInput "{Lwin}"
;     }
;     else if (KeyWait(GetFilteredHotKey(), "T1")) {
;         ; msgbox "Press"
;     }
;     else if (KeyWait(GetFilteredHotKey(), "T10")) {
;         ; msgbox "Hold"
;     }
; }

;===================== Ctrl & Shift Shortcuts ======================;

^+d:: {
    exe_process := "ahk_exe Code.exe"
    exe_name := " - Visual Studio Code"
    exe_location := "C:\Program Files\Microsoft VS Code\Code.exe"

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {

        if WinActive(exe_name) {
            WinMinimize
            ; SendInput "#4"
        }
        else {
            if not WinExist(exe_name) {
                ; Run exe_location
                SendInput "#4"
            }
            else {
                WinActivate(exe_name)
                ; SendInput "#4"
            }
        }
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

^+e:: {

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Users\Shamil\AppData\Local\Programs\cron-web\Notion Calendar.exe"
    }
}

^+f:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run '*RunAs cmd.exe'
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    }
}

^+g:: {
    p := Morse()
    if (p = "00") {
        Run '*RunAs cmd.exe /k pnputil /enum-devices /class Display', , "Hide" ; //To find the display;
        Run '*RunAs cmd.exe /c pnputil "/enable-device" "ROOT\UNKNOWN\0000"', , "Hide"
        ToolTip "Virtual Display Enabled"
        SetTimer RemoveToolTip, -500
    }
    else if (p = "01") {
        Run '*RunAs cmd.exe /k pnputil "/disable-device" "ROOT\UNKNOWN\0000"', , "Hide"
        ToolTip "Virtual Display Disabled"
        SetTimer RemoveToolTip, -500
    }
    else if (p = "0") {
        ipadd := ComObject("WScript.Shell").Exec(A_ComSpec " /c " 'ipconfig | find "IPv4"').StdOut.ReadAll()
        i := 0
        ToolTip ipadd
        ; loop parse, ipadd, ":" "`n" {
        ;     i++
        ;     if (i == 60) {
        ;         ToolTip "Local IP: " A_LoopField
        ;         A_Clipboard := A_LoopField

        ;         break
        ;     }
        ; }
        SetTimer RemoveToolTip, -3000
    }
    else if (p = "1") {
        ipadd := ComObject("WScript.Shell").Exec(A_ComSpec " /C " '"C:\Program Files\Sunshine\tools\dxgi-info.exe"').StdOut
        .ReadAll()
        i := 0
        loop parse, ipadd, "`n" ":" {
            i++
            if (i = 24) {
                tooltip "Display ID: " A_LoopField
                A_Clipboard := A_LoopField
                break
            }
        }
        SetTimer RemoveToolTip, -3000
    }
    else if (p = "10") {
        Run "D:Code\ADB\Sunshine.bat"
    }
    else
        MsgBox p
}

^+q:: {

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run("https://www.youtube.com/")
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run(
            '"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/"'
        )
    }
}

$^+s:: {
    exe_process := "ahk_exe Spotify.exe"
    exe_name := "Spotify Free"
    exe_location := "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe"

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        SendInput "^+s"
    } else {
        KeyWait(GetFilteredHotKey(), "T10")
        if WinActive(exe_name) {
            WinMinimize
        }
        else {
            if not WinExist(exe_name) {
                ; Run exe_location
                SendInput "#3"
            }
            else {
                WinActivate(exe_name)
            }
        }
    }
}

^+w:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
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
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        exe_name := "Unigram"
        exe_process := "ahk_exe Unigram.exe"
        exe_location := "D:\Programs\Unigram.lnk"

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
}

^+x:: {
    exe_name := " - Brave"
    exe_location := "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
    ; RunApplication(exe_name, exe_location)

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        if WinActive(exe_name) {
            SendInput "^{Tab}"
        }
        else {
            if not WinExist(exe_name) {
                ; Run exe_location
                SendInput "#2"
            }
            else {
                WinActivate exe_name
                ; SendInput "#2"
            }
        }
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

; j:: {
;     ActiveHwnd := WinActive("A")
;     WinActivate("- Brave")
;     ControlSend("{Right}", , " - Brave")
;     ; if TargetError
;     ;     msgbox "Window/ Class not found"
;     WinActivate(ActiveHwnd)
; }

; k:: {
;     MyGui := Gui()
;     MyGui.Add("Edit", "r10 w500")
;     MyGui.Show()
;     ControlSend "This is a line of text in the edit control.{Enter}", "Edit1", MyGui
;     ControlSendText "Notice that {Enter} is not sent as an Enter keystroke with ControlSendText.", "Edit1", MyGui

; }

^+y:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Program Files\qBittorrent\qbittorrent.exe"
    }
}

^+z:: {
    exe_process := "ahk_exe msedge.exe"
    exe_name := " - Microsoft​ Edge"
    exe_location := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {

        if WinActive(exe_name) {
            SendInput '^{Tab}'
        }
        else {
            if not WinExist(exe_name) {
                ; Run exe_location
                SendInput "#1"
            }
            else {
                WinActivate exe_name
            }
        }
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

^+Up:: {
    global CurrentBrightness
    ChangeBrightness(CurrentBrightness += Brightness_Increments)
}
^+Down:: {
    global CurrentBrightness
    ChangeBrightness(CurrentBrightness -= Brightness_Increments)
}

;=============================== Alt & Ctrl Shortcuts =================================;
^!s:: SendInput "^#v"

^!z:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run "D:\Programs\Shortcuts\Lenovo Vantage.lnk"
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Users\Shamil\AppData\Local\Playnite\Playnite.DesktopApp.exe"
    }
}

; ^!1:: Run "D:\Code\AHK\Files Move.ahk"

; ^!2:: Run "D:\Code\AHK\Files Move2.ahk"

!+3:: Run "D:\Code\AHK\Files Move3.ahk"

;================================= Ctrl Shortcuts =======================================;

;================================= Alt Shortcuts =======================================;

#HotIf WinActive("ahk_exe Photoshop.exe")

#HotIf

;================================= Win Shortcuts =======================================;

#c:: Run "D:\Programs\Copilot.lnk"

#e:: {

    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        GroupAdd "ExplorerGroup", " - File Explorer"
        if !WinExist(" - File Explorer") {

            Run "explorer.exe"
            GroupAdd "ExplorerGroup", " - File Explorer"
        }
        else if WinActive("ahk_exe explorer.exe")
            GroupActivate "ExplorerGroup", "r"
        else
            WinActivate " - File Explorer"
        return
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "explorer.exe"
    }
}

; #e:: {

;     if (KeyWait(GetFilteredHotKey(), "T0.4")) {
;         GroupAdd "ExplorerGroup", " - Files"
;         if !WinExist(" - Files") {
;             Run "C:\Program Files\WindowsApps\Files_3.8.0.0_x64__1y0xx7n9077q4\Files.App\Files.exe"
;             GroupAdd "myexplorers", " - Files"
;         }
;         else if WinActive(" - Files.exe")
;             GroupActivate "ExplorerGroup", "r"
;         else
;             WinActivate " - Files"
;         return
;     }
;     else {
;         KeyWait(GetFilteredHotKey(), "T10")
;         Run "C:\Program Files\WindowsApps\Files_3.8.0.0_x64__1y0xx7n9077q4\Files.App\Files.exe"
;     }
; }

;================================= Other Shortcuts =====================================;

^+WheelUp:: Run "C:\Windows\System32\SndVol.exe"
^+WheelDown:: Run "D:\Programs\Nahimic.lnk"

^+/:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        Run "C:\Windows\System32\SndVol.exe"
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        Run "D:\Programs\Nahimic.lnk"
    }
}

!w:: SendInput "!{F4}"
; ^+WheelDown::
#s:: SendInput "{Printscreen}"
#+s:: SendInput "#+t"
^!b:: {
    if WinExist("Window Spy for AHKv2")
        WinActivate("Window Spy for AHKv2")
    else
        Run "C:\Program Files\AutoHotkey\WindowSpy.ahk"
}
^+m:: Run "C:\Windows\System32\mblctr.exe"

>^Up::Volume_Up
>^Down::Volume_Down
>^Left::Media_Play_Pause
>^Right::Media_Next

;========================== Context Sensitive Shortcuts =======================================;

#HotIf WinActive("ahk_exe Overwatch.exe")

:*:asdf:: {
    Overwatch_Login()
}

#HotIf !WinActive("ahk_exe vlc.exe")
!1:: MyMenu1.Show()
!2:: MyMenu2.Show()
!3:: MyMenu3.Show()
!4:: MYMenu4.Show()
!5:: MyMenu5.Show()
!+z:: MyMenu6.Show()

#HotIf WinActive("ahk_class Qt5QWindowIcon")
/:: SendInput "jjj"
0:: Send "{Ctrl Down}{WheelUp}{Ctrl Up}"
9:: Send "{Ctrl Down}{WheelDown}{Ctrl Up}"
BS::
\:: Send "^{Right}{Right}{Right}+{Right}+{Right}+{Right}"
>^Left:: SendInput "^{Left}"
>^Right:: SendInput "^{Right}"

#HotIf WinActive("ahk_exe Spotify.exe")
>^Up:: SendInput "^{Up}"
>^Down:: SendInput "^{Down}"

#HotIf WinActive("ahk_exe brave.exe")
!q:: {

    MouseGetPos &x, &y
    MouseClick "Left", 1755, 922, , 0
    MouseMove x, y, 0
}

#HotIf MouseIsOver("TrayNotifyWnd1")
WheelUp:: ToolTip "#+m"
WheelDown:: ToolTip "#m"

#HotIf

;================================= Controller Controls =======================================;

; #HotIf GetKeyState("Joy11", "P")
; Joy2:: {
;     if GetKeyState("Joy11", "P") {
;         SendInput "{Media_Play_Pause}"
;         Current_Window := WinGetTitle("A")
;         WinActivate("-YouTube")
;         ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
;         ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
;         SendInput "k"
;         WinActivate(Current_Window)
;     }
; }

; Joy1:: {
;     if GetKeyState("Joy11", "P") {
;         SendInput "{Media_Play_Pause}"
;     }
; }
#HotIf
;================================= Secret Codes =======================================;

; z:: {
;     p := Morse()
; ToolTip p
; if (p = "0") {
;     MsgBox "Short press"
; } else if (p = "00") {
;     MsgBox "Two short presses"
; } else if (p = "01") {
;     MsgBox "Short+Long press"
; } else {
;     MsgBox "Press pattern " p
; }
; }

`:: {
    if (KeyWait(GetFilteredHotKey(), "T0.4")) {
        global Macro
        Macro := !Macro
        ToolTip Macro
        SetTimer RemoveToolTip, -200
    }
    else {
        KeyWait(GetFilteredHotKey(), "T10")
        SendInput "{ASC 96}"
    }
}

; KeyWait, %A_ThisHotKey%, T0.4
; if !ErrorLevel
; {
; 	Run, "D:\AHK\Get_KeyCodes.ahk"
; 	Tooltip, `
; 	Settimer, RemoveToolTip, -500
; }
; else
; {
;     KeyWait, %A_ThisHotKey%, T0.5
;     SendInput, {ASC 96}
; }
;

; #Include "%A_WorkingDir%\Second_Keyboard_Shortcuts_V2.ahk"

;{====================== Macros ===============================;

#HotIf GetKeyState("ScrollLock", "T") || Macro
F1::
F2::
F3::
F4::
F5::
F6::
F7::
F8::
F9::
F10::
F11::
F12::
a::
b::
c::
d::
e::
f::
g::
h::
i::
j::
k::
l::
m::
n::
o::
p::
q::
r::
s::
t::
u::
v::
w::
x::
y::
z::
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
Numpad0::
NumpadAdd::
NumPadSub::
NumpadMult::
NumpadDiv::
Space::
Up::
Down::
Right::
Left:: GetHotKey()
#Hotif