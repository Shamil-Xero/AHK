;;================= START OF SECOND KEYBOARD ======================;;
#Requires AutoHotkey v2.0
#SingleInstance force
TraySetIcon A_WorkingDir "`\keyboard.png"
; #NoTrayIcon
Persistent

#Include <Lib>
#include Lib\AutoHotInterception.ahk
#include Lib\InterceptionTapHold.ahk
#include Lib\TapHoldManager.ahk

AHI := AutoHotInterception()
; Zebronics
keyboardId := AHI.GetKeyboardId(0xC0F4, 0x04F5)
; Laptop In_Built
; keyboardId := AHI.GetKeyboardId(0x048D, 0xC986)
ITH1 := InterceptionTapHold(AHI, keyboardId)
cm1 := AHI.CreateContextManager(keyboardId)
/*


AHI.SubscribeKeyboard(keyboardId, true, KeyEvent)
KeyEvent(code, state) {
    if (state = 1)
        ToolTip("Keyboard Key - Code: " code ", State: " state)

}
*/
#HotIf cm1.IsActive

; ITH1.Add("1", Func1)
return
Func1(isHold, taps, state) {
    ToolTip("KB 1 Key 1 `n" (isHold ? "HOLD" : "TAP") "`nTaps: " taps "`nState: " state)
}
; ITH1.Add(A_ThisHotkey, Func1)

;;========================== Fuction Keys ================================;;
Esc:: ExitApp
F1:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

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
Tab::
q::
w::
e::
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
a:: {
    ToolTip "SetTimer"
    SetTimer RemoveToolTip, -200
}
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
d:: {
    p := Morse()
    if (p = 0) {
        Run("https://www.youtube.com/feed/subscriptions")
    } else if (p = 0) {
        Run("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/feed/subscriptions"
        )
    }
}
f:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
g:: ToolTip A_ThisHotkey
g up:: ToolTip ""
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
n:: {
    p := Morse()
    MsgBox p
}
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
PrintScreen:: ;PrintScreen
ScrollLock:: ;ScrollLock
CtrlBreak:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
Insert:: {
    i := 10
    Run 'cmd /c Shutdown /s /t ' i
    ; p := Morse()
    /*
    if p == "1" {
        Run 'cmd /c Shutdown /a'
        ; restart := MsgBox("Restart?", , "Y/N")
        ; if restart == "Yes"
        ;     Run 'cmd /c Shutdown /r /t 0'
    }
    else if p = "0" {
        i := 5
        ; if result == "Timeout"
        ;     MsgBox "Boom"
        ; Run 'cmd /c Shutdown /s /t ' i
        result := MsgBox("Shutting Down in " i " seconds", "", 'OKCancel T' i)
        ; loop i{
        ;     ToolTip i
        ;     sleep 1000
        ;     i--
        ; }
        ; RemoveToolTip()
        if result == "Cancel"
            ToolTip
        else if result == "Timeout" or result == "Ok"
            Run 'cmd /c Shutdown /s /t ' i
    }
    else if p == "00" {
        result := MsgBox("Restarting in " i " seconds", "", "OKCancel T" i)
        ; loop i{
        ;     ToolTip i
        ;     sleep 1000
        ;     i--
        ; }
        ; RemoveToolTip()
        if result == "Cancel"
            ToolTip
        else if result == "Timeout" or result == "Ok"
            Run 'cmd /c Shutdown /r /t ' i
    }
    else{
        MsgBox p
    }
    */
}
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
LShift::
LControl::
LWin::
; LAlt::
RAlt::
{
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
LControl & RAlt:: MsgBox "You pressed AltGr itself."
Appskey::
RControl::
RShift::
{
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Numpad keys ================================;;

SC05C:: ;NumLock
Numlock::
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
numpadDot::
{
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

#HotIf

;====================== END OF ==============================;;

^Esc:: ExitApp

^`:: Reload