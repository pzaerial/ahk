^c:: break++
^x::

break := -1

//BEFORE pressing hotkey bring window to focus
mousegetpos, w1mx, w1my, w1id
wingettitle, w1title, ahk_id %w1id%

while break < 0 {
	Send, {Shift Down}
	Click, %w1mx% %w1my%
	Send, {Shift Up}
	Sleep 250
	Send, {Shift Down}
	Click, 1209 460
	Send, {Shift Up}
	Sleep 250
}
