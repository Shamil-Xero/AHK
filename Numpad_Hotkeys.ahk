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



;Function to create and show the Numpad GUI
ShowNumpadGUI() {
    global currentMode
    ToolTip "Mode : " currentMode
    SetTimer ToolTip, -500
    Run "D:\Programs\AHK\Numpad_GUI.ahk"
}

numpadMode1() {
    global currentMode
    global keyboardIntercepted

    if (currentMode == 1 and keyboardIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode2() {
    global currentMode
    global keyboardIntercepted

    if (currentMode == 2 and keyboardIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode3() {
    global currentMode
    global keyboardIntercepted

    if (currentMode == 3 and keyboardIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode4() {
    global currentMode
    global keyboardIntercepted

    if (currentMode == 4 and keyboardIntercepted) {
        return true
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
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadMult:: {
    restart_timer := 0
    Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
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
    P := Morse()
    if (p == "0") {
        Run("https://www.youtube.com/", , "max")
    } else if (p == "1") {
        Run(
            '"C:\Users\Shamil\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Brave.lnk" "https://www.youtube.com/"', ,
            "max")
    } else {
        ToolTip "Morse Code: " p
        SetTimer RemoveToolTip, -1000
    }

}

Numpad5:: {

    if (KeyWait(GetFilteredHotKey(), "T0.3")) {
        RunApplication(" - File Explorer", "explorer.exe")
    }
    else {
        KeyWait(GetFilteredHotKey())
        Run "explorer.exe"
    }
}

Numpad6:: return

Numpad7:: {
    Run "D:\Programs\AHK.code-workspace"
}

Numpad8:: {
    Run "D:\Programs\Python-Scripts.code-workspace"
}

Numpad9:: {
    Run "calc.exe"
}

Numpad0:: {
    RunWait 'cmd.exe /c python "D:\Programs\Python-Scripts\Random-Youtube-Video-from-Playlist.py" "https://www.youtube.com/playlist?list=PLb-MR2Hfk3tlmemTNdCG_K4QiTehgJAr9"', ,
        "Min"
}

NumpadDot:: ToolTip A_ThisHotkey

; Mode 3: Youtube
#HotIf numpadMode3()

Numpad7:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Audio-Downloader.py ' A_Clipboard
}

Numpad8:: {
    Run 'cmd.exe /c python D:\Programs\Python-Scripts\YouTube-Downloader.py ' A_Clipboard

}

Numpad9:: {
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

Numpad4::{
    if (p == "1") {
        Send "^c"
        sleep 10
        Run 'cmd.exe /k ollama run llama3.1:8b ' A_Clipboard
    }
    else if (p == "11") {
        Send "^c"
        Run 'cmd.exe /k ollama run llama3.1:8b '
        Sleep 10
        Send "^v{Enter}"
    }
    else if (p == "111") {
        KeyWait(GetFilteredHotKey())
        Run 'cmd.exe /k ollama run llama3.1:8b '

    }
}

#HotIf