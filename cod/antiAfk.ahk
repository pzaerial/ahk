^c:: ExitApp
^z:: break++
^x::
break := -1
isADS := 0
lastADSTime := 0
lastMove := 0
while break < 0 {

	if(!isADS) {
		MouseClick, left,,, 1, 0, D
		lastADSTime := A_TickCount
		isADS := 1
	}

	Random, waitTime, 15000, 20000
	now := A_TickCount
	if(now - lastADSTime > waitTime) {
		MouseClick, left,,, 1, 0, U
		isADS := 0
	}

	now := A_TickCount
	Random, waitTime, 3000, 5000
	if(now - lastMove > waitTime) {
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

	lastMove := A_TickCount
	}
}
