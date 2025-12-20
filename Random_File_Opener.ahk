#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "F:\Backup\Wondershare Converter\To Sort"
global DestinationFolder := "F:\Backup\Wondershare Converter\Sorted"
global SyncFolder := "D:\Synced\Sync\.Delete"

global FileList := []
global ReviewList := []

global TotalFiles := 0
global FileCount := 0
global CurrentIndex := 0

global MoveList := []
global CopyList := []
global DeleteList := []
global SkipList := []

global CurrentFilePid := 0
global WaitingForInput := false

global FilePath := ""
global FileName := ""
global FileSizeMB := 0

RemoveToolTip() {
    ToolTip ""
}

; ----------------------------------------
; Build master file list
; ----------------------------------------
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
    ib := InputBox(
        "Enter the Number of Files`n(Total: " TotalFiles ")",
        "Random File Opener",
        "w300 h120",
        "10"
    )
    if (ib.Result = "Cancel")
        ExitApp
    return Integer(ib.Value)
}

; ----------------------------------------
; Build random review list WITH file sizes
; ----------------------------------------
BuildRandomReviewList(count) {
    global
    local tempList := FileList.Clone()
    local review := []

    loop count {
        if (tempList.Length = 0)
            break

        n := Random(1, tempList.Length)
        path := tempList[n]

        sizeMB := FileGetSize(path, "M")

        review.Push({
            Path: path,
            Name: GetFileName(path),
            SizeMB: sizeMB
        })

        tempList.RemoveAt(n)
    }
    return review
}

GetFileName(fullPath) {
    SplitPath fullPath, &name
    return name
}

; ----------------------------------------
; UI helpers
; ----------------------------------------
ShowFileInfo() {
    global

    if (FileSizeMB >= 1024) {
        size := Round(FileSizeMB / 1024, 2) " GB"
    } else {
        size := Round(FileSizeMB, 1) " MB"
    }

    ToolTip
    (
        "(" (CurrentIndex + 1) "/" FileCount ") " FileName
        "`n`nFile Size: " size
    )

    SetTimer RemoveToolTip, -2000
    try WinActivate("ahk_pid " CurrentFilePid)
}

ProcessFile(fileObj) {
    global

    FilePath := fileObj.Path
    FileName := fileObj.Name
    FileSizeMB := fileObj.SizeMB

    if (!FileExist(FilePath)) {
        ToolTip "File not found!"
        SetTimer RemoveToolTip, -2000
        return false
    }
    ShowFileInfo()
    sleep 50

    try {
        Run(FilePath, , , &CurrentFilePid)
        Sleep 800
        WinActivate("ahk_pid " CurrentFilePid)
        WaitingForInput := true
        return true
    } catch as e {
        ToolTip "Error opening file:`n" e.Message
        SetTimer RemoveToolTip, -3000
        return false
    }
}

CloseFile() {
    global
    try WinClose("ahk_pid " CurrentFilePid)
}

; ----------------------------------------
; Main logic
; ----------------------------------------
Main() {
    global

    InitializeFileList()
    if (TotalFiles = 0) {
        ToolTip "No files found!"
        SetTimer RemoveToolTip, -3000
        return
    }

    FileCount := GetFileCount()
    if (FileCount > TotalFiles)
        FileCount := TotalFiles

    ReviewList := BuildRandomReviewList(FileCount)

    CurrentIndex := 0
    loop FileCount {
        fileObj := ReviewList[CurrentIndex + 1]

        if (ProcessFile(fileObj)) {
            while (WaitingForInput)
                Sleep 100
        }
        CurrentIndex++
    }

    ProcessMoveDeleteLists()
}

; ----------------------------------------
; Summary + processing
; ----------------------------------------
FormatList(list) {
    out := ""
    for idx, file in list {
        out .= GetFileName(file) "`n"
        if (idx >= 10) {
            out .= "..."
            break
        }
    }
    return out
}

ProcessMoveDeleteLists() {
    global

    msg :=
    (
        "Copy (" CopyList.Length "):`n" FormatList(CopyList)
        "`nMove (" MoveList.Length "):`n" FormatList(MoveList)
        "`nDelete (" DeleteList.Length "):`n" FormatList(DeleteList)
        "`nSkip (" SkipList.Length "):`n" FormatList(SkipList)
    )

    if (MsgBox(msg "`nProceed?", "Confirm", "OKCancel") = "Cancel")
        ExitApp

    for _, f in DeleteList
        FileDelete f

    for _, f in CopyList {
        DirCreate SyncFolder
        FileCopy f, SyncFolder "\" GetFileName(f), 1
    }

    for _, f in MoveList {
        DirCreate DestinationFolder
        FileMove f, DestinationFolder "\" GetFileName(f), 1
    }

    ToolTip "Processing completed!"
    Sleep 2000
    ExitApp
}

; ----------------------------------------
; Hotkeys
; ----------------------------------------
Home::ShowFileInfo()

Delete::
NumpadDiv:: {
    global
    if (WaitingForInput) {
        CloseFile()
        SkipList.Push(FilePath)
        WaitingForInput := false
    }
}

PgUp::
NumpadMult:: {
    global
    if (WaitingForInput) {
        CloseFile()
        DeleteList.Push(FilePath)
        WaitingForInput := false
    }
}

PgDn::
NumpadSub:: {
    global
    if (WaitingForInput) {
        CloseFile()
        MoveList.Push(FilePath)
        WaitingForInput := false
    }
}

+PgDn::
+NumpadSub:: {
    global
    if (WaitingForInput) {
        CloseFile()
        CopyList.Push(FilePath)
        MoveList.Push(FilePath)
        WaitingForInput := false
    }
}

^Esc::ExitApp

Main()
