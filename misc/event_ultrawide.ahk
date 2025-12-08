; For use with a single troop army. Uses a single event spell type if applicable.
; DO NOT have other troops or spells, or you will have to adjust troopIconSize and firstTroopCenterX.
; Could have issues with CC spell, numbers are presented in the table WITHOUT the spell.
; CC or Siege required for spacing of bottom bar.
; Start zoomed in somewhere in the top left half of the map
;  then zoom out by using down key on keyboard for alignment purposes.

^c:: break++
^x::

; Variables
break := -1
iterations := 0

; REQUIRED VARIABLES 
numberOfHeroes := 3
castlePresent := 1  ; boolean
troopIconSize := 180
firstTroopCenterX := 750
deploymentBarBufferSize := 20 ; Size of the buffer between different troop types.

; REQUIRED VARIABLE TABLE
;   Level     troopIconSize      firstTroopCenterX    deploymentBarBufferSize
;    TH7           200                  ???                     ???
;    TH8           ???                  ???                     ???
;    TH9           ???                  ???                     ???
;    TH10          ???                  ???                     ???
;    TH11          180                  750                     20
;    TH12          ???                  ???                     ???
;    TH13          ???                  ???                     ???

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
	MouseClick, left, 875, 1025
	sleep 250

	; Click Attack
	MouseClick, left, 2450, 1250
	sleep 7500

	; ZoomOut()

	DeployZoomedOut()
	sleep 2000
	DeployZoomedOut()

	; Wait for timer (1 min is all that is necessary in most cases. Finishes with around 1:35 on the clock)
	sleep 60000

	; Client Out of Sync Prompt
	MouseClick, left, 1300, 800
	sleep 250

	; Surrender and Return
	MouseClick, left, 650, 1050
	sleep 250
	MouseClick, left, 1950, 900
	sleep 500
	MouseClick, left, 1700, 1200
	sleep 3000

	; Track iterations
	iterations := iterations + 1
}

ClearUiElements() {
	; Clear any UI elements
	MouseClick, left, 2600, 130 ; Profile/League window
	sleep 250
	MouseClick, left, 2700, 100 ; Battle Window
	sleep 250
	MouseClick, left, 1480, 650 ; Chat
	sleep 250
	MouseClick, left, 2650, 120 ; Battle pass window
	sleep 250
	MouseClick, left, 2800, 150 ; Training window
	sleep 250

	; Clear any UI elements by clicking on dead space
	MouseClick, left, 2860, 400
	sleep 250
	MouseClick, left, 2860, 400
	sleep 250
}

; Zoom all the way out using down arrow.
; For some reason this is BROKEN RIGHT NOW, so don't use it.
ZoomOut() {
	Loop, 15
	{
		SendInput Down
		sleep 50
	}
}

; Deploy at edge of map, spread out, from the furthest zoomed out state.
DeployZoomedOut() {
	; Global definitions
	global numberOfHeroes, castlePresent, troopIconSize, firstTroopCenterX, deploymentBarBufferSize

	; Event Troop 1 (x8)
	MouseClick, left, firstTroopCenterX, 1250
    sleep 50
    ClickOnLine(1480, 80, 790, 790, 8)
    sleep 250
	
	; Event Troop 2 (x4)
	MouseClick, left, firstTroopCenterX + troopIconSize, 1250
    sleep 50
    ClickOnLine(1480, 80, 790, 790, 4)
    sleep 250
	
	; Normal Troop 1 (x10)
	MouseClick, left, firstTroopCenterX + 2 * troopIconSize, 1250
    sleep 50
    ClickOnLine(1480, 80, 790, 790, 10)
    sleep 250

	; Figure out CC Location, accounting for slight offset.
	castleBaseLocation := firstTroopCenterX + (3 * troopIconSize) + deploymentBarBufferSize

	; Heroic/Special
    firstHeroLocation := castlePresent ? castleBaseLocation + troopIconSize + deploymentBarBufferSize : castleBaseLocation
    Loop, %numberOfHeroes%
    {
        heroOffset := (A_Index - 1) * troopIconSize
        MouseClick, left, firstHeroLocation + heroOffset, 1250
        sleep 50
        MouseClick, left, 1060 + ((A_Index - 1) * 10), 375 + ((A_Index - 1) * 3)
        sleep 150
    }


	; Spells (x5), location based on number of heroes.
	spellLocation := firstHeroLocation + (numberOfHeroes * troopIconSize) + deploymentBarBufferSize
    MouseClick, left, spellLocation, 1250
    sleep 50
    ClickOnLine(1820, 370, 1480, 850, 5)
    sleep 250
}

ClickOnLine(startX, startY, endX, endY, numClicks) {
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

        ; Click the current position
        MouseClick, left, currentX, currentY
        
        ; Add delay between clicks (adjust if necessary)
        sleep, 150
    }
}