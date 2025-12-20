#Requires AutoHotkey v2.0
#SingleInstance Force

; =========================
; CATEGORY → APPS
; =========================
Apps := Map(
    "Notepad", "notepad.exe",
    "Calc", "calc.exe",
    "Explorer", "explorer.exe",
    "MSPaint", "mspaint.exe"
)

; Convert Map keys to indexed array
AppNames := []
for name in Apps
    AppNames.Push(name)

; =========================
; STATE
; =========================
AppIndex := 0
ActionWindow := false
ActionTimeout := 1000

; =========================
; HELPERS
; =========================

CloseActionWindow() {
    global ActionWindow
    ActionWindow := 0
    ToolTip("")
}

RemoveToolTip() {
    ToolTip("")
}

ActivateApp(PID) {
    try WinActivate("ahk_pid " . PID)
}

; =========================
; CONTROLS
; =========================

; Shift + WheelDown → Cycle apps
+WheelDown:: {
    global AppIndex, AppNames, ActionWindow, ActionTimeout
    AppIndex++
    if (AppIndex > AppNames.Length)
        AppIndex := 1

    ToolTip(AppNames[AppIndex])
    ActionWindow := true
    SetTimer(CloseActionWindow, -ActionTimeout)
}

; Shift + WheelUp → Cycle apps / Launch if repeated quickly
#HotIf ActionWindow
+WheelUp:: {
    global AppIndex, AppNames, Apps
    appName := AppNames[AppIndex]
    CloseActionWindow()
    Run(Apps[appName])
    WinWait(appName)
    PID := WinGetPID(appName)
    ActivateApp(PID)
}

#SuspendExempt
^!s::Suspend  ; Ctrl+Alt+S
#SuspendExempt False

^Esc::ExitApp  ; Ctrl+Esc to exit script
