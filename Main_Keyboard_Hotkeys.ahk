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
SetNumLockState "AlwaysOn"
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
#Include <Lib>
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
MySubMenu1 := Menu()
MyMenu2 := Menu()
MyMenu3 := Menu()
MyMenu4 := Menu()
MyMenu5 := Menu()
MySubMenu5 := Menu()
MyMenu6 := Menu()

; =============================================================================
; MENU 1: DEVELOPMENT TOOLS
; =============================================================================
; Add VS Code workspace submenu items
MySubMenu1.Add("AHK", SubMenuHandler1)
MySubMenu1.Add("SE", SubMenuHandler1)
MySubMenu1.Add("Java", SubMenuHandler1)
MySubMenu1.Add("DS", SubMenuHandler1)
MySubMenu1.Add("OS", SubMenuHandler1)

MyMenu1.Add("AHK", MenuHandler1)
MyMenu1.Add("ADB", MenuHandler1)
MyMenu1.Add("Code", MenuHandler1)
MyMenu1.Add("VS Code", MySubMenu1)

; Menu handler for development tools
MenuHandler1(Item, *) {
    if (Item == "AHK") {
        Run "D:\Programs\AHK"
    } else if (Item == "ADB") {
        Run "D:\Programs\ADB"
    } else if (Item == "Code") {
        Run "D:\Programs"
    }
}

; Submenu handler for VS Code workspaces
SubMenuHandler1(Item, *) {
    if (Item == "AHK") {
        Run "D:\Programs\AHK.code-workspace"
    } else if (Item == "SE") {
        Run "D:\Programs\TSMS.code-workspace"
    } else if (Item == "Java") {
        Run "D:\Programs\Java.code-workspace"
    } else if (Item == "DS") {
        Run "D:\Programs\Data Structure.code-workspace"
    } else if (Item == "OS") {
        Run "D:\Programs\Operating System.code-workspace"
    }
}

; =============================================================================
; MENU 2: FILE LOCATIONS
; =============================================================================
MyMenu2.Add("Android", MenuHandler2)                 ; Android apps backup
MyMenu2.Add("Setups", MenuHandler2)                  ; Software installations
MyMenu2.Add("Downlaods", MenuHandler2)               ; Downloads folder
MyMenu2.Add("Documents", MenuHandler2)               ; Documents folder
MyMenu2.Add("Pictures", MenuHandler2)                ; Pictures folder
MyMenu2.Add("ROM", MenuHandler2)                     ; Android ROMs

; Menu handler for file locations
MenuHandler2(Item, *) {
    if (Item == "Downloads") {
        Run "A:\Downloads"                           ; Open Downloads drive
    } else if (Item == "Documents") {
        Run "A:\Documents"                           ; Open Documents drive
    } else if (Item == "Pictures") {
        Run "A:\Pictures"                            ; Open Pictures drive
    } else if (Item == "Setups") {
        Run "E:\Setups"                              ; Open Setups drive
    } else if (Item == "Android") {
        Run "E:\Backup\Apps"                         ; Open Android apps backup
    } else if (Item == "ROM") {
        Run "E:\OS\Android\!POCO F6"                 ; Open Android ROMs folder
    }
}

; =============================================================================
; MENU 3: MEDIA LOCATIONS
; =============================================================================
MyMenu3.Add("Anime", MenuHandler3)                   ; Anime folder
MyMenu3.Add("Movies", MenuHandler3)                  ; Movies folder
MyMenu3.Add("Shows", MenuHandler3)                   ; TV Shows folder
MyMenu3.Add("Games", MenuHandler3)                   ; Games folder

; Menu handler for media locations
MenuHandler3(Item, *) {
    if (Item = "Movies") {
        Run "E:\Movies"                              ; Open Movies folder
    }
    else if (Item = "Anime") {
        Run "E:\Anime"                               ; Open Anime folder
    } else if (Item = "Shows") {
        Run "E:\Shows"                               ; Open TV Shows folder
    } else {
        ToolTip Item                                 ; Show tooltip for unknown items
        SetTimer RemoveTooltip, -500                 ; Remove tooltip after 500ms
    }
}

; =============================================================================
; MENU 4: DRIVE ACCESS
; =============================================================================
MyMenu4.Add("C", MenuHandler4)
MyMenu4.Add("D", MenuHandler4)
MyMenu4.Add("E", MenuHandler4)
MyMenu4.Add("S", MenuHandler4)

