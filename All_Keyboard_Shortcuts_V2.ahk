#Requires AutoHotkey v2.0
; Basic settings and configuration
SetWorkingDir A_WorkingDir  ; Ensures a consistent starting directory.
TraySetIcon A_WorkingDir "`\Lib\AutoHotKeyV2.png"
Persistent
SendMode "Input"
SetCapsLockState "Off"
SetNumLockState "On"
SetScrollLockState "Off"

; Include external library files
#Include <Lib>

; Launch additional AutoHotkey scripts
Run A_WorkingDir "\Numpad_Shortcuts.ahk"

; Run A_WorkingDir "\Second_Keyboard_Shortcuts_V2.ahk"

; Run "*RunAs " A_WorkingDir "\Minimize_To_Tray.ahk"

; Run A_WorkingDir "\All_Keyboard_Shortcuts.ahk"

; RunWait '*RunAs cmd.exe /c taskkill /IM intercept.exe /F', , "Hide"

; Run '*RunAs cmd.exe /c "Intercept\intercept.exe " /apply', , "Hide"

;====================== HOTKEY SECTIONS ======================

; 1. Special Keys - System and media control hotkeys
; 2. Basic Navigation - Arrow key alternatives (Alt + IJKL)
; 3. Tap, Press & Hold - Shortcuts with different behaviors based on press duration
; 4. Ctrl & Shift - Application launchers and system functions
; 5. Alt & Ctrl - Window management and system utilities
; 6. Win - Windows key combinations for common tasks
; 7. Context Sensitive - Application-specific shortcuts
; 8. Controller Controls - Gamepad/controller mappings
; 9. Macro System - Custom macro functionality

;===============================SPECIAL KEYS===================================::

