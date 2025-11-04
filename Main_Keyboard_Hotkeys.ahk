#Requires AutoHotkey v2.0
#SingleInstance Force

; =============================================================================
; MAIN KEYBOARD HOTKEYS SCRIPT
; =============================================================================
; This script provides comprehensive keyboard shortcuts and automation for Windows
; Features include: system controls, application launchers, context-sensitive
; shortcuts, and custom macro functionality
; =============================================================================

; =============================================================================
; BASIC SETTINGS AND CONFIGURATION
; =============================================================================
TraySetIcon A_WorkingDir "`\Lib\AutoHotKeyV2.png"
Persistent
SetTitleMatchMode 2
SendMode "Input"
SetCapsLockState "Off"
SetNumLockState "Off"
SetScrollLockState "Off"

; Disable spell check in VSCode for this file
; // cspell:disable

; =============================================================================
; GLOBAL VARIABLES
; =============================================================================
global currentMode := 1
global keyboardIntercepted := ""

; =============================================================================
; LIBRARY INCLUDES
; =============================================================================
#Include Lib\Lib.ahk
#Include "Lib\Credentials.ahk"

; =============================================================================
; AUTOSTART SCRIPTS
; =============================================================================
; Launch MacroPad script automatically
Run "D:\Programs\AHK\MacroPad\Macro-Pad.ahk"

; Uncomment to run Minimize_To_Tray script with admin privileges
; Run "*RunAs " A_WorkingDir "\Minimize_To_Tray.ahk"

; =============================================================================
; CONTEXT MENU SYSTEM
; =============================================================================
; Create main menu structure for quick access to various programs and locations

; Main menu for development tools
MyMenu1 := Menu()
MyMenu2 := Menu()
MySubMenu2 := Menu()
MyMenu3 := Menu()
MyMenu4 := Menu()
MyMenu5 := Menu()
MyMenu6 := Menu()
MyMenu7 := Menu()

; =============================================================================
; MENU 1: Code workspace
; =============================================================================
; Add VS Code workspace menu items
MyMenu1.Add("AHK", MenuHandler1)
MyMenu1.Add("ADB", MenuHandler1)
MyMenu1.Add("C++", MenuHandler1)
MyMenu1.Add("Python", MenuHandler1)
MyMenu1.Add("Manim", MenuHandler1)
MyMenu1.Add("ML", MenuHandler1)
MyMenu1.Add("NW", MenuHandler1)

; Menu handler for workspaces
MenuHandler1(Item, *) {
    if (Item == "AHK") {
        Run("D:\Programs\AHK.code-workspace")
    } else if (Item == "ADB") {
        Run("D:\Programs\ADB.code-workspace")
    } else if (Item == "C++") {
        Run("D:\Programs\C++.code-workspace")
    } else if (Item == "Python") {
        Run("D:\Programs\Python.code-workspace")
    } else if (Item == "Manim") {
        Run("D:\Programs\Manim.code-workspace")
    } else if (Item == "ML") {
        Run("D:\Programs\ML.code-workspace")
    } else if (Item == "NW") {
        Run("D:\Programs\NW.code-workspace")
    }
}

; =============================================================================
; MENU 2: Frequently Used Folders
; =============================================================================
MySubMenu2.Add("Android", SubMenuHandler2)

MyMenu2.Add("AHK", MenuHandler2)
MyMenu2.Add("ADB", MenuHandler2)
MyMenu2.Add("C++", MenuHandler2)
MyMenu2.Add("Python", MenuHandler2)
MyMenu2.Add("Setups", MenuHandler2)
MyMenu2.Add("OS", MySubMenu2)

; Menu handler for file locations
MenuHandler2(Item, *) {
    if (Item == "AHK") {
        Run("D:\Programs\AHK")
    } else if (Item == "ADB") {
        Run("D:\Programs\ADB")
    } else if (Item == "C++") {
        Run("D:\Programs\C++")
    } else if (Item == "Python") {
        Run("D:\Programs\Python-Scripts")
    } else if (Item == "Setups") {
        Run("E:\Setups")
    } else if (Item == "OS") {
        Run("E:\OS")
    }
}

SubMenuHandler2(Item, *) {
    if (Item == "Android") {
        Run("E:\OS\Android")
    } else if (Item == "Linux") {
        Run("E:\OS\Linux")
    } else if (Item == "Windows") {
        Run("E:\OS\Windows")
    }
}

