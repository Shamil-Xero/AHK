
#SingleInstance, Force
SetTitleMatchMode, 2
SetBatchLines,-1
SetWinDelay,-1

/:: ;Send {Media_Play_Pause} ; Play/Pause
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, k
WinActivate, % "AHK_ID" Current_Window
return


j:: ;go back by 15 seconds
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY, conW, conH, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, {Left}
WinActivate, % "AHK_ID" Current_Window
return

l:: ;go forward by 15 seconds
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY,,, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, {Right}
WinActivate, % "AHK_ID" Current_Window
return

,:: ;speed down
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY,,, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, s
WinActivate, % "AHK_ID" Current_Window
return

.:: ;speed up
WinGet, Current_Window, ID, A
WinActivate, - YouTube
ControlGetPos, conX, conY,,, Chrome_RenderWidgetHostHWND1, A
ControlClick,, A,,,, % " X" (conX+1) " Y" (conY+1)
Send, d
WinActivate, % "AHK_ID" Current_Window
return
