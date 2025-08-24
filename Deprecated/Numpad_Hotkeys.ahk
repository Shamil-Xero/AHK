#Requires AutoHotkey v2.0
SendMode "Input"
#Include <Lib>

; // cspell:disable (This is for disabling the spell check in VSCode)

NumpadSub:: {
    shutdown_timer := 0
    Run 'cmd /c Shutdown /s /t ' shutdown_timer, , "Hide"
}

NumpadMult:: {
    restart_timer := 0
    Run 'cmd /c Shutdown /r /t ' restart_timer, , "Hide"
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