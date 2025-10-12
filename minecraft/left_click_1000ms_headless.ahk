^c:: break++
^x::

break := -1

sleep, 2000

//BEFORE pressing hotkey bring window to focus
mousegetpos, w1mx, w1my, w1id
wingettitle, w1title, ahk_id %w1id%

while break < 0 {
	ControlClick,,ahk_id %w1id%,,LEFT
	sleep 100
}
