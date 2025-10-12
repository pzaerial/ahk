; Show current mouse coords when Ctrl+X is pressed. 
; Make sure the window is in focus before you run this. And the popup must be closed before you can get another coordinates.

^c:: ExitApp
^x::
MouseGetPos, x, y
MsgBox, Mouse is at %x%, %y%.
return
