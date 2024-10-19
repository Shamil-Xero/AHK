#SingleInstance Force
#Requires AutoHotkey v2.0
#include <Lib>

!e:: {
    SendInput "^+c"
    ClipWait
    Run "properties " A_Clipboard

}
shell := ComObject("WScript.Shell")
exec := shell.Exec(A_ComSpec " /c " '"C:\Program Files\Sunshine\tools\dxgi-info.exe"').StdOut.ReadAll()
msgbox exec

!f:: {
    ; exec := shell.Exec(A_ComSpec " /k " 'ipconfig | find "IP"').StdOut.ReadAll()
}

; AutoHotkey v2 script to open the file location of a selected file
#HotIf WinActive("ahk_class CabinetWClass")
^d:: ; Ctrl + Shift + O
{
    try
    {
        Send "^+c"
        sleep 200

        if FileExist("D:\Code\AHK\keynametest.ahk") {
            Run '"explorer.exe" /select ,' A_Clipboard
        }
        else {
            MsgBox "No file selected or invalid file path."
        }
    }
    catch {
        MsgBox "An error occurred while trying to open the file location."
    }
}
#HotIf

Esc:: ExitApp