^c:: break++
^x::

break := -1

while break < 0 {
	if(distance>=tolerance){
		Random, sleepTime, 500, 250
		sleep %sleepTime%
		MouseClick, left
	}
}
