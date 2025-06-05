#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "DynamicNumpad.ahk"  ; Include the refactored class

; Global variables
global numpadGui := ""
global numpadModes := 4
global currentMode := 1
global interceptEnabled := false

; =======================
; Configuration
; =======================
; Key used to determine if key is intercepted
INTERCEPT_KEY := "F23"
INTERCEPT := A_WorkingDir "\Lib\Intercept\intercept.exe"
INTERCEPT_PATH := A_WorkingDir "\Lib\intercept"

; =======================
; Main Script
; =======================

; Initialize the script
InitScript()

; =======================
; Functions
; =======================

/**
 * Initialize the script and setup the environment
 */
InitScript() {
    ; Start the interception driver if not already running
    ; if (!IsInterceptRunning()) {
    EnableInterception()
    ; }

    ; Show the numpad GUI with the current mode
    ShowNumpadGUI(currentMode)

    ; Show a brief tooltip to confirm the mode
    ShowModeTooltip()
}

/**
 * Check if the interception driver is running
 */
IsInterceptRunning() {
    return ProcessExist("intercept.exe")
}

/**
 * Enable the interception driver
 */
EnableInterception() {
    try {
        ; Kill any existing intercept processes
        RunWait('cmd.exe /c taskkill /IM intercept.exe /F', , "Hide")

        ; Run the intercept driver
        Run('cmd.exe /c ' INTERCEPT ' /apply', INTERCEPT_PATH, "Hide")

        interceptEnabled := true
    } catch as err {
        MsgBox("Failed to start interception: " err.Message "`n`nPlease make sure intercept.exe is installed in: " INTERCEPT_PATH
        )
        ExitApp
    }
}

/**
 * Show the numpad GUI with the specified mode
 */
ShowNumpadGUI(mode, timeout := -1, iniFile := "") {
    global currentMode, numpadGui

    ; Destroy existing GUI if it exists
    if (numpadGui != "") {
        try {
            numpadGui.gui.Destroy()
        } catch {
        }
    }

    ; Create a new GUI with the specified mode
    numpadGui := DynamicNumpad(iniFile, timeout, mode)

    ; Show current mode in tooltip
    ShowModeTooltip()
}

/**
 * Show a tooltip with the current mode
 */
ShowModeTooltip() {
    ToolTip "Mode: " currentMode
    SetTimer ToolTip, -500
}

/**
 * Check if keys are currently being intercepted
 */
IsIntercepted() {
    return GetKeyState(INTERCEPT_KEY, "P")
}

/**
 * Check if we're in a specific mode with interception active
 */
numpadMode1() {
    global currentMode
    if (currentMode == 1 and IsIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode2() {
    global currentMode
    if (currentMode == 2 and IsIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode3() {
    global currentMode
    if (currentMode == 3 and IsIntercepted) {
        return true
    }
    else {
        return false
    }
}

numpadMode4() {
    global currentMode

    if (currentMode == 4 and IsIntercepted) {
        return true
    }
    else {
        return false
    }
}

; =======================
; Hotkeys
; =======================

; Mode switching hotkeys
#HotIf IsIntercepted()

; Decrement mode (/ key)
NumpadDiv:: {
    global currentMode
    currentMode := currentMode = 1 ? numpadModes : currentMode - 1
    ShowNumpadGUI(currentMode)
}

; Show GUI with timeout (* key)
NumpadMult:: {
    global currentMode
    ShowNumpadGUI(currentMode, numpadModes + 1)
}

; Increment mode (- key)
NumpadSub:: {
    global currentMode
    currentMode := Mod(currentMode, numpadModes) + 1
    ShowNumpadGUI(currentMode)
}

; Mode 1: Default Numpad (pass-through keys)
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
NumpadEnter:: {
    ToolTip "Mode: " currentMode " - Key {" A_ThisHotkey "}"
    SetTimer ToolTip, -500
}

; Mode 2: Application Launcher
#HotIf numpadMode2()
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
NumpadEnter:: {
    ToolTip "Mode: " currentMode " - Key {" A_ThisHotkey "}"
    SetTimer ToolTip, -500
}

; Mode 3: YouTube Tools
#HotIf numpadMode3()
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
NumpadEnter:: {
    ToolTip "Mode: " currentMode " - Key {" A_ThisHotkey "}"
    SetTimer ToolTip, -500
}

; Mode 4: Custom Mode
#HotIf numpadMode4()
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
NumpadEnter:: {
    ToolTip "Mode: " currentMode " - Key {" A_ThisHotkey "}"
    SetTimer ToolTip, -500
}

#HotIf  ; End conditional hotkeys
