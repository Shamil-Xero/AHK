#Requires AutoHotkey v2.0
#SingleInstance Force

s::{
    while(1){
        SendInput("{WheelUp}")
        sleep 75
    }
}

a::ExitApp