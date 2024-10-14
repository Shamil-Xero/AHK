/*
SC := GetKeySC("Esc")
name := GetKeyName("sc" SC)
MsgBox SC,, "T2"
MsgBox name,, "T2"
*/
#Requires AutoHotkey v2.0
#SingleInstance force
Persistent
#include Lib\AutoHotInterception.ahk
TraySetIcon A_WorkingDir "`\keyboard.png"

AHI := AutoHotInterception()
keyboardId := AHI.GetKeyboardId(0x048D, 0xC986)
; keyboard1Id := AHI.GetKeyboardId(0x04F2, 0x0112)
cm1 := AHI.CreateContextManager(keyboardId)

#HotIf cm1.IsActive	; Start the #if block
::aaa::JACKPOT
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=:: {
	ToolTip("KEY DOWN EVENT @ " A_TickCount)
}


; 1 up::
; {
; 	ToolTip("KEY UP EVENT @ " A_TickCount)
; 	return
; }
#HotIf			; Close the #if block


F1::
F2::
F3::
F4::
; F5::
F6::
F7::
F8::
F9::
F10::
F11::
F12::
a::
b::
c::
d::
e::
f::
g::
h::
i::
j::
k::
l::
m::
n::
o::
p::
q::
r::
s::
t::
u::
v::
w::
x::
y::
z::
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
Numpad0::
NumpadAdd::
NumPadSub::
NumpadMult::
NumpadDiv::
Space::
Up::
Down::
Right::
Left:: Return


; c:: ToolTip "Bye"
