; #Include "%A_WorkingDir%\V2_Lib.ahk"
; #Requires AutoHotkey v2.0
; TraySetIcon A_WorkingDir "`\keyboard.png"
; #include "%A_WorkingDir%\Lib\AutoHotInterception.ahk"
; AHI := AutoHotInterception()
; id1 := AHI.GetKeyboardId(0xC0F4, 0x04F5, 1)
; cm1 := AHI.CreateContextManager(id1)
; return
; #NoTrayIcon

;;================= START OF SECOND KEYBOARD ======================;;
#Requires AutoHotkey v2.0
#SingleInstance force
SendMode "Input"
Persistent
#Include <Lib>
#include Lib\AutoHotInterception.ahk
; #Include "%A_WorkingDir%\V2_Lib.ahk"

AHI := AutoHotInterception()
id1 := AHI.GetKeyboardId(0xC0F4, 0x04F5, 1)
cm1 := AHI.CreateContextManager(id1)
ToolTip "Interception Enabled"
SetTimer RemoveToolTip, -500
return

#HotIf cm1.IsActive

;;========================== Fuction Keys ================================;;
Esc:: Reload
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

;;========================== Number Row ================================;;

`:: {
    a := A_TickCount
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        ToolTip "Tap"
    }
    else if (KeyWait(GetFilteredHotKey(), "T2")) {
        ToolTip "Press"
    }
    else {
        KeyWait(GetFilteredHotKey())
        ToolTip "Hold"
    }
    MsgBox A_TickCount - a
    ToolTip ""
}
1:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("D:\Code\AHK")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Code\AHK.code-workspace")
    }
}
2:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("D:\Code\C")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Code\C.code-workspace")
    }
}
3:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("D:\Code\Python")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Code\Python.code-workspace")

    }
}
4:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("D:\Code\Java")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Code\Java.code-workspace")
    }
}
5:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("D:\Code\JavaScript")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("D:\Code\JavaScript.code-workspace")
    }
}
; 6::
7:: Run("https://github.com/Shamil-Xero")
; 8::
; 9::
0:: Run("C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE")
-:: Run("C:\Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE")
=:: Run("C:\Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE")
BS:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Alphabet Row 1 ================================;;
Tab::
q:: RunApplication("WhatsApp", "D:\Programs Files\WhatsApp.lnk")
w:: RunApplication("Unigram", "D:\Programs Files\Unigram.lnk")
e:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run "C:\Program Files\qBittorrent\qbittorrent.exe"
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
    }
}
r::
t:: RunApplication(" - Discord",
    "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\Discord.lnk")
y:: Run("C:\Users\Shamil\AppData\Local\Playnite\Playnite.DesktopApp.exe")
u:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
i:: Run "http://instagram.com/"
o:: RunApplication("ahk_class TankWindowClass",
    "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Steam\Overwatch® 2.url")
p:: RunApplication("ahk_class TankWindowClass",
    "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Steam\Marvel Rivals.url")
[::RunApplication("Adobe Photoshop", "D:\Programs Files\Adobe Photoshop 2025\Photoshop.exe", "#{Down}")
]::RunApplication("Adobe Lightroom", "C:\Program Files\Adobe\Adobe Lightroom 2024\Lightroom.exe", "#{Down}")
\:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Alphabet Row 2 ================================;;

CapsLock::
a:: RunApplication("VLC media player", "C:\Program Files\VideoLAN\VLC\vlc.exe")
s:: RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")
d:: Run "https://www.youtube.com/"
f:: Run '"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/"'
g:: Run "http://localhost:8096/web/#/home.html"
h:: {
    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        Run("C:\Windows\System32\cmd.exe")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
    }
}
j::
k::
l::
`;::RunApplication("Adobe Premiere Pro", "D:\Programs Files\Adobe Premiere Pro 2025\Adobe Premiere Pro.exe", "#{Down}")
'::RunApplication("Adobe After Effects", "C:\Program Files\Adobe\Adobe After Effects 2024\Adobe After Effects.exe", "#{Down}")
Enter:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}

;;========================== Alphabet Row 3 ================================;;

z:: RunApplication("Microsoft​ Edge", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe", "^{Tab}")
x:: RunApplication("Brave", "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe", "^{Tab}")
c:: RunApplication("Visual Studio Code", "C:\Program Files\Microsoft VS Code\Code.exe", "^{Tab}")
v:: Run("D:\Programs Files\TickTick\TickTick.exe")
b:: RunApplication("Notion Calendar", "D:\Programs Files\Notion Calendar.lnk")
n:: RunApplication("ahk_exe Notion.exe", "C:\Users\shami\AppData\Local\Programs\Notion\Notion.exe")
m::
,::
.::{
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
/:: Run("calc.exe")
;;========================== Special Keys ================================;;

SC07E:: ;PrintScreen
SC061:: ;ScrollLock
PrintScreen:: ;PrintScreen
ScrollLock:: ;ScrollLock
CtrlBreak::
Insert::
End::
Home::
Delete::
PgUp::
PgDn:: {
    ToolTip A_ThisHotkey
    SetTimer RemoveToolTip, -200
}
Up:: {
    ; Send "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    Send "d"
    WinActivate(Current_Window)
}
Down:: {
    ; Send "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    Send "s"
    WinActivate(Current_Window)
}
Left:: {
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    Send "{Right}"
    WinActivate(Current_Window)
}
Right:: {
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    Send "{Right}"
    WinActivate(Current_Window)
}
Space::Media_Play_Pause

;;========================== Modifier Keys ================================;;

SC070:: ;LShift
SC071:: ;LCtrl
SC072:: Send "{LWin}" ;LWin
SC073:: ;LAlt

SC077:: ;RAlt
SC079:: ;Appskey
SC07B:: ;RCtrl
SC07D:: ;RShift
LShift::
LControl::
LWin::
LAlt::
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
