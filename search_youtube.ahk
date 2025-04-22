#Requires AutoHotkey v2
#SingleInstance Force
SetTitleMatchMode 2

WinActivate("Microsoft​ Edge")
while (!WinActive("YouTube")) {
    Send "^{Tab}"
    Sleep 100
}

^Esc:: ExitApp