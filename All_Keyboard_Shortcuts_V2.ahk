#Requires AutoHotkey v2.0
SetWorkingDir A_WorkingDir  ; Ensures a consistent starting directory.
TraySetIcon A_WorkingDir "`\AutoHotKeyV2.png"

;==========================================================;;

#Include "%A_WorkingDir%\V2_Lib.ahk"


Run "*RunAs " A_WorkingDir "\Second_Keyboard_Shortcuts_V2.ahk"

Run "*RunAs " A_WorkingDir "\All_Keyboard_Shortcuts.ahk"

Run "*RunAs " A_WorkingDir "\Minimize_To_Tray.ahk"

RunWait '*RunAs cmd.exe /c taskkill /IM intercept.exe /F', , "Hide"

Run '*RunAs cmd.exe /c "Intercept\intercept.exe " /apply' , ,"Hide"

;===============================SPECIAL KEYS===================================::

!`::Run "*RunAs " A_WorkingDir "\All_Keyboard_Shortcuts_V2.ahk"
; Run, cmd.exe /c "taskkill /f /im autohotkey.exe"

Browser_Home::{
    ; Speach := "dooooooont press this"
    ; Runwait A_WorkingDir '\voice.exe' ' -r' ' 2' ' -d' Speach,,'Hide'
    SendInput "^+{Esc}"
    ; MsgBox A_ThisHotKey
}

Launch_Mail::Return

;Media_Play_Pause::Return

Media_Stop::Return

;Media_Prev::Return

;Media_Next::Return

~Volume_Up::Return

~Volume_Down::Return

;Volume_Mute::Return

Launch_App1::Msgbox "Hi"


;===============================END OF SPECIAL KEYS============================;;



#HotIf WinActive("ahk_class CabinetWClass") ;Clicks the Folder path in File explorer like clicking the url in browsers

^e::SendInput "^l"


#HotIf !WinActive("ahk_exe Overwatch.exe")
~^c::{
    ToolTip "Copied"
    SetTimer RemoveTooltip, -250
    return
}

~^v::{
    ToolTip "Pasted"
    SetTimer RemoveToolTip, -250
    Return
}

~^x::{
    ToolTip "Cuted"
    SetTimer RemoveToolTip, -250
    Return
}
#HotIf 

; #e::Run "explorer.exe"

!i::SendInput "{Up}"
!k::SendInput "{Down}"
!l::SendInput "{Right}"
!j::SendInput "{Left}"

>^\::AltTab
RCtrl & RAlt::AppsKey
$CapsLock::Backspace
+CapsLock::CapsLock

;===================== Tap, Press & Hold Shortcuts ======================;

~LWin::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        ; SendInput "{Lwin}"
    }
    else if (KeyWait(GetFilteredHotKey(), "T1")){
        ; msgbox "Press"
    }
    else if (KeyWait(GetFilteredHotKey(), "T10")){
        ; msgbox "Hold"
    }
}


;===================== Ctrl & Shift Shortcuts ======================;

^+d::{
    exe_process := "ahk_exe Code.exe"
    exe_location := "C:\Program Files\Microsoft VS Code\Code.exe"

    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        
        if WinActive(exe_process){
            WinMinimize
            ; SendInput "#4"
        }
        else{
            if WinExist(exe_process){
                ; WinActivate(exe_process)
                SendInput "#4"
            }
            else{
                ; Run exe_location
                SendInput "#4"
            }    
        }
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

^+e::{
    
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "C:\Users\Shamil\AppData\Local\Programs\Notion\Notion.exe"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Users\Shamil\AppData\Local\Programs\cron-web\Notion Calendar.exe"
    }
}

^+f::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run '*RunAs cmd.exe'
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "E:\Programs\Terminal.lnk"
    }
}

^+g::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Runwait 'cmd /c ipconfig | find "IPv4" | find "192.168" > ip.txt' , ,"Hide"
        sleep 100
        FileName := "D:\AHK\ip.txt"
        ipadd := FileRead(FileName)
        i := 0
        Loop Parse, ipadd, " ", ":"
        {
            i++
            if (i==17){
                tooltip "Local IP: " A_LoopField
            }
        }
        SetTimer RemoveToolTip, -3000
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run 'cmd /c cd /d "C:\Program Files\Sunshine\tools" && dxgi-info.exe | find "Output Name" > "D:\AHK\disp.txt"', ,"Hide"
        sleep 100
        FileName := "D:\AHK\disp.txt"
        ipadd := FileRead(FileName)
        i := 0
        Loop Parse, ipadd, " ", ":"
        {	
            i++
            if (i==27){
                tooltip "Display ID: " A_LoopField
            }
        }
        SetTimer RemoveToolTip, -3000
    }
}

^+q::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Program Files\qBittorrent\qbittorrent.exe"
    }
}

^+s::{
    exe_process := "ahk_exe Spotify.exe"
    exe_location := "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe"

    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        
        if WinActive(exe_process){
            SendInput "#3"
        }
        else{
            if not WinExist(exe_process){
                ; Run exe_location
                SendInput "#3"
            }
            else{
                ; WinActivate(exe_process)
                SendInput "#3"
            }    
        }
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        SendInput '{Media_Play_Pause}'
    }
}

^+w::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "D:\Programs\WhatsApp.lnk"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "D:\Programs\Telegram Desktop.lnk"
    }
}

^+x::{
    exe_process := "ahk_exe brave.exe"
    exe_name := " - Brave"
    exe_location := "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
    
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        
        if WinActive(exe_name){
            SendInput '^{Tab}'
        }
        else{
            if not WinExist(exe_name){
                Run exe_location
                ; SendInput "#2"
            }
            else{
                WinActivate exe_name
                ; SendInput "#2"
            }    
        }
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

^+y::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "https://www.youtube.com/feed/subscriptions"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run '"C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "https://www.youtube.com/feed/subscriptions"'
    }
}

^+z::{
    exe_process := "ahk_exe msedge.exe"
    exe_name := " - Microsoft​ Edge"
    exe_location := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
     
        if WinActive(exe_name){
            SendInput '^{Tab}'
        }
        else{
            if not WinExist(exe_name){
                Run exe_location
            }
            else{
                WinActivate exe_name
            }    
        }
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
    }
}

;=============================== Alt & Ctrl Shortcuts =================================;
^!s::SendInput "^#v"

^!z::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "D:\Programs\Shortcuts\Lenovo Vantage.lnk"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "C:\Users\Shamil\AppData\Local\Playnite\Playnite.DesktopApp.exe"
    }
}

;================================= Ctrl Shortcuts =======================================;

; ^r::{
;     if (KeyWait(GetFilteredHotKey(), "T0.2")){
;         Run "Disconnect_Buds.ahk"
;     }
;     else{
;         KeyWait(GetFilteredHotKey(), "T10")
;         Run "Connect_Buds.ahk"
;     }
; }

^F1::{
    t := !t
    Devices := {}
    if t=1
    {
        SetDefaultEndpoint(GetDeviceID(Devices, "Headphone"))
        ToolTip "Buds"
        SetTimer RemoveToolTip, -1000
    }
    else
    {
        SetDefaultEndpoint(GetDeviceID(Devices, "Speakers")) 
        ToolTip "Speakers"
        SetTimer RemoveToolTip, -1000
    }
}

;================================= Other Shortcuts =======================================;



^+WheelUp::Run "C:\Windows\System32\SndVol.exe"
^+WheelDown::Run "D:\Programs\Nahimic.lnk"

^+/::{
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "C:\Windows\System32\SndVol.exe"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run "D:\Programs\Nahimic.lnk"
    }
}

!w::SendInput "!{F4}"
; ^+WheelDown::
#s::SendInput "{Printscreen}"
#+s::SendInput "#+t"
^!b::Run "C:\Program Files\AutoHotkey\WindowSpy.ahk"
^+m::Run "C:\Windows\System32\mblctr.exe"

>^Up::Volume_Up
>^Down::Volume_Down
>^Left::Media_Play_Pause
>^Right::Media_Next

;================================= Context Sensitive Shortcuts =======================================;


#HotIf !WinActive("ahk_exe vlc.exe")
!1::MyMenu1.Show()
!2::MyMenu2.Show()
!3::MyMenu3.Show()
!4::MyMenu4.Show()
!5::MyMenu5.Show()
!+z::MyMenu6.Show()


#HotIf WinActive("ahk_class Qt5QWindowIcon")
/::SendInput "jjjj"
0::Send "{Ctrl Down}{WheelUp}{Ctrl Up}"
9::Send "{Ctrl Down}{WheelDown}{Ctrl Up}"
BS::
\::Send "^{Right}{Right}{Right}+{Right}+{Right}+{Right}"
>^Left::SendInput "^{Left}"
>^Right::SendInput "^{Right}"


#HotIf WinActive("ahk_exe Spotify.exe")
>^Up::SendInput "^{Up}"
>^Down::SendInput "^{Down}"


#HotIf WinActive("ahk_exe brave.exe")
!q::{

    MouseGetPos &x, &y
    MouseClick "Left", 1755, 922,,0
    MouseMove x, y, 0
}
Return


#HotIf MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Volume_Up
WheelDown::Volume_Down

MouseIsOver(WinTitle) {
    MouseGetPos ,, &Win
    return WinExist(WinTitle " ahk_id " Win)
}
#HotIf

;================================= Controller Controls =======================================;

; Joy5::{
;     if GetKeyState("Joy11", "P"){
;         SendInput "{Media_Play_Pause}"
;     }
; }

; Joy6::{
;     if GetKeyState("Joy5", "P"){
;         SendInput "{Media_Play_Pause}"
;     }
; }

Joy6::{
    if GetKeyState("Joy11", "P"){
        SendInput "{Media_Play_Pause}"
    }
}

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

`::{
if (KeyWait(GetFilteredHotKey(), "T0.2")){
        Run "Get_KeyCodes.ahk"
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        SendInput "{ASC 96}"
    }
}

; KeyWait, %A_ThisHotKey%, T0.2
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
; Return


; #Include "%A_WorkingDir%\Second_Keyboard_Shortcuts_V2.ahk"