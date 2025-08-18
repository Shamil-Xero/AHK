#Requires AutoHotkey v2.0
#SingleInstance Off

global SourceFolder := "J:\Backup\F\Sorted"
global DestinationFolder := "F:\Sync\.Delete"
global FileList := []
global TotalFiles := 0
global FileCount := 0
global CurrentFileObj := ""
global RandomList := []

RemoveToolTip() {
    ; ToolTip ""
}

InitializeFileList() {
    global
    FileList := []
    TotalFiles := 0
    loop files, SourceFolder "\\*.*", "R" {
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

BuildRandomList(count) {
    global
    local tempList := FileList.Clone()
    local randomList := []
    loop count {
        if (tempList.Length == 0)
            break
        n := Random(1, tempList.Length)
        randomList.Push(tempList[n])
        tempList.RemoveAt(n)
    }
    return randomList
}

GetFileName(FullPath) {
    loop parse FullPath, '\\' {
        FileName := A_LoopField
    }
    return FileName
}

CopyFile(TheFile) {
    global
    if (TheFile == "" || !FileExist(TheFile)) {
        return false
    }
    FileName := GetFileName(TheFile)
    try {
        DirCreate DestinationFolder
        FileCopy TheFile, DestinationFolder "\\" FileName
        return true
    }
    catch as e {
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
    InitializeFileList()
    if (TotalFiles == 0) {
        return
    }
    FileCount := GetFileCount()
    if (FileCount > TotalFiles) {
        FileCount := TotalFiles
    }
    RandomList := BuildRandomList(FileCount)
    for idx, filePath in RandomList {
        CopyFile(filePath)
        Sleep(500)
    }
    ToolTip "Processing complete!"
    SetTimer RemoveToolTip, -1000
    Sleep(1000)
    ExitApp
}

^Esc:: ExitApp

; Start the main process
Main()