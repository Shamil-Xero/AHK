#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "J:\Backup\F\To Sort"
global DestinationFolder := "J:\Backup\F\Sorted"
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
global FileGui := ""

RemoveToolTip() {
    ToolTip ""
}

CreateFileDetailsGui(FileName, FilePath, FileSize, FileCount, RemainingFiles) {
    global

    ; Close existing GUI if it exists
    if (FileGui) {
        try {
            FileGui.Close()
        }
        catch {
            ; GUI might already be closed
        }
    }

    ; Create new GUI
    FileGui := Gui("+AlwaysOnTop +ToolWindow", "File Details - " . FileName)
    FileGui.OnEvent("Close", CloseFileGui)
    FileGui.OnEvent("Escape", CloseFileGui)

    ; Set GUI options
    FileGui.MarginX := 15
    FileGui.MarginY := 15

    ; Progress info
    ProgressText := "Processing: " . (FileCount - RemainingFiles + 1) . " / " . FileCount
    FileGui.Add("Text", "w400 Center", ProgressText).SetFont("s10 Bold")

    ; File name (shortened if too long)
    DisplayName := FileName
    if (StrLen(DisplayName) > 50) {
        DisplayName := SubStr(DisplayName, 1, 47) . "..."
    }
    FileGui.Add("Text", "w400 Center", DisplayName).SetFont("s12 Bold")

    ; File path (shortened if too long)
    DisplayPath := FilePath
    if (StrLen(DisplayPath) > 60) {
        DisplayPath := "..." . SubStr(DisplayPath, -57)
    }
    FileGui.Add("Text", "w400 Center c0x666666", DisplayPath).SetFont("s9")

    ; File size
    FileGui.Add("Text", "w400 Center", "File Size: " . FileSize).SetFont("s10")

    ; Separator line
    FileGui.Add("Text", "w400 h2 0x10")  ; SS_SUNKEN

    ; Action buttons
    ButtonY := FileGui.Add("Text", "w400 Center", "Choose an action:").SetFont("s10")

    ; Button container
    BtnContainer := FileGui.Add("Text", "w400 h60")

    ; Action buttons with your custom hotkeys
    MoveBtn := FileGui.Add("Button", "x35 y+10 w100 h35", "Page&Dn - Move")
    MoveBtn.OnEvent("Click", (*) => HandleGuiAction("move"))

    DeleteBtn := FileGui.Add("Button", "x+15 w100 h35", "Page&Up - Delete")
    DeleteBtn.OnEvent("Click", (*) => HandleGuiAction("delete"))

    SkipBtn := FileGui.Add("Button", "x+15 w100 h35", "&Home - Skip")
    SkipBtn.OnEvent("Click", (*) => HandleGuiAction("skip"))

    ; Instructions
    FileGui.Add("Text", "xm w400 Center c0x666666", "Use PgUp/PgDn/Home keys or click buttons | Del key shows info").SetFont(
        "s8")

    ; Show GUI in center of screen
    FileGui.Show("w430 h220")

    ; Set focus to Move button by default
    MoveBtn.Focus()

    return FileGui
}

CloseFileGui(*) {
    global
    if (FileGui) {
        try {
            FileGui.Close()
        }
        catch {
            ; GUI might already be closed
        }
        FileGui := ""
    }
}

HandleGuiAction(Action) {
    global
    CloseFileGui()

    if (WaitingForInput) {
        switch Action {
            case "move":
                IsProcessing := true
                WinClose("ahk_pid " CurrentFilePid)
                SetTimer MoveFile, -100
            case "delete":
                IsProcessing := true
                WinClose("ahk_pid " CurrentFilePid)
                SetTimer DeleteFile, -100
            case "skip":
                CloseFile()
        }
    }
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
    CloseFileGui() ; Close GUI first

    if (PrevFilePath != "" && FileExist(PrevFilePath)) {
        try {
            FileDelete(PrevFilePath)
            ToolTip "File deleted: " . GetFileName(PrevFilePath)
            SetTimer RemoveToolTip, -2000
        }
        catch as e {
            ToolTip "Error deleting file: " . e.Message
            SetTimer RemoveToolTip, -3000
        }
    }
    IsProcessing := false
    WaitingForInput := false
    if (CurrentFileObj)
        CurrentFileObj.Close()
}

MoveFile() {
    global
    CloseFileGui() ; Close GUI first

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
    WaitingForInput := false
    if (CurrentFileObj)
        CurrentFileObj.Close()
}

CloseFile() {
    global
    CloseFileGui() ; Close GUI first

    WinClose("ahk_pid " CurrentFilePid)
    if (CurrentFileObj) {
        CurrentFileObj.Close()
        CurrentFileObj := ""
    }
    WaitingForInput := false
    ToolTip "File skipped"
    SetTimer RemoveToolTip, -1000
}

GetFileName(FullPath) {
    loop parse FullPath, '\' {
        FileName := A_LoopField
    }
    return FileName
}

ShowFileInfo() {
    global
    ; Display file info using GUI instead of tooltip
    if (WaitingForInput && CurrentFileObj) {
        FileName := GetFileName(PrevFilePath)

        ; Format file size string
        FileSizeStr := ""
        if (FileSizeMB >= 1000) {
            FileSizeGB := FileSizeMB / 1024
            FileSizeStr := Round(FileSizeGB, 2) . " GB"
        } else {
            FileSizeStr := Round(FileSizeMB, 1) . " MB"
        }

        ; Create and show the file details GUI
        CreateFileDetailsGui(FileName, PrevFilePath, FileSizeStr, FileCount, RemainingFiles)

        ; Activate the file window
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

    try {
        ; Try to open the file
        Run(FilePath, , , &CurrentFilePid)
        Sleep(1000) ; Give time for the file to open
        WinActivate("ahk_pid " CurrentFilePid)

        WaitingForInput := true
        PrevFilePath := FilePath

        ; Show the GUI automatically
        ShowFileInfo()

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

    ToolTip "Initializing file list..."
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
    }

    ; Wait for any processing to complete
    while (IsProcessing) {
        Sleep(100)
    }

    ToolTip "Processing complete!"
    SetTimer RemoveToolTip, -3000
    Sleep(3000)
    ExitApp
}

; Hotkey implementations - Using your preferred keys

Delete:: ShowFileInfo()

PgUp:: {
    global
    if (WaitingForInput) {
        IsProcessing := true
        WinClose("ahk_pid " CurrentFilePid)
        SetTimer DeleteFile, -2000
    }
}

PgDn:: {
    global
    if (WaitingForInput) {
        IsProcessing := true
        WinClose("ahk_pid " CurrentFilePid)
        SetTimer MoveFile, -2000
    }
}

Home:: {
    global
    if (WaitingForInput) {
        CloseFile()
    }
}

^Esc:: ExitApp

; Start the main process
Main()