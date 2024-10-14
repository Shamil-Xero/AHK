#Requires AutoHotkey v2.0
#Include <Lib>
; FolderSizeKB := 0
; WhichFolder := DirSelect()  ; Ask the user to pick a folder.
; loop files, WhichFolder "\*.*", "R"
;     FolderSizeKB += A_LoopFileSizeKB
; MsgBox "Size of " WhichFolder " is " FolderSizeKB " KB."

FileCount := 0
FileList := Array()  ; Initialize to be blank.
; SourceFolder := DirSelect()
; DestinationFolder := DirSelect()
SourceFolder := "G:\Backup\F\Wondershare UniConverter 15"
DestinationFolder := "D:\Movies"
m := InputBox("Enter the Number of Files", "Files", "w40 h100", "10").value
m := Integer(m)
c := 1

; Result := MsgBox("The chosen folder is: " SourceFolder, , "y/n")
loop files, SourceFolder "\*.*", "R" {
    FileCount := FileCount + 1
    FileList.Push A_LoopFileFullPath
}

loop m - 1 {
    for TheFile in FileList {
        n := Random(FileCount)
        if (n == A_Index) {
            ; Result := MsgBox("File number " A_Index " is " TheFile "  Continue?", , "y/n")
            ToolTip c
            sleep 1000
            FileMove TheFile, DestinationFolder, 1
            SetTimer RemoveToolTip, -200
            ; if Result == "n"
            ; break
        }
    }
    c++
}

ExitApp

; FileList := Sort(FileList, "R")  ; The R option sorts in reverse order. See Sort for other options.
; for TheFile in FileList {
;     ; FileMove A_LoopField, "F:\"
;     ; if Result = "No"
;     ;     break
; }

Esc:: ExitApp