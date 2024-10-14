#Include "%A_WorkingDir%\V2_Lib.ahk"
#Requires AutoHotkey v2.0
SetWorkingDir A_WorkingDir  ; Ensures a consistent starting directory.
TraySetIcon A_WorkingDir "`\keyboard.png"
; #NoTrayIcon

;;================= START OF SECOND KEYBOARD ======================;;

#HotIf GetKeyState("F23")
; F23:: {
;     ToolTip "2nd key"
;     SetTimer RemoveToolTip, -2000
; }


;;========================== Fuction Keys ================================;;

Esc:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
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
F12:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Number Row ================================;;

`::
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
BS:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}


;;========================== Alphabet Row 1 ================================;;

Tab:: GetHotKey()
q:: SendInput "#m"
w:: GetHotKey()
e:: {
    HWND := WinGetID("Microsoft​ Edge")
    WinMinimize { Hwnd: HWND }
}
r::
t::
y::
u::
i::
o::
p::
[::
]::
\:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Alphabet Row 2 ================================;;

CapsLock::
a::
s:: {
    exe_process := "ahk_exe Spotify.exe"
    exe_name := "Spotify Free"
    exe_location := "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe"
    if WinActive(exe_name) {
        WinMinimize
    }
    else {
        if not WinExist(exe_name) {
            Run exe_location
        }
        else {
            WinActivate(exe_name)
        }
    }
}
d:: GetHotKey()
f::
g::
h::
j::
k::
l::
`;::
'::
Enter:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Alphabet Row 3 ================================;;

z:: {
    exe_process := "ahk_exe msedge.exe"
    exe_name := " - Microsoft​ Edge"
    exe_location := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    if WinActive(exe_name) {
        SendInput '^{Tab}'
    }
    else {
        if not WinExist(exe_name) {
            Run exe_location
        }
        else {
            WinActivate exe_name
        }
    }
}
x:: {
    exe_process := "ahk_exe brave.exe"
    exe_name := " - Brave"
    exe_location := "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

    if WinActive(exe_name) {
        SendInput '^{Tab}'
    }
    else {
        if not WinExist(exe_name) {
            Run exe_location
        }
        else {
            WinActivate exe_name
        }
    }
}
c:: {
    exe_process := "ahk_exe Code.exe"
    exe_name := " - Visual Studio Code"
    exe_location := "C:\Program Files\Microsoft VS Code\Code.exe"

    if WinActive(exe_name) {
        WinMinimize
    }
    else {
        if not WinExist(exe_name) {
            Run exe_location
        }
        else {
            WinActivate(exe_name)
        }
    }
}
v:: WinMinimize "A"
b:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
n:: GetHotKey()
m::
,::
.::
/:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Special Keys ================================;;

SC07E:: ;PrintScreen
SC061:: ;ScrollLock
CtrlBreak::
Insert::
End::
Home::
Delete::
PgUp::
PgDn::
Up::
Down::
Left::
Right:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
Space::Media_Play_Pause

;;========================== Modifier Keys ================================;;

SC070:: ;LShift
SC071:: ;LCtrl
SC072:: ;LWin
SC073:: ;LAlt

SC077:: ;RAlt
SC079:: ;Appskey
SC07B:: ;RCtrl
SC07D:: ;RShift
{
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Numpad keys ================================;;

SC05C:: ;NumLock
numpad0::
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::
numpadDiv::
numpadMult::
numpadSub::
numpadAdd::
numpadEnter::
numpadDot:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

#HotIf
;====================== END OF ==============================;;
