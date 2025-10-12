^c:: break++
^x::

break := -1

; Timings
; Water Pickup - 4000ms 

lastAfkResetTime := A_TickCount

while break < 0 {
	Random, sleepTime, 80, 120
	sleep sleepTime
	Send, f

	curTime := A_TickCount
	elapsedTime := curtime - lastAfkResetTime
	Random, sleepTime, 300000, 600000
	if(elapsedTime > sleepTime){
		; afk kick prevention with wasd
		Random, fwdBackSleepTime1, 50, 100
		Random, leftRightSleepTime1, 25, 75
		Random, fwdBackSleepTime2, 50, 100
		Random, leftRightSleepTime2, 25, 75
		Send, {w down}
		sleep fwdBackSleepTime1
		Send, {d down}
		sleep leftRightSleepTime1
		Send, {w up}
		sleep fwdBackSleepTime2
		Send, {d up}
		sleep leftRightSleepTime2
		Send, {s down}
		sleep fwdBackSleepTime1
		Send, {a down}
		sleep leftRightSleepTime1
		Send, {s up}
		sleep fwdBackSleepTime2
		Send, {a up}
		sleep leftRightSleepTime2
		lastAfkResetTime := A_TickCount
	}
}