; =============================================================================
; MENU 3: User Folders
; =============================================================================
MyMenu3.Add("Documents", MenuHandler3)
MyMenu3.Add("Downlaods", MenuHandler3)
MyMenu3.Add("Pictures", MenuHandler3)
MyMenu3.Add("Videos", MenuHandler3)

; Menu handler for file locations
MenuHandler3(Item, *) {
    if (Item == "Documents") {
        Run("A:\Documents")
    } else if (Item == "Downloads") {
        Run("A:\Downloads")
    } else if (Item == "Pictures") {
        Run("A:\Pictures")
    } else if (Item == "Videos") {
        Run("A:\Videos")
    }
}

; =============================================================================
; MENU 4: MEDIA LOCATIONS
; =============================================================================
MyMenu4.Add("Anime", MenuHandler4)
MyMenu4.Add("Hollywood", MenuHandler4)
MyMenu4.Add("Other Movies", MenuHandler4)
MyMenu4.Add("Shows", MenuHandler4)
MyMenu4.Add("Games", MenuHandler4)

; Menu handler for media locations
MenuHandler4(Item, *) {
    if (Item = "Anime") {
        Run "E:\Shows\Anime"
    } else if (Item = "Hollywood") {
        Run "E:\Movies\Hollywood"
    } else if (Item = "Other Movies") {
        Run "E:\Movies\Others"
    } else if (Item = "Shows") {
        Run "E:\Shows\Web Series"
    } else if (Item = "Games") {
        Run "D:\Games"
    }
}

; =============================================================================
; MENU 5: DRIVE ACCESS
; =============================================================================
MyMenu5.Add("A: Vault", MenuHandler5)
MyMenu5.Add("C: Windows", MenuHandler5)
MyMenu5.Add("D: Programs", MenuHandler5)
MyMenu5.Add("E: Media", MenuHandler5)
MyMenu5.Add("F: GDrive", MenuHandler5)
MyMenu5.Add("G: Linux", MenuHandler5)

; Menu handler for drive access
MenuHandler5(Item, *) {
    Run(Item ":\")
}

; =============================================================================
; MENU 6: ANDROID/ADB TOOLS
; =============================================================================
MyMenu6.Add("USB", MenuHandler6)                     ; USB connection mode
MyMenu6.Add("Enable TCPIP", MenuHandler6)            ; Enable TCP/IP mode
MyMenu6.Add("TCPIP", MenuHandler6)                   ; TCP/IP connection mode
MyMenu6.Add("OTG", MenuHandler6)                     ; OTG connection mode

; Menu handler for Android/ADB tools
MenuHandler6(Item, *) {
    if (Item = "USB") {
        Run "D:\Programs\ADB\scrcpy-USB.vbs"        ; Launch USB scrcpy
    }
    else if (Item = "Enable TCPIP") {
        Run "D:\Programs\ADB\scrcpy-enable-TCPIP.vbs" ; Enable TCP/IP mode
    }
    else if (Item = "TCPIP") {
        Run "D:\Programs\ADB\scrcpy-TCPIP.vbs"      ; Launch TCP/IP scrcpy
    }
    else if (Item = "OTG") {
        Run "D:\Programs\ADB\scrcpy-OTG.vbs"        ; Launch OTG scrcpy
    }
    else {
        ToolTip Item                                 ; Show tooltip for unknown items
        SetTimer RemoveToolTip, -500                 ; Remove tooltip after 500ms
    }
}

; =============================================================================
; MENU 7: POWER MANAGEMENT
; =============================================================================
MyMenu7.Add("Power Saver", MenuHandler7)             ; Power saver mode
MyMenu7.Add("Balanced", MenuHandler7)                ; Balanced power mode
MyMenu7.Add("Performance", MenuHandler7)             ; High performance mode

; Menu handler for power management
MenuHandler7(Item, *) {
    if (Item = "Power Saver") {
        Run 'powercfg -s a1841308-3541-4fab-bc81-f71556f20b4a'  ; Set power saver
    } else if (Item = "Balanced") {
        Run 'powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e'  ; Set balanced
    } else if (Item = "Performance") {
        Run 'powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' ; Set performance
    }
}

; =============================================================================
; HOTKEY SECTIONS OVERVIEW
; =============================================================================
; 1. Special Keys - System and media control hotkeys
; 2. Basic Navigation - Arrow key alternatives (Alt + IJKL)
; 3. Tap, Press & Hold - Shortcuts with different behaviors based on press duration
; 4. Ctrl & Shift - Application launchers and system functions
; 5. Alt & Ctrl - Window management and system utilities
; 6. Win - Windows key combinations for common tasks
; 7. Context Sensitive - Application-specific shortcuts
; 8. Controller Controls - Gamepad/controller mappings
; 9. Macro System - Custom macro functionality

; =============================================================================
; SECTION 1: SPECIAL KEYS
; =============================================================================
; System and media control hotkeys

!^Tab:: {
    reload
    ; Alternative: Kill all AutoHotkey processes
    ; Run, cmd.exe /c "taskkill /f /im autohotkey.exe"
}

Browser_Favorites:: {
    ; Uncomment for voice feedback
    ; Speach := "dooooooont press this"
    ; Runwait A_WorkingDir '\voice.exe' ' -r' ' 2' ' -d' Speach,,'Hide'
    Send "^+{Esc}"
    ; MsgBox A_ThisHotKey
}

^Numpad1:: {
    TransDegree := WinGetTransparent("A")
    ; MsgBox TransDegree
    if (TransDegree) {
        WinSetTransparent "Off", "A"
    }
    else {
        WinSetTransparent 200, "A"
    }
}

; Disable various media keys
Launch_Mail:: return
Media_Stop:: return
~Volume_Up:: return
~Volume_Down:: return

Launch_App1:: Msgbox "Hi"

; =============================================================================
; SECTION 2: BASIC NAVIGATION
; =============================================================================
; Arrow key alternatives using Alt + IJKL

!i:: Send "{Up}"
!k:: Send "{Down}"
!l:: Send "{Right}"
!j:: Send "{Left}"

; Right Ctrl combinations
; >^\::AltTab
; RCtrl & RAlt::AppsKey

; Caps Lock modifications
$CapsLock::Backspace
+CapsLock::CapsLock

; =============================================================================
; SECTION 3: TAP, PRESS & HOLD SHORTCUTS
; =============================================================================
; Shortcuts with different behaviors based on press duration

; Windows key with different behaviors (commented out)
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

; =============================================================================
; SECTION 4: CTRL & SHIFT SHORTCUTS
; =============================================================================
; Application launchers and system functions

$^+f:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.21.3231.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run '*RunAs cmd.exe'
    }
}

