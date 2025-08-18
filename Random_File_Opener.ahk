#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "J:\Backup\F\To Sort"
global DestinationFolder := "J:\Backup\F\Sorted"
global FileList := []
global TotalFiles := 0
global FileCount := 0
global CurrentIndex := 0
global MoveList := []
global DeleteList := []
global SkipList := []
global CurrentFileObj := ""
global CurrentFilePid := 0
global WaitingForInput := false
global FileSizeMB := 0
global FilePath := ""
global FileName := ""

global ReviewList := []

global ReviewResults := [] ; Holds objects: {file: path, action: "move"|"delete"|"skip"}

RemoveToolTip() {
    ToolTip ""
}

InitializeFileList() {
    global
    FileList := []
    TotalFiles := 0
    loop files, SourceFolder "\*.*", "R" {
        FileList.Push(A_LoopFileFullPath)
        TotalFiles++
    }
}

GetFileCount() {
    global
    ib := InputBox("Enter the Number of Files`n(Total: " TotalFiles ")", "Files", "w300 h120", "10")
    if ib.Result = "Cancel"
        ExitApp
    return Integer(ib.value)
}

BuildRandomReviewList(count) {
    global
    local tempList := FileList.Clone()
    local review := []
    loop count {
        if (tempList.Length == 0)
            break
        n := Random(1, tempList.Length)
        review.Push(tempList[n])
        tempList.RemoveAt(n)
    }
    return review
}

GetFileName(FullPath) {
    loop parse FullPath, '\' {
        FileName := A_LoopField
    }
    return FileName
}

ShowFileInfo() {
    global
    if (FileSizeMB >= 1000) {
        FileSizeGB := FileSizeMB / 1024
        ToolTip "(" . (CurrentIndex + 1) . "/" . FileCount . ") " . FileName . "`n`nFile Size: " . Round(FileSizeGB, 2) .
        " GB"
    } else {
        ToolTip "(" . (CurrentIndex + 1) . "/" . FileCount . ") " . FileName . "`n`nFile Size: " . Round(FileSizeMB, 1) .
        " MB"
    }
    SetTimer RemoveToolTip, -2000
    try {
        WinActivate("ahk_pid " CurrentFilePid)
    }
}

ProcessFile(FilePath) {
    global
    if (FilePath == "" || !FileExist(FilePath)) {
        ToolTip "File doesn't exist or path is empty"
        SetTimer RemoveToolTip, -2000
        return false
    }
    FileName := GetFileName(FilePath)
    CurrentFileObj := FileOpen(FilePath, "r")
    FileSizeMB := CurrentFileObj.Length / 1048576
    ShowFileInfo()
    try {
        Run(FilePath, , , &CurrentFilePid)
        Sleep(1000)
        WinActivate("ahk_pid " CurrentFilePid)
        WaitingForInput := true
        return true
    }
    catch as e {
        ToolTip "Error opening file: " . e.Message . "`n`nPress any key to continue..."
        if (CurrentFileObj) {
            CurrentFileObj.Close()
            CurrentFileObj := ""
        }
        SetTimer RemoveToolTip, -3000
        return false
    }
}

CloseFile() {
    global
    try {
        WinClose("ahk_pid " CurrentFilePid)
    }
    catch as e {
        Tooltip "Cannot find window: " . e.Message
        SetTimer RemoveToolTip, -2000
    }
    if (CurrentFileObj) {
        CurrentFileObj.Close()
        CurrentFileObj := ""
    }
}

Main() {
    global
    InitializeFileList()
    if (TotalFiles == 0) {
        ToolTip "No Files Found in: " . SourceFolder
        SetTimer RemoveToolTip, -3000
        return
    }
    FileCount := GetFileCount()
    if (FileCount > TotalFiles) {
        FileCount := TotalFiles
    }
    ReviewList := BuildRandomReviewList(FileCount)
    CurrentIndex := 0
    loop FileCount {
        FilePath := ReviewList[CurrentIndex + 1]
        if (ProcessFile(FilePath)) {
            while (WaitingForInput) {
                Sleep(100)
            }
        }
        CurrentIndex++
    }
    ; After review, process actions
    Sleep 1000
    ToolTip "Processing move/delete actions..."
    SetTimer RemoveToolTip, -2000
    ProcessMoveDeleteLists()
}

FormatList(list) {
    out := ""
    for idx, file in list {
        out .= GetFileName(file) . "`n"
        if (idx >= 10) {
            out .= "..."
            break
        }
    }
    return out
}

ProcessMoveDeleteLists() {
    global
    moved := []
    deleted := []
    msg := "Move files (" . MoveList.Length . "):`n" . FormatList(MoveList) . "`nDelete files (" . DeleteList.Length .
    "):`n" . FormatList(DeleteList) . "`nSkip files (" . SkipList.Length . "):`n" . FormatList(SkipList)
    result := MsgBox(msg "`n Do you want to proceed with this action?", "OKCancel")
    if (result == "OK") {
        ; Move files
        for idx, filePath in MoveList {
            try {
                DirCreate DestinationFolder
                FileMove(filePath, DestinationFolder "\" . GetFileName(filePath), 1)
                moved.Push(filePath)
                sleep 100
            } catch as e {
                MsgBox "Error moving: " . filePath . "`n" . e.Message
                Sleep(1000)
            }
        }
        ; Delete files
        for idx, filePath in DeleteList {
            try {
                FileDelete(filePath)
                deleted.Push(filePath)
                sleep 100
            } catch as e {
                MsgBox "Error deleting: " . filePath . "`n" . e.Message
                Sleep(1000)
            }
        }
        ToolTip "Processing completed..."
        Sleep(2000)
    }
    else {
        ToolTip "File actions cancelled..."
        Sleep(2000)
    }
    ExitApp
}

ToMoveList() {
    global
    ; ToolTip "To Move:`n" . FormatList(MoveList)
    SetTimer RemoveToolTip, -1500
}

ToDeleteList() {
    global
    ; ToolTip "To Delete:`n" . FormatList(DeleteList)
    SetTimer RemoveToolTip, -1500
}

; Hotkey implementations

Home:: ShowFileInfo()

Delete:: {
    global
    if (WaitingForInput) {
        CloseFile()
        SkipList.Push(FilePath)
        ToolTip "Skipped:`n" . FormatList(SkipList)
        SetTimer RemoveToolTip, -1500
        WaitingForInput := false
    }
}

PgUp:: {
    global
    if (WaitingForInput) {
        CloseFile()
        DeleteList.Push(FilePath)
        ; SetTimer ToDeleteList, -1500
        WaitingForInput := false
    }
}

PgDn:: {
    global
    if (WaitingForInput) {
        CloseFile()
        MoveList.Push(FilePath)
        ; SetTimer ToMoveList, -1500
        WaitingForInput := false
    }
}

^Esc:: ExitApp

; Start the main process
Main()