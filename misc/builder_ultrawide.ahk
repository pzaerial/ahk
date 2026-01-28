; For use with a single troop army.
; Start zoomed in somewhere in the top left half of the map
;  then zoom out by using down key on keyboard for alignment purposes.

^c:: break++
^x::

; Variables 
break := -1

; REQUIRED VARIABLES
numberOfCamps := 6 ;INCLUDING REINFORCEMENT CAMP

; Activate the current window (Just in case)
WinGet, activeWindow, ID, A
WinActivate, ahk_id %activeWindow%

while break < 0 {

	; 5s buffer to click between iterations
	sleep 5000

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

	DeployDefaultZoom()
	sleep 2000
	DeployDefaultZoom()

	; Wait for timer (1 min should be all we need to finish first stage of base.)
	sleep 60000
	
	; Surrender and Return
	MouseClick, left, 630, 1050
	sleep 250
	MouseClick, left, 1950, 900
	sleep 500
	MouseClick, left, 1700, 1200
	sleep 3000
}

ClearUiElements() {
	; Clear any UI elements
	
	MouseClick, left, 2610, 140 ; Profile window
	sleep 250
	MouseClick, left, 2590, 180 ; League window
	sleep 250
	MouseClick, left, 1480, 650 ; Chat
	sleep 250
	MouseClick, left, 2460, 160 ; Defense Log window
	sleep 250
	MouseClick, left, 2670, 230 ; Army window
	sleep 250
	MouseClick, left, 2650, 120 ; Battle pass window
	sleep 250
	MouseClick, left, 2500, 120 ; Events window
	sleep 250

	; Clear any UI elements by clicking on dead space
	MouseClick, left, 2860, 200
	sleep 250
	MouseClick, left, 2860, 200
	sleep 250
}

DeployDefaultZoom() {
	; Global definitions
	global numberOfCamps

	; Hero 
	MouseClick, left, 735, 1250
    sleep 50
	MouseClick, left, 550, 830
    sleep 250

	; Troops 
	MouseClick, left, 950, 1250
    sleep 50
    ClickOnLine(1390, 90, 790, 790, numberOfCamps, 1)
    sleep 250

	; Troop Abilities
	startX := 950
	endX := startX + ((numberOfCamps - 1) * 200)
    ClickOnLine(startX, 1250, endX, 1250, numberOfCamps, 2)
	
}

ClickOnLine(startX, startY, endX, endY, numClicks, clicksPerStop) {
    ; Calculate the differences between the start and end points
    deltaX := endX - startX
    deltaY := endY - startY
    
    ; Calculate step sizes
    stepX := deltaX / (numClicks - 1)
    stepY := deltaY / (numClicks - 1)

    ; Perform the clicks at each point along the line
    Loop, %numClicks% {
        ; Calculate the current click position
        currentX := startX + (stepX * (A_Index - 1))
        currentY := startY + (stepY * (A_Index - 1))

        ; Click the current position clicksPerStop times.
		Loop, %clicksPerStop% {
        	MouseClick, left, currentX, currentY
        	sleep, 150
		}
        
        ; Add delay between clicks (adjust if necessary)
        sleep, 150
    }
}