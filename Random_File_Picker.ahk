#Requires AutoHotkey v2.0
#Include <Lib>

ib := InputBox("Enter the Number of Files", "Files", "w40 h100", "10")
if ib.Result = "Cancel"
    ExitApp
m := Integer(ib.value)

loop m {

    FileList := Array()  ; Initialize to be blank.
    SourceFolder := "D:\Movies"
    DestinationFolder := "E:\Movies"

    fileCount := 0
    loop files, SourceFolder "\*.*", "R" {
        fileCount++
        FileList.Push A_LoopFileFullPath
    }

    n := Random(fileCount) 
    ToolTip m-A_Index+1
    SetTimer RemoveToolTip, -2000
    for TheFile in FileList {
        if (n == A_Index) {
            try {
                global FileObj := FileOpen(TheFile, "r")
                RunWait(TheFile)
                Loop Parse TheFile, '\'{
                    JustFileName := A_LoopField
                }
                global FileSizeMB := FileObj.Length/1048576
                global Result := MsgBox("Move this file: " TheFile " (" Integer(FileSizeMB) " mb) ?", , "Y/N/C")
            }
            catch as e  ; Handles the first error thrown by the block above.
            {
                Result := "Cancel"
                ToolTip e.Message
                SetTimer RemoveToolTip, -2000
            }
            if (Result == "Yes") {
                Run 'cmd.exe /c move `"' TheFile "`" `"" DestinationFolder "`"" , , "Hide"
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