$^+g:: {
    p := Morse()
    if (p = "00") {
        ; Enable virtual display
        Run '*RunAs cmd.exe /k pnputil /enum-devices /class Display', , "Hide"
        Run '*RunAs cmd.exe /c pnputil "/enable-device" "ROOT\UNKNOWN\0000"', , "Hide"
        ToolTip "Virtual Display Enabled"
        SetTimer RemoveToolTip, -500
    }
    else if (p = "01") {
        ; Disable virtual display
        Run '*RunAs cmd.exe /k pnputil "/disable-device" "ROOT\UNKNOWN\0000"', , "Hide"
        ToolTip "Virtual Display Disabled"
        SetTimer RemoveToolTip, -500
    }
    else if (p = "0") {
        ; Show IP address
        ipadd := ComObject("WScript.Shell").Exec(A_ComSpec " /c " 'ipconfig | find "IPv4"').StdOut.ReadAll()
        i := 0
        ToolTip ipadd
        SetTimer RemoveToolTip, -3000
    }
    else if (p = "1") {
        ; Show display ID from dxgi-info
        ipadd := ComObject("WScript.Shell").Exec(A_ComSpec " /C " '"C:\Program Files\Sunshine\tools\dxgi-info.exe"'
        ).StdOut
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

$^+w:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        if (WinExist("— Vivaldi")) {
            WinActivate("— Vivaldi")
            WinWaitActive("— Vivaldi")
            tab := WinGetTitle("A")
            while (!WinActive("YouTube ")) {
                Send "^{Tab}"
                Sleep 100
                if (tab == WinGetTitle("A")) {
                    break
                }
            }
            if (!WinActive("YouTube ")) {
                Run("https://www.youtube.com/", , "max")
            }
        }
        else {
            Run("https://www.youtube.com/", , "max")
        }
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("https://www.youtube.com/", , "max")
    }
}

