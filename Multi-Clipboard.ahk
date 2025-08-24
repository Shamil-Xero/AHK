#Requires AutoHotkey v2.0
#SingleInstance Force

; Disable spell check in VSCode for this file
; // cspell:disable

global maxSlots := 9
global clipboardFolder := A_WorkingDir . "\clipboard"

; Create clipboard folder if it doesn't exist
if !DirExist(clipboardFolder) {
    DirCreate(clipboardFolder)
}

ShowTooltip(message) {
    ToolTip(message)
    SetTimer(() => ToolTip(), -3000)
}

CopyToSlot(slotNumber) {
    ; Backup current clipboard
    oldClipboard := A_Clipboard
    A_Clipboard := ""

    ; Copy selection
    Send("^c")

    ; Wait for clipboard to contain data
    if !ClipWait(1, 1) {
        A_Clipboard := oldClipboard
        ShowTooltip("Nothing to copy!")
        return
    }

    ; Save clipboard to file
    slotFile := clipboardFolder . "\clipboard" . slotNumber . ".clip"
    try {
        ; Delete any existing file and then use FileAppend
        if FileExist(slotFile) {
            FileDelete(slotFile)
        }
        FileAppend(ClipboardAll(), slotFile)
        ShowTooltip("Copied to slot " . slotNumber)
    } catch Error as e {
        ShowTooltip("Error saving to slot " . slotNumber . ": " . e.Message)
    }

    ; Restore original clipboard
    A_Clipboard := oldClipboard

    ShowTooltip("Copied to slot " . slotNumber)
}

CutToSlot(slotNumber) {
    ; Backup current clipboard
    oldClipboard := A_Clipboard
    A_Clipboard := ""

    ; Cut selection
    Send("^x")

    ; Wait for clipboard to contain data
    if !ClipWait(1, 1) {
        A_Clipboard := oldClipboard
        ShowTooltip("Nothing to cut!")
        return
    }

    ; Save clipboard to file
    slotFile := clipboardFolder . "\clipboard" . slotNumber . ".clip"
    try {
        ; Delete any existing file and then use FileAppend
        if FileExist(slotFile) {
            FileDelete(slotFile)
        }
        FileAppend(ClipboardAll(), slotFile)
        ShowTooltip("Cut to slot " . slotNumber)
    } catch Error as e {
        ShowTooltip("Error saving to slot " . slotNumber . ": " . e.Message)
    }

    ; Restore original clipboard
    A_Clipboard := oldClipboard

    ShowTooltip("Cut to slot " . slotNumber)
}

PasteFromSlot(slotNumber) {
    slotFile := clipboardFolder . "\clipboard" . slotNumber . ".clip"

    if !FileExist(slotFile) {
        ShowTooltip("Slot " . slotNumber . " is empty!")
        return
    }

    try {
        ; Read clipboard data from file
        ClipData := FileRead(slotFile, "RAW")

        ; Backup current clipboard
        oldClipboard := A_Clipboard

        ; Set clipboard to slot content
        A_Clipboard := ClipboardAll(ClipData)

        ; Paste
        Send("^v")

        ; Restore original clipboard after a short delay
        SetTimer(() => A_Clipboard := oldClipboard, -500)

        ShowTooltip("Pasted from slot " . slotNumber)
    } catch Error as e {
        ShowTooltip("Error pasting from slot " . slotNumber . ": " . e.Message)
    }
}

ClearAllSlots() {
    try {
        loop maxSlots {
            slotFile := clipboardFolder . "\clipboard" . A_Index . ".clip"
            if FileExist(slotFile) {
                FileDelete(slotFile)
            }
        }
        ShowTooltip("All slots cleared!")
    } catch Error as e {
        ShowTooltip("Error clearing slots: " . e.Message)
    }
}

^Numpad1:: CopyToSlot(1)
^Numpad2:: CopyToSlot(2)
^Numpad3:: CopyToSlot(3)
^Numpad4:: CopyToSlot(4)
^Numpad5:: CopyToSlot(5)
^Numpad6:: CopyToSlot(6)
^Numpad7:: CopyToSlot(7)
^Numpad8:: CopyToSlot(8)
^Numpad9:: CopyToSlot(9)

!Numpad1:: CutToSlot(1)
!Numpad2:: CutToSlot(2)
!Numpad3:: CutToSlot(3)
!Numpad4:: CutToSlot(4)
!Numpad5:: CutToSlot(5)
!Numpad6:: CutToSlot(6)
!Numpad7:: CutToSlot(7)
!Numpad8:: CutToSlot(8)
!Numpad9:: CutToSlot(9)

^!Numpad1:: PasteFromSlot(1)
^!Numpad2:: PasteFromSlot(2)
^!Numpad3:: PasteFromSlot(3)
^!Numpad4:: PasteFromSlot(4)
^!Numpad5:: PasteFromSlot(5)
^!Numpad6:: PasteFromSlot(6)
^!Numpad7:: PasteFromSlot(7)
^!Numpad8:: PasteFromSlot(8)
^!Numpad9:: PasteFromSlot(9)