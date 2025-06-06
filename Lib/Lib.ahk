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
WorkingDir := A_WorkingDir
Secret_Mode := False
p := 0
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
        if !KeyWait(key, "DT" tout) {
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

RunApplication(title, path := "", ifactive_send := "") {
    GroupName := StrReplace(StrReplace(StrReplace(StrReplace(title, " "), "."), "_"), "-") . "Group"
    if !WinExist(title) {
        if path {
            try {
                Run path
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

RemoveToolTip() {
    ToolTip ""
}

MyMenu1 := Menu()
MySubMenu1 := Menu()
MyMenu2 := Menu()
MyMenu3 := Menu()
MyMenu4 := Menu()
MyMenu5 := Menu()
MySubMenu5 := Menu()
MyMenu6 := Menu()

MySubMenu1.Add("AHK", SubMenuHandler1)
MySubMenu1.Add("SE", SubMenuHandler1)
MySubMenu1.Add("Java", SubMenuHandler1)
MySubMenu1.Add("DS", SubMenuHandler1)
MySubMenu1.Add("OS", SubMenuHandler1)
MyMenu1.Add("AHK", MenuHandler1)
MyMenu1.Add("ADB", MenuHandler1)
MyMenu1.Add("Code", MenuHandler1)
MyMenu1.Add("VS Code", MySubMenu1)
MenuHandler1(Item, *) {
    if (Item == "AHK") {
        Run "D:\Programs\AHK"
    } else if (Item == "ADB") {
        Run "D:\Programs\ADB"
    } else if (Item == "Code") {
        Run "D:\Programs"
    }
}
SubMenuHandler1(Item, *) {
    if (Item == "AHK") {
        Run "D:\Programs\AHK.code-workspace"
    } else if (Item == "SE") {
        Run "D:\Programs\TSMS.code-workspace"
    } else if (Item == "Java") {
        Run "D:\Programs\Java.code-workspace"
    } else if (Item == "DS") {
        Run "D:\Programs\Data Structure.code-workspace"
    } else if (Item == "OS") {
        Run "D:\Programs\Operating System.code-workspace"
    }
}

MyMenu2.Add("Android", MenuHandler2)
MyMenu2.Add("Setups", MenuHandler2)
MyMenu2.Add("Downlaods", MenuHandler2)
MyMenu2.Add("Documents", MenuHandler2)
MyMenu2.Add("Pictures", MenuHandler2)
MyMenu2.Add("ROM", MenuHandler2)
MenuHandler2(Item, *) {
    if (Item == "Downloads") {
        Run "E:\Downloads"
    } else if (Item == "Documents") {
        Run "E:\Documents"
    } else if (Item == "Pictures") {
        Run "E:\Pictures"
    } else if (Item == "Setups") {
        Run "F:\Setups"
    } else if (Item == "Android") {
        Run "F:\Backup\Apps"
    } else if (Item == "ROM") {
        Run "F:\OS\Android\!POCO F6"
    }
}

MyMenu3.Add("Anime", MenuHandler3)
MyMenu3.Add("Movies", MenuHandler3)
MyMenu3.Add("Shows", MenuHandler3)
MyMenu3.Add("Games", MenuHandler3)
MenuHandler3(Item, *) {
    if (Item = "Movies") {
        Run "F:\Movies"
    }
    else if (Item = "Anime") {
        Run "F:\Anime"
    } else if (Item = "Shows") {
        Run "F:\Shows"
    } else {
        ToolTip Item
        SetTimer RemoveTooltip, -500
    }
}

MyMenu4.Add("C", MenuHandler4)
MyMenu4.Add("D", MenuHandler4)
MyMenu4.Add("E", MenuHandler4)
MyMenu4.Add("S", MenuHandler4)
; MyMenu5.Add("Drives", MySubMenu5)
MenuHandler4(Item, *) {
    Run(Item ":\")
}
SubMenuHandler4(Item, *) {
    ToolTip Item
    SetTimer RemoveTooltip, -500
}

MyMenu5.Add("USB", MenuHandler5)
MyMenu5.Add("Enable TCPIP", MenuHandler5)
MyMenu5.Add("TCPIP", MenuHandler5)
MyMenu5.Add("OTG", MenuHandler5)
MenuHandler5(Item, *) {
    if (Item = "USB") {
        Run "D:\Programs\ADB\scrcpy-USB.vbs"
    }
    else if (Item = "Enable TCPIP") {
        Run "D:\Programs\ADB\scrcpy-enable-TCPIP.vbs"
    }
    else if (Item = "TCPIP") {
        Run "D:\Programs\ADB\scrcpy-TCPIP.vbs"
    }
    else if (Item = "OTG") {
        Run "D:\Programs\ADB\scrcpy-OTG.vbs"
    }
    else {
        ToolTip Item
        SetTimer RemoveTooltip, -500
    }
}

MyMenu6.Add("Power Saver", MenuHandler6)
MyMenu6.Add("Balanced", MenuHandler6)
MyMenu6.Add("Performance", MenuHandler6)
MenuHandler6(Item, *) {
    if (Item = "Power Saver") {
        Run 'powercfg -s a1841308-3541-4fab-bc81-f71556f20b4a'
    } else if (Item = "Balanced") {
        Run 'powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e'
    } else if (Item = "Performance") {
        Run 'powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'
    }
}
SubMenuHandler6(Item, *) {
    ToolTip Item
    SetTimer RemoveTooltip, -500
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