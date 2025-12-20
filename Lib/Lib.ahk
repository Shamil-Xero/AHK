#Requires AutoHotkey v2.0
; #WinActivateForce
SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode 2
DetectHiddenWindows true

; // cspell:disable (This is for disabling the spell check in VSCode)

;========================== Variables =================================;
global Brightness_Increments := 5
global CurrentBrightness := GetCurrentBrightNess()
; WorkingDir := A_WorkingDir
; Secret_Mode := False
global p := ""
mytick := 0

A_HotkeyInterval := 2000
A_MaxHotkeysPerInterval := 200

;========================== Functions =================================;

Morse(timeout := 300) {
    tout := timeout / 1000
    key := RegExReplace(A_ThisHotKey, "[\*\~\$\#\+\!\^\[\]]")
    loop {
        t := A_TickCount
        KeyWait key
        Pattern .= (A_TickCount - t) > timeout
        if !KeyWait(key, "D T" tout) {
            return Pattern
        }
    }
}

Morse2(timeout := 300) {
    global p
    tout := timeout / 1000
    t := A_TickCount
    p .= "0"
    loop {
        if ((A_TickCount - t) > timeout) {
            Pattern := p
            p := ""
            return Pattern
        }
    }
}

GetFilteredHotKey() {
    Filtered_Key := RegExReplace(A_ThisHotKey, "[*~$#+!^]")
    return Filtered_Key
}

GetHotKey(&tout := 300) {
    global key
    global tick := A_TickCount
    if ((A_TickCount - tick) > tout)
        key :=
            tick := A_TickCount
    global key .= A_ThisHotKey
    SetTimer Keyboard_Codes, -tout
    return
}

RunApplication(title, path := "", launch_mode := "", ifactive_send := "") {
    GroupName := StrReplace(StrReplace(StrReplace(StrReplace(title, " "), "."), "_"), "-") . "Group"
    if !WinExist(title) {
        if path {
            try {
                Run path, , launch_mode
                if (path == "explorer.exe") {
                    loop 10 {
                        try {
                            WinClose("Microsoft Visual C++ Runtime Library")
                        }
                        sleep 100
                    }
                }
            }
            catch {
                ToolTip "An error occurred while running the application: " title ", Specify a valid location!"
                SetTimer RemoveToolTip, -1000
                return
            }
        }
        else {
            ToolTip "Please specify the application's location"
            SetTimer RemoveToolTip, -1000
            return
        }
        GroupAdd(GroupName, title)
    }
    else if WinActive(title) {
        if ifactive_send {
            Send(ifactive_send)
        }
        else {
            GroupActivate(GroupName, "r")
        }
    }
    else {
        WinActivate(title)
        GroupAdd(GroupName, title)
    }
}

GetDeviceID(Devices, Name) {
    for DeviceName, DeviceID in Devices {
        if InStr(DeviceName, Name)
            return DeviceID
    }
    return
}

IsDeviceConnected(instanceId) {
    ; Create a temporary PowerShell script file
    scriptFile := A_Temp "\check_device.ps1"
    scriptContent :=
        '$d = Get-PnpDevice -InstanceId "' instanceId '" -ErrorAction SilentlyContinue`n' .
        'if ($d -and $d.Status -eq "OK") { exit 0 } else { exit 1 }'

    try FileDelete scriptFile
    FileAppend scriptContent, scriptFile

    exitcode := RunWait('powershell -NoProfile -ExecutionPolicy Bypass -File "' scriptFile '"', , "Hide")

    try FileDelete scriptFile

    return (exitcode = 0)
}

SetDefaultEndpoint(DeviceID) {
    IPolicyConfig := ComObject("{870af99c-171d-4f9e-af0d-e63df40c2bc9}", "{F8679F50-850A-41CF-9C72-430F290290C8}")
    DllCall(NumGet(NumGet(IPolicyConfig + 0, "UPtr") + 13 * A_PtrSize, "UPtr"), "UPtr", IPolicyConfig, "UPtr", &
    DeviceID, "UInt", 0, "UInt")
    ObjRelease(IPolicyConfig)
    return
}

GetCurrentBrightNess() {
    try {
        for property in ComObjGet("winmgmts:\\.\root\WMI").ExecQuery("SELECT * FROM WmiMonitorBrightness")
            global CurrentBrightness := property.CurrentBrightness

        return CurrentBrightness
    }
}

ChangeBrightness(brightness, timeout := 1) {
    if (brightness >= 0 && brightness <= 100) {
        for property in ComObjGet("winmgmts:\\.\root\WMI").ExecQuery("SELECT * FROM WmiMonitorBrightnessMethods")
            property.WmiSetBrightness(timeout, brightness)
    }
    else if (brightness > 100) {
        brightness := 100
    }
    else if (brightness < 0) {
        brightness := 0
    }
    return
}

; Close_Get_KeyCodes()
; {
;     Try{
;         WinClose "\Get_KeyCodes.ahk - AutoHotkey ahk_class AutoHotkey"
;     }
; 	Return
; }

ShowTooltip(message, timeout := 2000) {
    ToolTip(message)
    SetTimer(() => ToolTip(), -timeout)
}

RemoveToolTip() {
    ToolTip ""
}

MouseIsOver(WinTitle) {
    try {

        MouseGetPos &X, &Y, &Win, &WinCtrl
        if (WinTitle == "TrayNotifyWnd1" && WinCtrl == "TrayNotifyWnd1") {
            if (X >= 1746 || X <= 1722)
                return true
        }
        else
            return WinExist(WinTitle " ahk_id " Win)
    }
}

#Include Macro_Codes.ahk