; $^+e:: {
;     if (KeyWait(GetFilteredHotKey(), "T0.3")) {
;         if (WinExist("Brave")) {

;             WinActivate("Brave")
;             WinWaitActive("Brave")
;             tab := WinGetTitle("A")
;             while (!WinActive("YouTube ")) {
;                 Send "^{Tab}"
;                 Sleep 100
;                 if (tab == WinGetTitle("A")) {
;                     break
;                 }
;             }
;             if (!WinActive("YouTube ")) {
;                 Run('"D:\Programs Files\Brave.lnk" "https://www.youtube.com/"', , "max")
;             }
;         }
;         else {
;             Run('"D:\Programs Files\Brave.lnk" "https://www.youtube.com/"', , "max")
;         }
;     }
;     else {
;         KeyWait(GetFilteredHotKey())
;         Run('"D:\Programs Files\Brave.lnk" "https://www.youtube.com/"', , "max")
;     }
; }

$^+q:: {
    SendInput "^c"
    sleep 10
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "https://www.google.com/search?q=" A_Clipboard
    }
    else if (KeyWait(GetFilteredHotKey(), "T2")) {
        Run "https://www.youtube.com/results?search_query=" A_Clipboard
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "https://chat.openai.com"
    }
}

$^+x:: Send "#x"

$^+y:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files\qBittorrent\qbittorrent.exe"
    }
}

^+m:: Run "C:\Windows\System32\mblctr.exe"

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

^+WheelUp:: Run "C:\Windows\System32\SndVol.exe"
^+WheelDown:: Run "D:\Programs Files\Nahimic.lnk"

; =============================================================================
; SECTION 5: ALT & CTRL SHORTCUTS
; =============================================================================
; Window management and system utilities

^!b:: {
    if WinExist("Window Spy for AHKv2")
        WinActivate("Window Spy for AHKv2")
    else
        Run "C:\Program Files\AutoHotkey\WindowSpy.ahk"
}

^!v:: Run "C:\Program Files\AutoHotkey\v2\AutoHotkey.chm"

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

^!3:: Run "D:\Programs\AHK\Random_File_Opener.ahk"
^!4:: Run "D:\Programs\AHK\Random_File_Copier.ahk"

^+!v:: Send "{ASC 35}Notenoughcookies21"

; =============================================================================
; SECTION 6: CTRL & WIN SHORTCUTS
; =============================================================================
; Windows key combinations

; =============================================================================
; SECTION 7: WIN SHORTCUTS
; =============================================================================
; Windows key combinations for common tasks

$#d:: {
    ; if (KeyWait(GetFilteredHotKey(), "T0.3")) {
    RunApplication("Visual Studio Code", "D:\Programs Files\Visual Studio Code.lnk", "^{Tab}")
    ; }
    ; else {
    ;     KeyWait(GetFilteredHotKey())
    ;     Run "D:\Programs Files\Visual Studio Code.lnk"
    ; }
}

#e:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication(" - File Explorer", "explorer.exe")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "explorer.exe"
    }
}

#g:: RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")

#q:: {
    Send("!{F4}")
}

#Enter:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        if WinExist("Administrator: Command Prompt") || WinExist("Administrator: Windows PowerShell") {
            WinActivate()
            Send("{Escape}")
            return
        }
        ; RunApplication("ahk_exe WindowsTerminal.exe", "D:\Programs Files\Terminal.lnk")
        Run '*RunAs cmd.exe'
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Programs Files\Terminal.lnk")
    }
}

#w:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("WhatsApp", "D:\Programs Files\WhatsApp.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        RunApplication("Unigram", "D:\Programs Files\Unigram.lnk")
    }
}

#s:: {
    ; if (KeyWait(GetFilteredHotKey(), "T0.3")) {
    RunApplication("Opera", "D:\Programs Files\Opera GX.lnk")
    ; WinActivate("ahk_exe opera.exe")
    ; wintitle := WinGetTitle("A")
    ; MsgBox(wintitle)
    ; }
    ; else {
    ;     KeyWait(GetFilteredHotKey())
    ;     Run "D:\Programs Files\Vivaldi.lnk"
    ; }
}

#f:: {
    ; if (KeyWait(GetFilteredHotKey(), "T0.3")) {
    RunApplication("Brave", "D:\Programs Files\Brave")
    ; }
    ; else {
    ;     KeyWait(GetFilteredHotKey())
    ;     Run("D:\Programs Files\Brave.lnk", , "max")
    ; }
}

; =============================================================================
; SECTION 8: OTHER SHORTCUTS
; =============================================================================
; Miscellaneous system shortcuts

