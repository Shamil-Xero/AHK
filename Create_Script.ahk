#Requires AutoHotkey v2.0
#SingleInstance Force

; === CONFIGURATION ===
defaultFolder := "D:\Programs\AHK\Developement"                                  ; Folder where new script will be created
defaultFileName := "NewScript.ahk"                          ; Default name (will auto-increment if exists)
editor := "D:\Programs Files\Visual Studio Code.lnk"        ; Leave blank to open in default editor (Notepad)

; === TEMPLATE CONTENT ===
template := "
(
#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Script Info ---
; Author: %A_UserName%
; Created: %A_YYYY%-%A_MM%-%A_DD%
; Description: [Enter description here]

; --- Hotkeys ---
; Example: Press F1 to show a message
F1::MsgBox('Hello from your new script!')

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