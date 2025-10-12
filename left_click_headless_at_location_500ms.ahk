^c:: break++
^x::

break := -1

//BEFORE pressing hotkey bring window to focus
mousegetpos, w1mx, w1my, w1id
wingettitle, w1title, ahk_id %w1id%

while break < 0 {
	ControlClick,x%w1mx% y%w1my%,ahk_id %w1id%,,LEFT
	sleep 100
}
