#Requires AutoHotkey v2.0

; FolderSizeKB := 0
; WhichFolder := DirSelect()  ; Ask the user to pick a folder.
; loop files, WhichFolder "\*.*", "R"
;     FolderSizeKB += A_LoopFileSizeKB
; MsgBox "Size of " WhichFolder " is " FolderSizeKB " KB."

FileList := ""  ; Initialize to be blank.
Folder := DirSelect()
Result := MsgBox("The chosen folder is: " Folder, , "y/n")
loop files, Folder "\*.*", "R"
    FileList .= A_LoopFileFullPath "`n"
FileList := Sort(FileList, "R")  ; The R option sorts in reverse order. See Sort for other options.
loop parse, FileList, "`n" {
    if A_LoopField = ""  ; Ignore the blank item at the end of the list.
        continue
    FileMove A_LoopField, "F:\"
    ; Result := MsgBox("File number " A_Index " is " A_LoopField ".  Continue?", , "y/n")
    ; if Result = "No"
    ;     break
}
