^c:: break++
^x::

break := -1
iterations := 0
doDeployOption1 := 1
doDeployOption2 := 1

; Activate the current window (Just in case)
WinGet, activeWindow, ID, A
WinActivate, ahk_id %activeWindow%

sleep 1000

while break < 0 {

	; Reset after connecting from another device
	MouseClick, left, 1270, 810
	sleep 3000

	; Close any accidentally opened windows
	ClearUiElements()
	sleep 2000

	; Click Start
	MouseClick, left, 600, 1200
	sleep 250

	; Click Find
	MouseClick, left, 2400, 900
	sleep 7500

	; Deploy Part 1
	if (doDeployOption1) {
		; Select Option 1
		MouseClick, left, 800, 1200
		sleep 250
		; Deploy Option 1 (a few times to be sure)
		MouseClick, left, 550, 650
		sleep 250
		MouseClick, left, 550, 650
		sleep 250
		MouseClick, left, 550, 650
		sleep 250
		MouseClick, left, 550, 650
		sleep 250
	}

	; Deploy Part 2
	if (doDeployOption2) {
		; Select Option 2
		MouseClick, left, 1100, 1200
		sleep 250
		; Deployment 2 choice (do this multiple times in case of obstacles)
		DeploySemicircleFew()
        DeploySemicircleFew()
        DeploySemicircleFew()
	}

	; Wait for timer (1 min should be all we need)
	sleep 60000
	
	; Surrender and Return
	MouseClick, left, 650, 1050 ; This actually misses low, but it works for the 2 stage bases. Fix later.
	sleep 250
	MouseClick, left, 1950, 900
	sleep 500
	MouseClick, left, 1700, 1175
	sleep 3000

	; Track iterations
	iterations := iterations + 1
}

ClearUiElements() {
	; Clear any UI elements
	MouseClick, left, 2500, 120 ; Events window
	sleep 250
	MouseClick, left, 1480, 650 ; Chat
	sleep 250
	MouseClick, left, 2650, 120 ; Battle pass window
	sleep 250
	MouseClick, left, 2660, 230 ; Training window
	sleep 250

	; Clear any UI elements by clicking on dead space
	MouseClick, left, 2860, 500
	sleep 250
	MouseClick, left, 2860, 500
	sleep 250
}

DeploySemicircleFew() {
	MouseClick, left, 950, 1250
	sleep 250
	MouseClick, left, 1300, 80
	sleep 250

	MouseClick, left, 1150, 1250
	sleep 250
	MouseClick, left, 1050, 200
	sleep 250

	MouseClick, left, 1350, 1250
	sleep 250
	MouseClick, left, 900, 450
	sleep 250

	MouseClick, left, 1550, 1250
	sleep 250
	MouseClick, left, 900, 730
	sleep 250
	
	MouseClick, left, 1750, 1250
	sleep 250
	MouseClick, left, 950, 850
	sleep 250

	MouseClick, left, 1950, 1250
	sleep 250
	MouseClick, left, 1000, 925
	sleep 250

	MouseClick, left, 2150, 1250
	sleep 250
	MouseClick, left, 1000, 975
	sleep 250
}

DeploySemicircleMany() {
	MouseClick, left, 1600, 582
	sleep 250
	MouseClick, left, 1525, 510
	sleep 250
	MouseClick, left, 1570, 452
	sleep 250
	MouseClick, left, 1400, 400
	sleep 250
	MouseClick, left, 1300, 500
	sleep 250
	MouseClick, left, 1200, 600
	sleep 250
	MouseClick, left, 1290, 800
	sleep 250
	MouseClick, left, 1360, 900
	sleep 250
	MouseClick, left, 1400, 950
	sleep 250
	MouseClick, left, 1420, 1000
	sleep 250
	MouseClick, left, 1520, 1100
}

DeployTriads() {
	;todo
}

; Deploy Option 2 Smooth Line Top to Left
DeploySmoothLine() {
	MouseClick, left, 1500, 100
	sleep 250
	MouseClick, left, 1420, 150
	sleep 250
	MouseClick, left, 1360, 200
	sleep 250
	MouseClick, left, 1280, 250
	sleep 250
	MouseClick, left, 1200, 300
	sleep 250
	MouseClick, left, 1120, 350
	sleep 250
	MouseClick, left, 1040, 400
	sleep 250
	MouseClick, left, 960, 450
	sleep 250
	MouseClick, left, 880, 500
	sleep 250
	MouseClick, left, 800, 600
	sleep 250
}