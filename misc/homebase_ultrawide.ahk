; For use with a single troop army. Avoids using spells.
; DO NOT have other troops or spells, or you will have to adjust troopIconSize and firstTroopCenterX.
; Could have issues with CC spell, numbers are presented in the table WITHOUT the spell.
; CC or Siege required for spacing of bottom bar.
; Start zoomed in somewhere in the top left half of the map
;  then zoom out by using down key on keyboard for alignment purposes.

^c:: break++
^x::

; Variables
break := -1

; REQUIRED VARIABLES
numberOfTroops := 2
firstTroopCenterX := 580 ; 760
numberOfHeroes := 4
castlePresent := 1  ; boolean
deployCastle := 1 ; boolean
troopIconSize := 180
deploymentBarBufferSize := 20 ; Size of the buffer between different troop types.

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
	global numberOfTroops, numberOfHeroes, castlePresent, deployCastle, troopIconSize, firstTroopCenterX, deploymentBarBufferSize

	Loop, %numberOfTroops%
    {
        ; Calculate the X position of the current troop icon
        currentTroopX := firstTroopCenterX + ((A_Index - 1) * troopIconSize)
        
        MouseClick, left, currentTroopX, 1250
        sleep 50
        
        ClickOnLine(1480, 80, 790, 790, 8) 
        sleep 250
    }

	; Figure out CC Location, accounting for slight offset.
	castleBaseLocation := firstTroopCenterX + (numberOfTroops * troopIconSize) + deploymentBarBufferSize

	; Deploy Castle at midpoint of hero deployment line
	if (castlePresent && deployCastle) {
		MouseClick, left, castleBaseLocation, 1250
		sleep 50
		MouseClick, left, 1080, 381
		sleep 150
	}

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


	; Cast all spells in the first spell slot, based on offset from heroes.
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