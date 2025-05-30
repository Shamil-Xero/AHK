#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "I:\Backup\F\To Sort"
global DestinationFolder := "I:\Backup\F\Sorted"
global FileList := []
global TotalFiles := 0
global CurrentIndex := 0
global Locked := 0
global FileCount := 0
global IsProcessing := false
global FilePath := ""
global PrevFilePath := ""

RemoveToolTip() {
    ToolTip ""
}

InitializeFileList() {
    global
    loop files, SourceFolder "\*.*", "R" {
        FileList.Push(A_LoopFileFullPath)
        TotalFiles++
    }
}

GetFileCount() {
    global
    ib := InputBox("Enter the Number of Files`n(Total: " TotalFiles ")", "Files", "w40 h120", "10")
    if ib.Result = "Cancel"
        ExitApp
    return Integer(ib.value)
}

GetRandomFile() {
    global
    if (TotalFiles == 0) {
        return ""
    }
    n := Random(1, TotalFiles)
    try {
        FilePath := FileList[n]
        FileList.RemoveAt(n)
    }
    return FilePath
}

DeleteFile() {
    global
    FileDelete(PrevFilePath)
    IsProcessing := false
}

MoveFile() {
    global
    DirCreate DestinationFolder
    Run 'cmd.exe /c move `"' PrevFilePath "`" `"" DestinationFolder "`"", , "Min"
    IsProcessing := false
}

ProcessFile() {
    global
    if !FileExist(FilePath) {
        ToolTip "File doesn't exist"
        return
    }
    loop parse FilePath, '\' {
        FileName := A_LoopField
    }
    ToolTip FileCount ". " FileName
    SetTimer RemoveToolTip, -1000
    try {
        RunWait(FilePath)
        FileObj := FileOpen(FilePath, "r")
        FileSizeMB := FileObj.Length / 1048576
        if (FileSizeMB >= 1000) {
            FileSizeGB := FileSizeMB / 1024
            Result := MsgBox(FileName "`n`n File Size: " Round(FileSizeGB, 2) " GB`n`nYes = Move the File`nNo = Delete the File",
            "Decide", "Y/N/C")
        } else {
            Result := MsgBox(FileName "`n`n File Size: " Integer(FileSizeMB) " MB`n`nYes = Move the File`nNo = Delete the File",
            "Decide", "Y/N/C")
        }
    }
    catch as e {
        Result := "Cancel"
        ToolTip e.Message
        SetTimer(RemoveToolTip, -1000)
    }
    if (Result == "Yes") {
        IsProcessing := true
        PrevFilePath := FilePath
        SetTimer(MoveFile, -1000)
        TotalFiles--
    }
    else if (Result == "No") {
        IsProcessing := true
        PrevFilePath := FilePath
        SetTimer(DeleteFile, -1000)
        TotalFiles--
    }
}

Main() {
    global

    InitializeFileList()
    if (TotalFiles == 0) {
        ToolTip "No Files Found..."
        SetTimer(RemoveToolTip, -2000)
        return
    }

    FileCount := GetFileCount()

    loop FileCount {
        TheFile := GetRandomFile()
        ProcessFile()
        FileCount--
    }

    while (IsProcessing) {
        Sleep 1000
    }
    ToolTip "Done"
    Sleep 1000
    ExitApp
}

Main()

^Esc:: ExitApp