#SingleInstance Force
; #NoTrayIcon
#InstallKeybdHook
#WinActivateForce

deviceName := "realme TechLife Buds T100"

DllCall("LoadLibrary", "str", "Bthprops.cpl", "ptr")
VarSetCapacity(BLUETOOTH_DEVICE_SEARCH_PARAMS, 24+A_PtrSize*2, 0)
NumPut(24+A_PtrSize*2, BLUETOOTH_DEVICE_SEARCH_PARAMS, 0, "uint")
NumPut(1, BLUETOOTH_DEVICE_SEARCH_PARAMS, 4, "uint") ; fReturnAuthenticated
VarSetCapacity(BLUETOOTH_DEVICE_INFO, 560, 0)
NumPut(560, BLUETOOTH_DEVICE_INFO, 0, "uint")
loop
{
   If (A_Index = 1)
   {
      foundedDevice := DllCall("Bthprops.cpl\BluetoothFindFirstDevice", "ptr", &BLUETOOTH_DEVICE_SEARCH_PARAMS, "ptr", &BLUETOOTH_DEVICE_INFO)
      if !foundedDevice
      {
         msgbox "No bluetooth radios found"
         return
      }
   }
   else
   {
      if !DllCall("Bthprops.cpl\BluetoothFindNextDevice", "ptr", foundedDevice, "ptr", &BLUETOOTH_DEVICE_INFO)
      {
         ToolTip, "Device not found"
         Sleep 500
         ToolTip, ""
         break
      }
   }
   if (StrGet(&BLUETOOTH_DEVICE_INFO+64) = deviceName)
   {
      VarSetCapacity(Handsfree, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{0000111e-0000-1000-8000-00805f9b34fb}", "ptr", &Handsfree) ; https://www.bluetooth.com/specifications/assigned-numbers/service-discovery/
      VarSetCapacity(AudioSink, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{0000110b-0000-1000-8000-00805f9b34fb}", "ptr", &AudioSink)
      VarSetCapacity(GenAudServ, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{00001203-0000-1000-8000-00805F9B34FB}", "ptr", &GenAudServ)
      VarSetCapacity(HdstServ, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{00001108-0000-1000-8000-00805F9B34FB}", "ptr", &HdstServ)
      VarSetCapacity(AVRCTarget, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{0000110C-0000-1000-8000-00805F9B34FB}", "ptr", &AVRCTarget)
      VarSetCapacity(AVRC, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{0000110E-0000-1000-8000-00805F9B34FB}", "ptr", &AVRC)
      VarSetCapacity(AVRCController, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{0000110F-0000-1000-8000-00805F9B34FB}", "ptr", &AVRCController)
      VarSetCapacity(PnP, 16)
      DllCall("ole32\CLSIDFromString", "wstr", "{00001200-0000-1000-8000-00805F9B34FB}", "ptr", &PnP)

      hr1 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &Handsfree, "int", 0) ; voice
      hr2 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &AudioSink, "int", 0) ; music
      hr3 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &GenAudServ, "int", 0) ; music
      hr4 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &HdstServ, "int", 0) ; music
      hr5 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &AVRCTarget, "int", 0) ; music
      hr6 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &AVRC, "int", 0) ; music
      hr7 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &AVRCController, "int", 0) ; music
      hr8 := DllCall("Bthprops.cpl\BluetoothSetServiceState", "ptr", 0, "ptr", &BLUETOOTH_DEVICE_INFO, "ptr", &PnP, "int", 0) ; music

      if (hr1 = 0) and (hr2 = 0) and (hr4 = 0) and (hr5 = 0) and (hr6 = 0){
         MsgBox, "Break"
         break
      }
   }
}
DllCall("Bthprops.cpl\BluetoothFindDeviceClose", "ptr", foundedDevice)
ExitApp

; sleep 100000
