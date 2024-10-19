#Requires AutoHotkey v2.0
#WinActivateForce
#SingleInstance Force

Run "C:\Program Files (x86)\Internet Download Manager\IDMan.exe", , "Min"
loop 50 {
    try
        WinHide "Internet Download Manager"
    sleep 100
}
ExitApp

Esc:: ExitApp
