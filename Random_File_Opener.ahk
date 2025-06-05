#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "H:\Backup\F\To Sort"
global DestinationFolder := "H:\Backup\F\Sorted"
global FileList := []
global TotalFiles := 0
global CurrentIndex := 0
global Locked := 0
global FileCount := 0
global RemainingFiles := 0
global IsProcessing := false
global FilePath := ""
global PrevFilePath := ""
global CurrentFileObj := ""
global CurrentFilePid := 0
global WaitingForInput := false

RemoveToolTip() {
    ToolTip ""
}

InitializeFileList() {
    global
    ; ToolTip "Initializing file list..."
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

GetRandomFileName() {
    global
    if (FileList.Length == 0) {
        return ""
    }
    n := Random(1, FileList.Length)
    try {
        FilePath := FileList[n]
        FileList.RemoveAt(n)
        return FilePath
    }
    catch {
        return ""
    }
}

DeleteFile() {
    global
    if (PrevFilePath != "" && FileExist(PrevFilePath)) {
        try {
            FileDelete(PrevFilePath)
            ToolTip "File deleted: " . GetFileName(PrevFilePath)
            SetTimer RemoveToolTip, -1000
        }
        catch as e {
            ToolTip "Error deleting file: " . e.Message
            SetTimer RemoveToolTip, -3000
        }
    }
    IsProcessing := false
    if (CurrentFileObj)
        CurrentFileObj.Close()
}

MoveFile() {
    global
    if (PrevFilePath != "" && FileExist(PrevFilePath)) {
        try {
            DirCreate DestinationFolder
            FileMove(PrevFilePath, DestinationFolder "\" . GetFileName(PrevFilePath))
            ToolTip "File moved: " . GetFileName(PrevFilePath)
            SetTimer RemoveToolTip, -1000
        }
        catch as e {
            ToolTip "Error moving file: " . e.Message
            SetTimer RemoveToolTip, -3000
        }
    }
    IsProcessing := false
    if (CurrentFileObj)
        CurrentFileObj.Close()
}

CloseFile() {
    global
    PrevFilePath := FilePath
    try{
        WinClose("ahk_pid " CurrentFilePid)
    }
    catch as e{
        Tooltip "Cannot find window: " . e.Message
        SetTimer RemoveToolTip, -2000
    } 
    if (CurrentFileObj) {
        CurrentFileObj.Close()
        CurrentFileObj := ""
    }
}

GetFileName(FullPath) {
    loop parse FullPath, '\' {
        FileName := A_LoopField
    }
    return FileName
}

ShowFileInfo() {
    global
    ; Display file info
    if (FileSizeMB >= 1000) {
        FileSizeGB := FileSizeMB / 1024
        ToolTip "(" . (FileCount - RemainingFiles + 1) . "/" . FileCount . ") " . FileName . "`n`nFile Size: " .
        Round(FileSizeGB, 2) . " GB"
    } else {
        ToolTip "(" . (FileCount - RemainingFiles + 1) . "/" . FileCount . ") " . FileName . "`n`nFile Size: " .
        Round(FileSizeMB, 1) . " MB"
    }
    SetTimer RemoveToolTip, -2000
    try {
        WinActivate("ahk_pid " CurrentFilePid)
    }
}

ProcessFile() {
    global
    if (FilePath == "" || !FileExist(FilePath)) {
        ToolTip "File doesn't exist or path is empty"
        SetTimer RemoveToolTip, -2000
        return false
    }

    FileName := GetFileName(FilePath)

    ; Get file size
    CurrentFileObj := FileOpen(FilePath, "r")
    FileSizeMB := CurrentFileObj.Length / 1048576

    ShowFileInfo()

    try {
        ; Try to open the file
        Run(FilePath, , , &CurrentFilePid)
        Sleep(1000) ; Give time for the file to open
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

Main() {
    global

    InitializeFileList()

    if (TotalFiles == 0) {
        ToolTip "No Files Found in: " . SourceFolder
        SetTimer RemoveToolTip, -3000
        return
    }

    FileCount := GetFileCount()
    RemainingFiles := FileCount

    if (FileCount > TotalFiles) {
        FileCount := TotalFiles
        RemainingFiles := FileCount
    }

    ; ToolTip "Starting processing of " . FileCount . " files..."
    ; SetTimer RemoveToolTip, -2000
    ; Sleep(2000)

    loop FileCount {
        if (RemainingFiles <= 0)
            break

        FilePath := GetRandomFileName()
        if (FilePath == "") {
            ToolTip "No more files available"
            SetTimer RemoveToolTip, -2000
            break
        }

        if (ProcessFile()) {
            ; Wait for user input
            while (WaitingForInput) {
                Sleep(100)
            }

        }

        RemainingFiles--

        ; if (RemainingFiles > 0) {
        ;     Sleep(500) ; Brief pause between files
        ; }
    }

    ; Wait for any processing to complete
    while (IsProcessing) {
        Sleep(100)
    }

    ToolTip "Processing complete!"
    ; SetTimer RemoveToolTip, -1000
    Sleep(1000)
    ExitApp
}

; Hotkey implementations

Home:: ShowFileInfo()

Delete:: {
    global
    if (WaitingForInput) {
        CloseFile()
    }
}

PgUp:: {
    global
    if (WaitingForInput) {
        IsProcessing := true
        WaitingForInput := false
        CloseFile()
        SetTimer DeleteFile, -3000
    }
}

PgDn:: {
    global
    if (WaitingForInput) {
        IsProcessing := true
        WaitingForInput := false
        CloseFile()
        SetTimer MoveFile, -3000
    }
}

^Esc:: ExitApp

; Start the main process
Main()