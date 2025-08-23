#Requires AutoHotkey v2.0
#SingleInstance Force

global clipboardSlots := Map()
global maxSlots := 9
global clipboardFolder := A_WorkingDir . "\clipboard"

; Create clipboard folder if it doesn't exist
if !DirExist(clipboardFolder) {
    DirCreate(clipboardFolder)
}

ShowTooltip(message) {
    ToolTip(message)
    SetTimer(() => ToolTip(), -1000)
}

CopyToSlot(slotNumber) {
    ; Backup current clipboard
    oldClipboard := A_Clipboard
    A_Clipboard := ""

    ; Copy selection
    Send("^c")

    ; Wait for clipboard to contain data
    if !ClipWait(1) {
        A_Clipboard := oldClipboard
        ShowTooltip("Nothing to copy!")
        return
    }

    ; Store in slot
    clipboardSlots[slotNumber] := A_Clipboard
    ; Save to file
    SaveSlotToFile(slotNumber, A_Clipboard)
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
    if !ClipWait(1) {
        A_Clipboard := oldClipboard
        ShowTooltip("Nothing to cut!")
        return
    }

    ; Store in slot
    clipboardSlots[slotNumber] := A_Clipboard
    ; Save to file
    SaveSlotToFile(slotNumber, A_Clipboard)
    ; Restore original clipboard
    A_Clipboard := oldClipboard

    ShowTooltip("Cut to slot " . slotNumber)
}

PasteFromSlot(slotNumber) {
    if !clipboardSlots.Has(slotNumber) {
        ShowTooltip("Slot " . slotNumber . " is empty!")
        return
    }

    ; Backup current clipboard
    oldClipboard := A_Clipboard

    ; Set clipboard to slot content
    A_Clipboard := clipboardSlots[slotNumber]

    ; Paste
    Send("^v")

    ; Restore original clipboard after a short delay
    SetTimer(() => A_Clipboard := oldClipboard, -500)

    ShowTooltip("Pasted from slot " . slotNumber)
}

ClearAllSlots() {
    clipboardSlots.Clear()
    ; Clear all files
    ClearAllSlotsFromFiles()
    ShowTooltip("All slots cleared!")
}

; Load all slots from individual files
LoadSlotsFromFiles() {
    try {
        loop maxSlots {
            slotFile := clipboardFolder . "\clipboard" . A_Index . ".txt"
            if FileExist(slotFile) {
                content := FileRead(slotFile, "UTF-8")
                if (content != "") {
                    clipboardSlots[A_Index] := content
                }
            }
        }
    } catch Error as e {
        ; Files might not exist or be corrupted, continue without loading
        ShowTooltip("Error loading slots: " . e.Message)
    }
}

; Save a specific slot to individual file
SaveSlotToFile(slotNumber, content) {
    slotFile := clipboardFolder . "\clipboard" . slotNumber . ".txt"
    try {
        FileDelete(slotFile)  ; Delete existing file first
    }
    try {
        FileAppend(content, slotFile, "UTF-8")
    } catch Error as e {
        ShowTooltip("Error saving slot " . slotNumber . " to file: " . e.Message)
    }
}

; Clear all slots from individual files
ClearAllSlotsFromFiles() {
    try {
        loop maxSlots {
            slotFile := clipboardFolder . "\clipboard" . A_Index . ".txt"
            if FileExist(slotFile) {
                FileDelete(slotFile)
            }
        }
    } catch Error as e {
        ; Files might not exist, that's okay
        ShowTooltip("Error clearing files: " . e.Message)
    }
}

; Load slots on startup
LoadSlotsFromFiles()

; ^Numpad1:: CopyToSlot(1)
; ^Numpad2:: CopyToSlot(2)
; ^Numpad3:: CopyToSlot(3)
; ^Numpad4:: CopyToSlot(4)
; ^Numpad5:: CopyToSlot(5)
; ^Numpad6:: CopyToSlot(6)
; ^Numpad7:: CopyToSlot(7)
; ^Numpad8:: CopyToSlot(8)
; ^Numpad9:: CopyToSlot(9)

; !Numpad1:: CutToSlot(1)
; !Numpad2:: CutToSlot(2)
; !Numpad3:: CutToSlot(3)
; !Numpad4:: CutToSlot(4)
; !Numpad5:: CutToSlot(5)
; !Numpad6:: CutToSlot(6)
; !Numpad7:: CutToSlot(7)
; !Numpad8:: CutToSlot(8)
; !Numpad9:: CutToSlot(9)

; ^!Numpad1:: PasteFromSlot(1)
; ^!Numpad2:: PasteFromSlot(2)
; ^!Numpad3:: PasteFromSlot(3)
; ^!Numpad4:: PasteFromSlot(4)
; ^!Numpad5:: PasteFromSlot(5)
; ^!Numpad6:: PasteFromSlot(6)
; ^!Numpad7:: PasteFromSlot(7)
; ^!Numpad8:: PasteFromSlot(8)
; ^!Numpad9:: PasteFromSlot(9)