; Menu handler for drive access
MenuHandler4(Item, *) {
    Run(Item ":\")
}

; Submenu handler for drive operations
SubMenuHandler4(Item, *) {
    ToolTip Item                                     ; Show tooltip
    SetTimer RemoveTooltip, -500                     ; Remove tooltip after 500ms
}

; =============================================================================
; MENU 5: ANDROID/ADB TOOLS
; =============================================================================
MyMenu5.Add("USB", MenuHandler5)                     ; USB connection mode
MyMenu5.Add("Enable TCPIP", MenuHandler5)            ; Enable TCP/IP mode
MyMenu5.Add("TCPIP", MenuHandler5)                   ; TCP/IP connection mode
MyMenu5.Add("OTG", MenuHandler5)                     ; OTG connection mode

; Menu handler for Android/ADB tools
MenuHandler5(Item, *) {
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
; MENU 6: POWER MANAGEMENT
; =============================================================================
MyMenu6.Add("Power Saver", MenuHandler6)             ; Power saver mode
MyMenu6.Add("Balanced", MenuHandler6)                ; Balanced power mode
MyMenu6.Add("Performance", MenuHandler6)             ; High performance mode

; Menu handler for power management
MenuHandler6(Item, *) {
    if (Item = "Power Saver") {
        Run 'powercfg -s a1841308-3541-4fab-bc81-f71556f20b4a'  ; Set power saver
    } else if (Item = "Balanced") {
        Run 'powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e'  ; Set balanced
    } else if (Item = "Performance") {
        Run 'powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' ; Set performance
    }
}

; Submenu handler for power management
SubMenuHandler6(Item, *) {
    ToolTip Item                                     ; Show tooltip
    SetTimer RemoveToolTip, -500                     ; Remove tooltip after 500ms
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
>^\::AltTab
RCtrl & RAlt::AppsKey

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

$^+a:: RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")

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
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        if (WinExist("— Mozilla Firefox")) {
            WinActivate("— Mozilla Firefox")
            i := 1
            while (!WinActive("YouTube ") && i < 20) {
                Send "^{Tab}"
                i++
                Sleep 100
            }
            if (i >= 20) {
                Run("https://www.youtube.com/", , "max")
            }
        }
        else {
            Run("https://www.youtube.com/", , "max")

        }
    }
    else {
        KeyWait(GetFilteredHotKey())
        if (WinExist(" - Brave")) {
            WinActivate(" - Brave")
            i := 1
            while (!WinActive("YouTube ") && i < 20) {
                Send "^{Tab}"
                i++
                Sleep 100
            }
            if (i >= 20) {
                Run(
                    '"D:\Programs Files\Brave.lnk" "https://www.youtube.com/"', ,
                    "max")
            }
        }
        else {
            Run(
                '"D:\Programs Files\Brave.lnk" "https://www.youtube.com/"', ,
                "max")

        }

    }
}

$^+w:: {
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

#HotIf !WinActive("ahk_class Photoshop") and !WinActive("ahk_class Premiere Pro")
$^+d:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Visual Studio Code", "D:\Programs Files\Visual Studio Code.lnk",
            "^{Tab}")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "D:\Programs Files\Visual Studio Code.lnk"
    }
}
#HotIf

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

^#s:: Send "{F20}"

; =============================================================================
; SECTION 7: WIN SHORTCUTS
; =============================================================================
; Windows key combinations for common tasks

#c:: Run "D:\Programs Files\Copilot.lnk"

#q:: {
    Send("!{F4}")
}

#Enter:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("ahk_exe WindowsTerminal.exe", "D:\Programs Files\Terminal.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Programs Files\Terminal.lnk")
    }
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

#s:: Send "#1"
#d:: Send "#2"
#f:: Send "#3"

#w:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("WhatsApp", "D:\Programs Files\WhatsApp.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        RunApplication("Unigram", "D:\Programs Files\Unigram.lnk")
    }
}

$#z:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Mozilla Firefox", "D:\Programs Files\Firefox.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "D:\Programs Files\Firefox.lnk"
    }
}

$#x:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication("Brave", "D:\Programs Files\Brave.lnk")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Programs Files\Brave.lnk", , "max")
    }
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
>^Left UP:: {
    currentwindow := WinGetTitle("A")
    Send "{Ctrl up}"
    ; WinActivate("ahk_exe firefox.exe")
    ; ControlSend "k", , "A"
    ControlSend "k", , "ahk_exe firefox.exe"
    WinActivate(currentwindow)
}
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
!+4:: MYMenu4.Show()
!+5:: MyMenu5.Show()
!+z:: MyMenu6.Show()

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

#HotIf WinActive("ahk_class Qt5QWindowIcon")
/:: Send "jjjjj"
0:: Send "{Ctrl Down}{WheelUp}{Ctrl Up}"
9:: Send "{Ctrl Down}{WheelDown}{Ctrl Up}"
BS::
\:: Send "^{Right}{Right}{Right}+{Right}+{Right}+{Right}"

Left:: Send "+{Left}"
Right:: Send "+{Right}"

+Left:: Send "{Left}"
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