#Requires AutoHotkey v2.0  ; Specifies that this script requires AHK version 2.0
#SingleInstance force      ; Ensures only one instance of this script runs at a time
SendMode "Input"          ; Makes Send synonymous with SendInput (faster and more reliable)
Persistent               ; Keeps script running even after auto-execute section completes
#Include <Lib>           ; Include standard library

TraySetIcon A_WorkingDir "`\Lib\Numpad.png"  ; Sets custom tray icon

; Global variable to track current mode (1-4)
global currentMode := 1
global MyGui := ""

; #SuspendExempt
; NumpadDot:: {
;     Suspend
; }
; #SuspendExempt False

; Mode switching hotkey (NumpadDiv)
NumpadDiv:: {
    global currentMode
    currentMode := Mod(currentMode, 4) + 1
    ShowNumpadGUI()
}

; Mode 1: Basic numbers
#HotIf currentMode = 1
Numpad1:: {
    RunApplication("Microsoft​ Edge", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
}

Numpad2:: {
    RunApplication("Brave", "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Brave.lnk")
}

Numpad3:: {
    RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")
}

Numpad4:: {
    Run "D:\Programs\AHK.code-workspace"
}

Numpad5:: {
    Run "D:\Programs\Python-Scripts.code-workspace"
}

Numpad6:: {
    Tooltip ""
    ; Runwait A_WorkingDir '\voice.exe' ' -f -r 3 -k D:\Downloads\Response.txt'
    ; loop read "D:\hello.txt"{
    ;     Runwait A_WorkingDir '\voice.exe' ' -f -r' ' 3' ' -d' A_LoopReadLine,,'Hide'
    ; }
}

Numpad7:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Audio-Downloader.py ' A_Clipboard
}

Numpad8:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Downloader.py ' A_Clipboard

}

Numpad9:: ToolTip A_ThisHotkey

Numpad0:: {
    RunWait 'cmd.exe /c python "D:\Programs\Python-Scripts\Random-Youtube-Video-from-Playlist.py" "https://www.youtube.com/playlist?list=PLb-MR2Hfk3tlmemTNdCG_K4QiTehgJAr9"', ,
        "Min"
}

NumpadAdd:: ToolTip A_ThisHotkey

NumpadMult:: {
    restart_timer := 0
    Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
}

NumpadSub:: {
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadEnter::Media_Play_Pause

; Mode 2: Normal
#HotIf currentMode = 2
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
NumpadMult::
NumpadSub:: Send "{" A_ThisHotkey "}"

NumpadEnter::Media_Play_Pause

; Mode 3: Actions
#HotIf currentMode = 3
Numpad1:: {
    ToolTip("Mode 3: Action 1")
    SetTimer(RemoveToolTip, -1000)
}

Numpad2:: {
    ToolTip("Mode 3: Action 2")
    SetTimer(RemoveToolTip, -1000)
}

Numpad3:: {
    ToolTip("Mode 3: Action 3")
    SetTimer(RemoveToolTip, -1000)
}

Numpad4:: {
    ToolTip("Mode 3: Action 4")
    SetTimer(RemoveToolTip, -1000)
}

Numpad5:: {
    ToolTip("Mode 3: Action 5")
    SetTimer(RemoveToolTip, -1000)
}

Numpad6:: {
    ToolTip("Mode 3: Action 6")
    SetTimer(RemoveToolTip, -1000)
}

Numpad7:: {
    ToolTip("Mode 3: Action 7")
    SetTimer(RemoveToolTip, -1000)
}

Numpad8:: {
    ToolTip("Mode 3: Action 8")
    SetTimer(RemoveToolTip, -1000)
}

Numpad9:: {
    ToolTip("Mode 3: Action 9")
    SetTimer(RemoveToolTip, -1000)
}

Numpad0:: {
    ToolTip("Mode 3: Action 0")
    SetTimer(RemoveToolTip, -1000)
}

NumpadAdd:: ToolTip A_ThisHotkey

NumpadMult:: {
    restart_timer := 0
    Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
}
NumpadSub:: {
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadEnter::Media_Play_Pause

; Mode 4: Special
#HotIf currentMode = 4
Numpad1:: {
    ToolTip("Mode 4: Special 1")
    SetTimer(RemoveToolTip, -1000)
}

Numpad2:: {
    ToolTip("Mode 4: Special 2")
    SetTimer(RemoveToolTip, -1000)
}

Numpad3:: {
    ToolTip("Mode 4: Special 3")
    SetTimer(RemoveToolTip, -1000)
}

Numpad4:: {
    ToolTip("Mode 4: Special 4")
    SetTimer(RemoveToolTip, -1000)
}

Numpad5:: {
    ToolTip("Mode 4: Special 5")
    SetTimer(RemoveToolTip, -1000)
}

Numpad6:: {
    ToolTip("Mode 4: Special 6")
    SetTimer(RemoveToolTip, -1000)
}

Numpad7:: {
    ToolTip("Mode 4: Special 7")
    SetTimer(RemoveToolTip, -1000)
}

Numpad8:: {
    ToolTip("Mode 4: Special 8")
    SetTimer(RemoveToolTip, -1000)
}

Numpad9:: {
    ToolTip("Mode 4: Special 9")
    SetTimer(RemoveToolTip, -1000)
}

Numpad0:: {
    ToolTip("Mode 4: Special 0")
    SetTimer(RemoveToolTip, -1000)
}

NumpadAdd:: ToolTip A_ThisHotkey

NumpadMult:: {
    restart_timer := 0
    Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
}
NumpadSub:: {
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadEnter::Media_Play_Pause

#HotIf
; Show initial mode on script start
ToolTip("Mode 1 - Default Macros")
SetTimer(RemoveToolTip, -1000)