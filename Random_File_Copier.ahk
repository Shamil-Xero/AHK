#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "H:\Backup\F\Sorted"
global DestinationFolder := "F:\Sync\.Delete"
global FileList := []
global TotalFiles := 0
global FileCount := 0
global CurrentFileObj := ""

RemoveToolTip() {
    ; ToolTip ""
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

GetFileName(FullPath) {
    loop parse FullPath, '\' {
        FileName := A_LoopField
    }
    return FileName
}

CopyFile(TheFile) {
    global
    if (TheFile == "" || !FileExist(TheFile)) {
        ; ToolTip "File doesn't exist or path is empty"
        ; SetTimer RemoveToolTip, -2000
        return false
    }

    FileName := GetFileName(TheFile)
    
    try {
        ; Get file size for display
        CurrentFileObj := FileOpen(TheFile, "r")
        FileSizeMB := CurrentFileObj.Length / 1048576
        
        ; Display file info
        if (FileSizeMB >= 1000) {
            FileSizeGB := FileSizeMB / 1024
            ; ToolTip FileName . "`nFile Size: " . Round(FileSizeGB, 2) . " GB`nCopying..."
        } else {
            ; ToolTip FileName . "`nFile Size: " . Round(FileSizeMB, 1) . " MB`nCopying..."
        }
        
        ; Create destination directory if it doesn't exist
        DirCreate DestinationFolder
        
        ; Copy file using AutoHotkey's native FileCopy
        FileCopy TheFile, DestinationFolder "\" FileName
        
        ; ToolTip "Copied: " . FileName
        ; SetTimer RemoveToolTip, -1500
        
        return true
    }
    catch as e {
        ; ToolTip "Error copying file: " . e.Message
        ; SetTimer RemoveToolTip, -3000
        return false
    }
    finally {
        if (CurrentFileObj) {
            CurrentFileObj.Close()
            CurrentFileObj := ""
        }
    }
}

Main() {
    global

    ; ToolTip "Initializing file list..."
    InitializeFileList()

    if (TotalFiles == 0) {
        ; ToolTip "No Files Found in: " . SourceFolder
        ; SetTimer RemoveToolTip, -3000
        return
    }

    FileCount := GetFileCount()

    if (FileCount > TotalFiles) {
        FileCount := TotalFiles
    }

    ; ToolTip "Starting processing of " . FileCount . " files..."
    ; SetTimer RemoveToolTip, -2000
    ; Sleep(2000)

    loop FileCount {
        FilePath := GetRandomFileName()
        if (FilePath == "") {
            ; ToolTip "No more files available"
            ; SetTimer RemoveToolTip, -2000
            break
        }

        CopyFile(FilePath)
        Sleep(500) ; Brief pause between files
    }

    ToolTip "Processing complete!"
    SetTimer RemoveToolTip, -1000
    Sleep(1000)
    ExitApp
}

^Esc:: ExitApp

; Start the main process
Main()