#Requires AutoHotkey v2.0
#SingleInstance Force

; === CONFIGURATION ===
if (A_Args.Length < 1) {
    A_Args.Push(A_ScriptDir)
}

if (A_Args.Length < 2) {
    A_Args.Push("NewScript.ahk")
}

if (A_Args.Length < 3) {
    A_Args.Push("notepad.exe")
}
defaultFolder := A_Args[1]                            ; Folder where new script will be created
defaultFileName := A_Args[2]                          ; Default name (will auto-increment if exists)
editor := A_Args[3]                                   ; Leave blank to open in default editor (Notepad)

; === TEMPLATE CONTENT ===
template := "
(
#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Hotkeys ---
; Example: Press F1 to show a message
F1::MsgBox('Hello from your new script!')




; Add your hotkeys and code here







#SuspendExempt
^!s::Suspend  ; Ctrl+Alt+S to Suspend/Resume script
#SuspendExempt False

^Esc::ExitApp  ; Ctrl+Esc to exit script


; --- End of Template ---
)"

; === CREATE UNIQUE FILE ===
filePath := defaultFolder "\" defaultFileName
counter := 1
while FileExist(filePath) {
    filePath := defaultFolder "\" RegExReplace(defaultFileName, "\.ahk$", "") "_" counter ".ahk"
    counter++
}

; === WRITE TEMPLATE ===
FileAppend(template, filePath, "UTF-8")

; === OPEN FILE IN EDITOR ===
if (editor != "")
    Run(editor " " filePath "")
else
    Run(filePath) ; opens in system’s default editor for .ahk files

ToolTip("New AHK script created:`n" filePath)
Sleep 500
ExitApp