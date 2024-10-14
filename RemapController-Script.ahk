#Requires AutoHotkey v2.0

#SingleInstance Force
SetTimer WatchAxis, 5

WatchAxis()
{
    static KeyToHoldDown := ""
    JoyZ := GetKeyState("JoyZ")  ; Get position of X axis.
    JoyR := GetKeyState("JoyR")  ; Get position of Y axis.
    KeyToHoldDownPrev := KeyToHoldDown  ; Prev now holds the key that was down before (if any).

    if JoyZ > 70
        KeyToHoldDown := "{Right}"
    else if JoyZ < 30
        KeyToHoldDown := "{Left}"
    else if JoyR > 70
        KeyToHoldDown := "{Down}"
    else if JoyR < 30
        KeyToHoldDown := "{Up}"
    else
        KeyToHoldDown := ""

    if KeyToHoldDown = KeyToHoldDownPrev  ; The correct key is already down (or no key is needed).
        return  ; Do nothing.

    ; Otherwise, release the previous key and press down the new key:
    SetKeyDelay -1  ; Avoid delays between keystrokes.
    ; if (KeyToHoldDownPrev && GetKeyState("Joy11", "P")){ ; There is a previous key to release.
    ;     Send "{" KeyToHoldDownPrev " up}"  ; Release it.
    ; }
    if (KeyToHoldDown && GetKeyState("Joy11", "P")){   ; There is a key to press down.
        Send KeyToHoldDown  ; Press it down.
    }
}