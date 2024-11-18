#Requires AutoHotkey v2.0
#SingleInstance Force


/:: {
    ; SendInput "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    SendInput "k"
    WinActivate(Current_Window)
} ;Send {Media_Play_Pause} ; Play/Pause


j:: ;go back by 15 seconds
{
    ; SendInput "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    SendInput "{Left}"
    WinActivate(Current_Window)
}

l:: ;go forward by 15 seconds
{
    ; SendInput "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    SendInput "{Right}"
    WinActivate(Current_Window)
}

,:: ;speed down
{
    ; SendInput "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    SendInput "s"
    WinActivate(Current_Window)
}

.:: ;speed up
{
    ; SendInput "{Media_Play_Pause}"
    Current_Window := WinGetTitle("A")
    WinActivate(" - YouTube - Brave")
    ; ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
    ; ControlClick, , A, , , , %" X" (conX + 1) " Y" (conY + 1)
    Sleep 10
    SendInput "d"
    WinActivate(Current_Window)
}