^+!d:: {
    timer := 0
    Run 'cmd /c Shutdown /s /t ' timer, , "Hide"
}

^+!f:: {
    timer := 0
    Run 'cmd /c Shutdown /r /t ' timer, , "Hide"
}

RunExplorer() {
    Run("explorer.exe")
}

^+!e:: {
    Run('cmd.exe /c taskkill /f /im explorer.exe', , "Hide")
    SetTimer RunExplorer, -2000
}

>^Up::Volume_Up
>^Down::Volume_Down
>^Left::Media_Play_Pause
; <^Space::Media_Play_Pause
; {
;     currentwindow := WinGetTitle("A")
;     Send "{Ctrl up}"
;     ; WinActivate("ahk_exe firefox.exe")
;     ; ControlSend "k", , "A"
;     ControlSend "k", , "ahk_exe firefox.exe"
;     WinActivate(currentwindow)
; }
>^Right::Media_Next

; =============================================================================
; SECTION 9: CONTEXT SENSITIVE SHORTCUTS
; =============================================================================
; Application-specific shortcuts

; File Explorer specific shortcuts
#HotIf WinActive("ahk_class CabinetWClass")          ; Only in File Explorer
^e:: Send "^l"                                       ; Ctrl+E = Focus address bar
^d:: Send "{Del}"                                    ; Ctrl+D = Delete
#HotIf

; Global copy/paste feedback
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

!+1:: MyMenu1.Show()
!+2:: MyMenu2.Show()
!+3:: MyMenu3.Show()
!+4:: MyMenu4.Show()
!+5:: MyMenu5.Show()
!+6:: MyMenu6.Show()
!+z:: MyMenu7.Show()

!1::
!2::
!3::
!4::
!5::
!6::
!7::
!8::
!9::
!0::
!-::
!=:: Send("{F" GetFilteredHotKey() "}")

RAlt::Space
NumpadClear::Down
NumpadHome:: Send("\")
^[:: Send("\")
^]:: Send("|")

<!RShift::Enter
<^RShift::Space

#HotIf WinActive("Satisfactory")
XButton2::Space
#HotIf

#HotIf WinActive("ahk_class Qt5QWindowIcon")
z:: Send "+{Left}"
x:: Send "+{Right}"
/:: Send "jjjjjv"
0:: Send "{Ctrl Down}{WheelUp}{Ctrl Up}"
9:: Send "{Ctrl Down}{WheelDown}{Ctrl Up}"
+/::
NumpadDot::
BS::
\:: Send "^{Right}{Right}{Right}+{Right}+{Right}+{Right}"
Insert::
NumpadIns:: {
    Send "{Space}"
}

NumpadLeft::
Left:: Send "+{Left}"
NumpadRight::
Right:: Send "+{Right}"

+NumpadLeft::
+Left:: Send "{Left}"
+NumpadRight::
+Right:: Send "{Right}"

>^Left:: Send "^{Left}"
>^Right:: Send "^{Right}"
#HotIf

#HotIf WinActive("ahk_class mpv")
Up:: Send "0"
Down:: Send "9"
^Right:: Send "{Up}"
^Left:: Send "{Down}"
^!Right:: Send "{Up 5}"
^!Left:: Send "{Down 5}"
#HotIf

#HotIf WinActive("ahk_exe Spotify.exe")
>^Up:: Send "^{Up}"
>^Down:: Send "^{Down}"
#HotIf

#HotIf WinActive("ahk_exe brave.exe")
!q:: {
    MouseGetPos &x, &y
    MouseClick "Left", 1755, 922, , 0
    MouseMove x, y, 0
}
#HotIf

#HotIf WinActive("ahk_exe Code.exe")
^!e:: Send "^+e"
#HotIf

; =============================================================================
; SECTION 10: CONTROLLER CONTROLS
; =============================================================================
; Gamepad/controller mappings (commented out)

; #HotIf GetKeyState("Joy11", "P")
; Joy2:: {
;     if GetKeyState("Joy11", "P") {
;         Send "{Media_Play_Pause}"
;         Current_Window := WinGetTitle("A")
;         WinActivate("-YouTube")
;         Send "k"
;         WinActivate(Current_Window)
;     }
; }
;
; Joy1:: {
;     if GetKeyState("Joy11", "P") {
;         Send "{Media_Play_Pause}"
;     }
; }
#HotIf

; =============================================================================
; SECTION 11: SECRET CODES
; =============================================================================

#HotIf