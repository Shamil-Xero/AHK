#Requires AutoHotkey v2.0
#WinActivateForce
#SingleInstance Force

loop 50 {
    try
        WinHide "Internet Download Manager"
    sleep 100
}
ExitApp
; g::{
; try
;     WinHide "Internet Download Manager"
; }

Esc:: ExitApp