!`:: {
    Reload
    ; Run, cmd.exe /c "taskkill /f /im autohotkey.exe"
}

; r::ToolTip ThisHotkey

Browser_Favorites:: {
    ; Speach := "dooooooont press this"
    ; Runwait A_WorkingDir '\voice.exe' ' -r' ' 2' ' -d' Speach,,'Hide'
    Send "^+{Esc}"
    ; MsgBox A_ThisHotKey
}

; ^Numpad1:: {
;     TransDegree := WinGetTransparent("A")
;     ; MsgBox TransDegree
;     if (TransDegree) {
;         WinSetTransparent "Off", "A"
;     }
;     else {
;         WinSetTransparent 200, "A"
;     }
; }

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
!i:: Send "{Up}"
!k:: Send "{Down}"
!l:: Send "{Right}"
!j:: Send "{Left}"

>^\::AltTab
RCtrl & RAlt::AppsKey
$CapsLock::Backspace
+CapsLock::CapsLock

;===================== Tap, Press & Hold Shortcuts ======================;

; ~LWin:: {
;     if (KeyWait(GetFilteredHotKey(), "T0.3")) {
;         ; Send "{Lwin}"
;     }
;     else if (KeyWait(GetFilteredHotKey(), "T1")) {
;         ; msgbox "Press"
;     }
;     else if (KeyWait(GetFilteredHotKey())) {
;         ; msgbox "Hold"
;     }
; }

;===================== Ctrl & Shift Shortcuts ======================;

#HotIf !WinActive("ahk_class Photoshop")
$^+d:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Visual Studio Code", "C:\Program Files\Microsoft VS Code\Code.exe", "^{Tab}")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files\Microsoft VS Code\Code.exe"
    }
}
#HotIf

$^+e:: {

    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("https://www.youtube.com/")
        ; Run "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run('"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/"')
        ; Run "C:\Users\Shamil\AppData\Local\Programs\cron-web\Notion Calendar.exe"
    }
}

$^+f:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run '*RunAs cmd.exe'
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
    }
}

$^+g:: {
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

$^+q:: {
    SendInput "^c"
    sleep 10
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "https://www.google.com/search?q=" A_Clipboard
    }
    else if (KeyWait(GetFilteredHotKey(), "T2")) {
        Run "https://www.youtube.com/results?search_query=" A_Clipboard
        ; Run(
        ; )
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "https://chat.openai.com"
    }
}

$^+a:: RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")

$^+x:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Brave", "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
    }
}

$^+y:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files\qBittorrent\qbittorrent.exe"
    }
}

#HotIf !WinActive("ahk_class Photoshop")
$^+z:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Microsoft​ Edge", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    }
}
#HotIf

$^+Up:: {
    global CurrentBrightness
    ChangeBrightness(CurrentBrightness += Brightness_Increments)
}

$^+Down:: {
    global CurrentBrightness
    ChangeBrightness(CurrentBrightness -= Brightness_Increments)
}

$^+/:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "C:\Windows\System32\SndVol.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "D:\Programs Files\Nahimic.lnk"
    }
}

^!Numpad1:: {
    RunWait 'cmd.exe /c python "D:\Programs\AHK\Random-Youtube-Video.py"', , "Hide"
}

^+WheelUp:: Run "C:\Windows\System32\SndVol.exe"
^+WheelDown:: Run "D:\Programs Files\Nahimic.lnk"
^+v:: Run A_WorkingDir "\Bluetooth Connect.ahk"
^+b:: Run A_WorkingDir "\Bluetooth Disconnect.ahk"

;=============================== Alt & Ctrl Shortcuts =================================;

^!:: {
    if !WinExist
        Run "C:\Users\Shamil\AppData\Roaming\AltSnap\AltSnap.exe"
}

^!b:: {
    if WinExist("Window Spy for AHKv2")
        WinActivate("Window Spy for AHKv2")
    else
        Run "C:\Program Files\AutoHotkey\WindowSpy.ahk"
}

^!s:: Send "^#v"

^!z:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "D:\Programs Files\Shortcuts\Lenovo Vantage.lnk"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Users\Shamil\AppData\Local\Playnite\Playnite.DesktopApp.exe"
    }
}

!+3:: Run "D:\Programs\Github\AHK-Depricated\Files Move3.ahk"

;================================= Ctrl & Win Shortcuts =======================================;

^#s:: Send "{F20}" ; To disable windows speech recognition hotkey

;================================= Alt Shortcuts =======================================;

;================================= Win Shortcuts =======================================;

#c:: Run "D:\Programs Files\Copilot.lnk"

#e:: {
    Run "C:\Program Files\WindowsApps\Files_3.8.0.0_x64__1y0xx7n9077q4\Files.App\Files.exe"
    ; if (KeyWait(GetFilteredHotKey(), "T0.3")) {
    ;     if !WinExist(" - Files") {
    ;         Run "C:\Program Files\WindowsApps\Files_3.8.0.0_x64__1y0xx7n9077q4\Files.App\Files.exe"
    ;         GroupAdd "ExplorerGroup", " - Files"
    ;     }
    ;     else if WinActive("ahk_exe explorer.exe")
    ;         GroupActivate "ExplorerGroup", "r"
    ;     else
    ;         WinActivate " - Files"
    ;     return
    ; }
    ; else {
    ;     KeyWait(GetFilteredHotKey())
    ;     Run "C:\Program Files\WindowsApps\Files_3.8.0.0_x64__1y0xx7n9077q4\Files.App\Files.exe"
    ; }
}
; {

;     if (KeyWait(GetFilteredHotKey(), "T0.3")) {
;         RunApplication(" - File Explorer", "explorer.exe")
;     }
;     else {
;         KeyWait(GetFilteredHotKey())
;         Run "explorer.exe"
;     }
; }

#s:: WinMinimize "A"

#w:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("WhatsApp", "D:\Programs Files\WhatsApp.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        RunApplication("Unigram", "D:\Programs Files\Unigram.lnk")
    }
}

#Space::^Space

;================================= Other Shortcuts =====================================;

; !w:: Send "!{F4}"
; $SC137:: Send "#{PrintScreen}" ; PrintScreen
; #+s:: Send "#+t"
^+m:: Run "C:\Windows\System32\mblctr.exe"

>^Up::Volume_Up
>^Down::Volume_Down
>^Left::Media_Play_Pause
>^Right::Media_Next

;========================== Context Sensitive Shortcuts =======================================;

#HotIf WinActive("ahk_class CabinetWClass") ;Clicks the Folder path in File explorer like clicking the url in browsers

^e:: Send "^l"

^d:: Send "{Del}"

#HotIf !WinActive("ahk_exe Overwatch.exe") or !WinActive("Marvel Rivals")
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

#HotIf !WinActive("ahk_exe vlc.exe")
!1:: MyMenu1.Show()
!2:: MyMenu2.Show()
!3:: MyMenu3.Show()
!4:: MYMenu4.Show()
!5:: MyMenu5.Show()
!+z:: MyMenu6.Show()

#HotIf WinActive("ahk_class Qt5QWindowIcon")
/:: Send "jjj"
0:: Send "{Ctrl Down}{WheelUp}{Ctrl Up}"
9:: Send "{Ctrl Down}{WheelDown}{Ctrl Up}"
BS::
\:: Send "^{Right}{Right}{Right}+{Right}+{Right}+{Right}"
>^Left:: Send "^{Left}"
>^Right:: Send "^{Right}"

#HotIf WinActive("ahk_exe Spotify.exe")
>^Up:: Send "^{Up}"
>^Down:: Send "^{Down}"

#HotIf WinActive("ahk_exe brave.exe")
!q:: {

    MouseGetPos &x, &y
    MouseClick "Left", 1755, 922, , 0
    MouseMove x, y, 0
}

#HotIf WinActive("ahk_exe Code.exe")
^!e:: Send "^+e"

; #HotIf MouseIsOver("TrayNotifyWnd1")
; WheelUp:: ToolTip "#+m"
; WheelDown:: ToolTip "#m"

#HotIf

;================================= Controller Controls =======================================;

; #HotIf GetKeyState("Joy11", "P")
; Joy2:: {
;     if GetKeyState("Joy11", "P") {
;         Send "{Media_Play_Pause}"
;         Current_Window := WinGetTitle("A")
;         WinActivate("-YouTube")
;         ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
;         ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
;         Send "k"
;         WinActivate(Current_Window)
;     }
; }

; Joy1:: {
;     if GetKeyState("Joy11", "P") {
;         Send "{Media_Play_Pause}"
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
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        global Macro
        Macro := !Macro
        ToolTip Macro
        SetTimer RemoveToolTip, -200
    }
    else {
        KeyWait(GetFilteredHotKey())
        Send "{ASC 96}"
    }
}

; KeyWait, %A_ThisHotKey%, T0.3
; if !ErrorLevel
; {
; 	Run, "D:\AHK\Get_KeyCodes.ahk"
; 	Tooltip, `
; 	Settimer, RemoveToolTip, -500
; }
; else
; {
;     KeyWait, %A_ThisHotKey%, T0.5
;     Send, {ASC 96}
; }
;

; #Include "%A_WorkingDir%\Second_Keyboard_Shortcuts_V2.ahk"

;================================= Macro System =======================================;
; Enables macro functionality when ScrollLock is on or Macro variable is true
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