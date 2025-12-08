; For use with a single troop army. CC or Siege required for it to work because of spacing in bottom bar.
; Spells are ok.
; Start zoomed in somewhere in the top left half of the map
;  then zoom out by using down key on keyboard for alignment purposes.

^c:: break++
^x::

; Variables
break := -1
iterations := 0

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

	; Wait for timer (1 min is all that is necessary in most cases. Finishes with around 1:53 on the clock)
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
	; Mass of one big troop, spread out in a line.
	; Select them
	MouseClick, left, 750, 1250
	sleep 50
	; Deploy them
	MouseClick, left, 1480, 80
	sleep 150
	MouseClick, left, 1375, 154
	sleep 250
	MouseClick, left, 1270, 228
	sleep 150
	MouseClick, left, 1165, 302
	sleep 250
	MouseClick, left, 1060, 376
	sleep 150
	MouseClick, left, 955, 450
	sleep 250
	MouseClick, left, 850, 524
	sleep 150
	MouseClick, left, 745, 598
	sleep 250
	MouseClick, left, 750, 610
	sleep 150
	MouseClick, left, 790, 790
	sleep 250

	; Heroic/Special (assumes in 3rd-6th slots)
	; one
	MouseClick, left, 1140, 1270
	sleep 50
	MouseClick, left, 1060, 375
	sleep 250
	; two 
	MouseClick, left, 1340, 1270
	sleep 50
	MouseClick, left, 1050, 378
	sleep 150
	; three 
	MouseClick, left, 1540, 1270
	sleep 50
	MouseClick, left, 1076, 371
	sleep 250
	; four
	MouseClick, left, 1740, 1270
	sleep 50
	MouseClick, left, 1066, 378
	sleep 150
}