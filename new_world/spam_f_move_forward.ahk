^c:: break++
^x::

break := -1
itors := 0

while break < 0 {
	Random, sleepTime, 500, 250
	sleep %sleepTime%
	Send, f
	itors := itors + 1

	; Start autorunning every 10 iterations.
	if(Mod(itors, 10) == 0){
		Send, {``}
	}

	; Jump to clear obstacles every 50 iterations.
	if(itors > 50){
		itors := 0
		Send, {SPACE}
	}
}
