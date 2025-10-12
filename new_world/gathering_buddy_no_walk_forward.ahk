SetWorkingDir,%A_ScriptDir%

^c:: break++
^z::
^x::

break := -1
lastAfkTime := A_TickCount

while break < 0 {

	; press f for item pickup.
	Send, f

	; if harvesting tool is being used, wait until it has stopped being used 
	while IsGatheringToolBeingUsed() == 1 {
		Sleep 50 
	}

	;Anti afk after 5 mins.
	now := A_TickCount
	elapsed := now - lastAfkTime
	Random, randomSleepTime, 300000, 360000
	if(randomSleepTime < elapsed){
		AntiAfkWASD()
		lastAfkTime := now
	}

	;Sleep for random amount of time.
	;Random, sleepTime, 50, 100
	Random, sleepTime, 5000, 10000 ;Between 5 and 10s for Ironwood trees.
	sleep %sleepTime%
}

AntiAfkWASD() {
	Random, fwdBackSleepTime1, 50, 100
	Random, leftRightSleepTime1, 25, 75
	Send, {w down}
	Sleep fwdBackSleepTime1
	Send, {w up}
	Sleep 500
	Send, {d down}
	Sleep leftRightSleepTime1
	Send, {d up}
	Sleep 500
	Send, {s down}
	Sleep fwdBackSleepTime1
	Send, {s up}
	Sleep 500
	Send, {a down}
	Sleep leftRightSleepTime1
	Send, {a up}
	Sleep 500
}

IsGatheringToolBeingUsed() {
	ImageSearch, sickleX, sickleY, 0, 0, A_ScreenWidth, A_ScreenHeight, gatheringToolHarvestingSickleOrichalcum.PNG
	ImageSearch, axeX, axeY, 0, 0, A_ScreenWidth, A_ScreenHeight, gatheringToolLoggingAxeOrichalcum.PNG
	ImageSearch, pickaxeX, pickaxeY, 0, 0, A_ScreenWidth, A_ScreenHeight, gatheringToolPickaxeOrichalcum.PNG
	ImageSearch, knifeX, knifeY, 0, 0, A_ScreenWidth, A_ScreenHeight, gatheringToolSkinningKnifeOrichalcum.PNG

	if(sickleX > 0 or axeX > 0 or pickaxeX > 0 or knifeX > 0){
   	    return 1
   	} else {
   		return 0
   	}
}
