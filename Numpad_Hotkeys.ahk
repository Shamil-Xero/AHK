#Requires AutoHotkey v2.0
SendMode "Input"
#Include <Lib>

; // cspell:disable (This is for disabling the spell check in VSCode)

; TraySetIcon A_WorkingDir "`\Lib\Numpad.png"

; #SuspendExempt
; NumpadDot:: {
;     Suspend
; }
; #SuspendExempt False

; Function to handle button clicks
ButtonClick(btn, info) {
    ; Temporarily disable the destroy timer
    SetTimer(DestroyGUI, 0)

    ; Show file dialog to select an image
    selectedFile := FileSelect(3, , "Select an image", "Image Files (*.png; *.jpg; *.jpeg; *.bmp; *.gif)")
    if (selectedFile != "") {
        ; Hide the button text
        btn.Text := ""

        ; Get button position and size
        btn.GetPos(&x, &y, &w, &h)

        ; Create a new picture control
        pic := MyGui.Add("Picture", "x" x " y" y " w" w " h" h, selectedFile)
        pic.Opt("+BackgroundTrans")
    }

    ; Restart the destroy timer
    SetTimer(DestroyGUI, -2000)
}

;Function to create and show the Numpad GUI
ShowNumpadGUI() {
    ; Destroy existing GUI if it exists
    global MyGui
    global currentMode

    if (MyGui != "") {
        MyGui.Destroy()
        MyGui := ""
    }

    ; Create a new GUI instance
    MyGui := Gui()
    MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; Removed +Owner as it can cause issues
    MyGui.BackColor := "EEAA99"
    MyGui.SetFont("s12", "Consolas")

    ; Create a grid of buttons with arithmetic operations
    keys := [
        ["NumLock", "/", "*", "-"],
        ["7", "8", "9", "+"],
        ["4", "5", "6"],
        ["1", "2", "3", "Enter"],
        ["0", "", "."]  ; Merged 0 and Add keys
    ]

    ; Add mode indicator at the top
    modeText := "Mode " currentMode
    if (currentMode = 1)
        modeText .= " - Normal"
    else if (currentMode = 2)
        modeText .= " - Macros"
    else if (currentMode = 3)
        modeText .= " - Apps"
    else if (currentMode = 4)
        modeText .= " - Special"

    MyGui.Add("Text", "w400 h30 Center", modeText)

    ; Create the numpad grid
    for rowIndex, row in keys {
        for colIndex, key in row {
            if (key != "") {
                xPos := (colIndex - 1) * 90
                yPos := (rowIndex - 1) * 90
                switch (key) {
                    case "0":
                        MyGui.Add("Button", "w170 h80 x" xPos " y" yPos, key)
                    case "+":
                        MyGui.Add("Button", "w80 h170 x" xPos " y" yPos, key)
                    case "Enter":
                        MyGui.Add("Button", "w80 h170 x" xPos " y" yPos, key)
                    default:
                        MyGui.Add("Button", "w80 h80 x" xPos " y" yPos, key)
                }
            }
        }
    }

    ; Get the Hwnd of the GUI
    hwnd := MyGui.Hwnd

    ; First apply the NoActivate style
    WinSetExStyle("+0x08000000", "ahk_id " hwnd)  ; WS_EX_NOACTIVATE

    ; Apply transparency
    WinSetTransColor(MyGui.BackColor " 100", "ahk_id " hwnd)

    ; Position and size the window before showing
    WinMove(50, A_ScreenHeight - 500, 360, 450, "ahk_id " hwnd)  ; Added width and height

    ; Show the GUI without activating it
    DllCall("ShowWindow", "Ptr", hwnd, "Int", 4)  ; SW_SHOWNOACTIVATE = 4

    ; Make sure it's topmost
    WinSetAlwaysOnTop(true, "ahk_id " hwnd)

    ; Show debug tooltip
    ToolTip(modeText)
    SetTimer(RemoveToolTip, -1000)

    ; Hide the GUI after 2 seconds
    SetTimer(DestroyGUI, -2000)
}

; Function to destroy the GUI
DestroyGUI() {
    global MyGui
    if (MyGui != "") {
        MyGui.Destroy()
        MyGui := ""
    }
}

numpadMode1() {
    global interception
    global currentMode
    if currentMode == 1 {
        if interception {
            return currentMode == 1 and interception.IsActive
        }
        else {
            return currentMode == 1
        }
    }
    else {
        return false
    }
}

numpadMode2() {
    global interception
    global currentMode
    if currentMode == 2 {
        if interception {
            return currentMode == 2 and interception.IsActive
        }
        else {
            return currentMode == 2
        }
    }
    else {
        return false
    }
}

; Mode 1: Normal Mode
#HotIf numpadMode1()
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
Numpad0::
NumpadDot::
NumpadAdd::
NumpadSub::
NumpadMult::
NumpadDiv::
NumpadEnter:: Send "{" A_ThisHotkey "}"

; Mode 2: Macros
#HotIf numpadMode2()
NumpadAdd:: ToolTip A_ThisHotkey

NumpadSub:: {
    ; shutdown_timer := 0
    ; Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadMult:: {
    ; restart_timer := 0
    ; Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
}

NumpadEnter::Media_Play_Pause

Numpad1:: {
    RunApplication("Microsoft​ Edge", "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
}

Numpad2:: {
    RunApplication("Brave", "C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Brave.lnk")
}

Numpad3:: {
    RunApplication("Spotify Free", "C:\Users\Shamil\AppData\Roaming\Spotify\Spotify.exe")
}

Numpad4:: {
    Run "D:\Programs\AHK.code-workspace"
}

Numpad5:: {
    Run "D:\Programs\Python-Scripts.code-workspace"
}

Numpad6:: {
    Tooltip ""
    ; Runwait A_WorkingDir '\voice.exe' ' -f -r 3 -k D:\Downloads\Response.txt'
    ; loop read "D:\hello.txt"{
    ;     Runwait A_WorkingDir '\voice.exe' ' -f -r' ' 3' ' -d' A_LoopReadLine,,'Hide'
    ; }
}

Numpad7:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Audio-Downloader.py ' A_Clipboard
}

Numpad8:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Downloader.py ' A_Clipboard

}

Numpad9:: ToolTip A_ThisHotkey

Numpad0:: {
    RunWait 'cmd.exe /c python "D:\Programs\Python-Scripts\Random-Youtube-Video-from-Playlist.py" "https://www.youtube.com/playlist?list=PLb-MR2Hfk3tlmemTNdCG_K4QiTehgJAr9"', ,
        "Min"
}

NumpadDot:: ToolTip A_ThisHotkey

#HotIf