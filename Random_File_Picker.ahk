#Requires AutoHotkey v2.0
#Include <Lib>

SourceFolder := "I:\Backup\F\Sort"
DestinationFolder := "I:\Backup\F"

FileList := Array()  ; Initialize to be blank.
fileCount := 0
loop files, SourceFolder "\*.*", "R" {
    fileCount++
    FileList.Push A_LoopFileFullPath
}

ib := InputBox("Enter the Number of Files`n(Total: " filecount ")", "Files", "w40 h120", "10")
if ib.Result = "Cancel"
    ExitApp
m := Integer(ib.value)

loop m {
    FileList := Array()  ; Initialize to be blank.
    fileCount := 0
    loop files, SourceFolder "\*.*", "R" {
        fileCount++
        FileList.Push A_LoopFileFullPath
    }

    filesleft := m - A_Index + 1
    n := Random(fileCount)
    SetTimer RemoveToolTip, -2000
    for TheFile in FileList {
        if (n == A_Index) {
            try {
                global FileObj := FileOpen(TheFile, "r")
                loop parse TheFile, '\' {
                    JustFileName := A_LoopField
                }
                ToolTip filesleft ". " JustFileName
                SetTimer RemoveToolTip, -2000
                RunWait(TheFile)
                global FileSizeMB := FileObj.Length / 1048576
                ; global Result := MsgBox("Move this file: " TheFile " (" Integer(FileSizeMB) " mb) ?", , "Y/N/C")
                global Result := MsgBox(JustFileName " (" Integer(FileSizeMB) " mb) ?", , "Y/N/C")
            }
            catch as e  ; Handles the first error thrown by the block above.
            {
                Result := "Cancel"
                ToolTip e.Message
                SetTimer RemoveToolTip, -2000
            }
            if (Result == "Yes") {
                DirCreate DestinationFolder
                Run 'cmd.exe /c move `"' TheFile "`" `"" DestinationFolder "`"", , "Hide"
            } else if (Result == "No") {
                FileDelete TheFile
            }
            else {
                break
            }
        }
    }

}

ToolTip "Done"
Sleep 1000
ExitApp

^Esc:: ExitApp
