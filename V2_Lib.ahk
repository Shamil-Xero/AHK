#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode 2
; #WinActivateForce

SetWorkingDir A_ScriptDir
SetTitleMatchMode 2
DetectHiddenWindows true

WorkingDir := A_WorkingDir

A_HotkeyInterval := 2000
A_MaxHotkeysPerInterval := 200

Morse(timeout := 500) {
    ErrorLevel := 0
    tout := timeout / 1000
    key := RegExReplace(A_ThisHotKey, "[\*\~\$\#\+\!\^\[\]]")
    Loop {
        t := A_TickCount
        KeyWait key
        Pattern .= (A_TickCount - t) > timeout
        if !KeyWait(key, "DT" tout) {
            Return Pattern
        }
    }
}

; Morse(&tout := 500)
; {   
;     global key
;     global tick := A_TickCount
; 	if ((A_TickCount-tick) > tout)
; 	    key :=
; 	tick := A_TickCount
;     global key .= A_ThisHotKey
; 	Return
; }

GetFilteredHotKey() {
    Filtered_Key := RegExReplace(A_ThisHotKey, "[*~$#+!^]")
    return Filtered_Key
}

GetHotKey(&tout := 500)
{   
    global key
    global tick := A_TickCount
	if ((A_TickCount-tick) > tout)
	    key :=
	tick := A_TickCount
    global key .= A_ThisHotKey
    SetTimer RunMacros, -tout
	Return
}

RunMacros()
{
	global key
	ToolTip key
	SetTimer RemoveToolTip, -500
	SetTimer Close_Get_KeyCodes, -500
	Keyboard_Codes()
	key := ""
}

RunApplication(exe_process, exe_location, action){
    if (KeyWait(GetFilteredHotKey(), "T0.2")){
        
        if WinActive(exe_process){
            action
        }
        else{
            if not WinExist(exe_process){
                Run exe_location
            }
            else{
                WinActivate(exe_process)
            }    
        }
    }
    else{
        KeyWait(GetFilteredHotKey(), "T10")
        Run exe_location
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
    DllCall(NumGet(NumGet(IPolicyConfig+0, "UPtr")+13*A_PtrSize, "UPtr"), "UPtr", IPolicyConfig, "UPtr", &DeviceID, "UInt", 0, "UInt")
    ObjRelease(IPolicyConfig)
    Return
}

Close_Get_KeyCodes()
{
    Try{
        WinClose "\Get_KeyCodes.ahk - AutoHotkey ahk_class AutoHotkey"
    }
	Return
}

RemoveToolTip()
{
    ToolTip ""
}

Nothing()
{  
    ToolTip ""
	return
}

MyMenu1 := Menu()
MyMenu2 := Menu()
MyMenu3 := Menu()
MyMenu4 := Menu()
MyMenu5 := Menu()
MySubMenu5 := Menu()
MyMenu6 := Menu()

MyMenu1.Add("AHK", MenuHandler1)
MyMenu1.Add("ADB", MenuHandler1)
MyMenu1.Add("Code", MenuHandler1)
MenuHandler1(Item, *)
{
    if (Item == "ADB"){
        Run "D:\ADB"
    }else if (Item == "AHK"){
        Run "D:\AHK"
    }else if (Item == "Code"){
        Run "D:\Code"
    }
}

MyMenu2.Add("Downlaods", MenuHandler2)
MyMenu2.Add("Documents", MenuHandler2)
MyMenu2.Add("Setups", MenuHandler2)
MyMenu2.Add("Android", MenuHandler2)
MenuHandler2(Item, *)
{
    if (Item == "Downloads"){
        Run "S:\Downloads"
    }else if (Item == "Documents"){
        Run "S:\Documents"
    }else if (Item == "Setups"){
        Run "E:\Setups"
    }else if (Item == "Android"){
        Run "E:\Apps"
    }
}


MyMenu3.Add("Anime", MenuHandler3)
MyMenu3.Add("Movies", MenuHandler3)
MyMenu3.Add("Web Series", MenuHandler3)
MyMenu3.Add("Games", MenuHandler3)
MenuHandler3(Item, *)
{
    if (Item = "Movies"){
        Run "E:\Movies"
    }
    else{
        ToolTip Item
        SetTimer RemoveTooltip, -500
    }
}



MyMenu4.Add("USB", MenuHandler4)
MyMenu4.Add("TCPIP", MenuHandler4)
MyMenu4.Add("OTG", MenuHandler4)
MenuHandler4(Item, *)
{
    ToolTip Item
    SetTimer RemoveTooltip, -500
}


MySubMenu5.Add("C", SubMenuHandler5)
MySubMenu5.Add("D", SubMenuHandler5)
MySubMenu5.Add("E", SubMenuHandler5)
MySubMenu5.Add("F", SubMenuHandler5)
MyMenu5.Add("Drives", MySubMenu5)
MenuHandler5(Item, *)
{
    ToolTip Item
    SetTimer RemoveTooltip, -500
}


MyMenu6.Add("Power Saver", MenuHandler6)
MyMenu6.Add("Balanced", MenuHandler6)
MyMenu6.Add("Performance", MenuHandler6)
SubMenuHandler5(Item, *)
{
    ToolTip Item
    SetTimer RemoveTooltip, -500
}
MenuHandler6(Item, *)
{
    If (Item = "Power Saver") {
        Run 'powercfg -s a1841308-3541-4fab-bc81-f71556f20b4a'
    } else if (Item = "Balanced") {
        Run 'powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e'
    } else if (Item = "Performance") {
        Run 'powercfg -s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'
    }
}

#Include "%A_WorkingDir%\Macro_Codes.ahk"