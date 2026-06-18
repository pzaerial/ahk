; Single-window homebase automation script
; BS windows must not be sized such that there are black bars on the side, nor sidebar open.
; Avoid too many windows, as cpu/memory limits affect responsiveness.
; Ctrl+Z: Open settings | Ctrl+X: Start loop on active window | Ctrl+C: Break

; Use absolute coordinates (based on active display)
CoordMode, Mouse, Screen

break := -1

; Emulator top bar offset (in code, not user settings). Set to "bluestacks" or "mumu".
emulator := "mumu"
bluestacksOffset := 30
mumuOffset := 40
menuBarOffset := (emulator = "mumu") ? mumuOffset : bluestacksOffset

; Fixed layout values (as fractions of 2415x1440)
firstTroopCenterX := 250/2415
troopIconSize := 180/2415
deploymentBarBufferSize := 20/2415

; Configurable settings (defaults used unless overridden via Ctrl+Z settings window)
numTroops := 2
clicksPerTroop := 8
hasCastle := 1
deployCastle := 0
numHero := 4
numSpell := 11
sleepBetweenIterations := 20000

^c:: break++

^z::
    ShowSettingsGui()
return

^x::
    break := 0
    MainLoop()
return

ShowSettingsGui() {
    global numTroops, clicksPerTroop, hasCastle, deployCastle, numHero, numSpell, sleepBetweenIterations

    Gui, Settings:New, , Settings
    Gui, Settings:Add, Text, , Number of Troops:
    Gui, Settings:Add, Edit, vNumTroopsInput w100, %numTroops%
    Gui, Settings:Add, Text, , Clicks Per Troop:
    Gui, Settings:Add, Edit, vClicksPerTroopInput w100, %clicksPerTroop%
    Gui, Settings:Add, Text, , Has Castle (0/1):
    Gui, Settings:Add, Edit, vHasCastleInput w100, %hasCastle%
    Gui, Settings:Add, Text, , Deploy Castle (0/1):
    Gui, Settings:Add, Edit, vDeployCastleInput w100, %deployCastle%
    Gui, Settings:Add, Text, , Number of Heroes:
    Gui, Settings:Add, Edit, vNumHeroInput w100, %numHero%
    Gui, Settings:Add, Text, , Number of Spells:
    Gui, Settings:Add, Edit, vNumSpellInput w100, %numSpell%
    Gui, Settings:Add, Text, , Sleep Between Iterations (ms):
    Gui, Settings:Add, Edit, vSleepBetweenIterationsInput w100, %sleepBetweenIterations%
    Gui, Settings:Add, Button, Default gSettingsSubmit w100, OK
    Gui, Settings:Add, Button, gSettingsCancel x+10 w100, Cancel
    Gui, Settings:Show
}

SettingsSubmit:
    Gui, Settings:Submit
    numTroops := NumTroopsInput
    clicksPerTroop := ClicksPerTroopInput
    hasCastle := HasCastleInput
    deployCastle := DeployCastleInput
    numHero := NumHeroInput
    numSpell := NumSpellInput
    sleepBetweenIterations := SleepBetweenIterationsInput
    Gui, Settings:Destroy
return

SettingsCancel:
SettingsGuiClose:
    Gui, Settings:Destroy
return

; Converts fractional coords (e.g., 750/2415) to absolute screen coords.
; The top bar is the only border, so fractions map onto the game window
; (full height minus the top bar), then are offset past the top bar.
ToAbsoluteCoords(winData, fracX, fracY) {
    global menuBarOffset
    gameHeight := winData.height - menuBarOffset
    absX := winData.x + (fracX * winData.width)
    absY := winData.y + menuBarOffset + (fracY * gameHeight)
    return {x: absX, y: absY}
}

MainLoop() {
    global break

    ; Capture the currently active window to use for the duration of the loop
    WinGet, winId, ID, A
    WinGetPos, winX, winY, winW, winH, A
    winData := {id: winId, x: winX, y: winY, width: winW, height: winH}

    while (break = 0) {
        HomeBaseLoop(winData)
    }
}

; Activates a window, waits for focus, then refreshes its stored bounds in place.
ActivateWindow(winData) {
    WinActivate, % "ahk_id " . winData.id
    WinWaitActive, % "ahk_id " . winData.id, , 1
    WinGetPos, winX, winY, winW, winH, % "ahk_id " . winData.id
    if (winW != "") {
        winData.x := winX
        winData.y := winY
        winData.width := winW
        winData.height := winH
    }
    sleep 250
}

HomeBaseLoop(winData) {
    global sleepBetweenIterations

    ActivateWindow(winData)

    ; Game Loop
    ReturnHome(winData)
    ClearUI(winData)
    SearchMatch(winData)
    Deploy(winData)
    Deploy(winData)

    ; 2:48 left after deployment. Default 100000 (1:40) before continuing.
    sleep %sleepBetweenIterations%
}

ClearUI(winData) {
	global menuBarOffset

    ; 1s buffer to click between iterations
	sleep 700

	; Reset after connecting from another device
	coords := ToAbsoluteCoords(winData, 790/2415, 800/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

	; Close Profile/League window
	coords := ToAbsoluteCoords(winData, 2100/2415, 142/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150

	; Close Battle Window
	coords := ToAbsoluteCoords(winData, 2220/2415, 100/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150

	; Close Chat
	coords := ToAbsoluteCoords(winData, 990/2415, 650/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150

	; Close Battle pass window
	coords := ToAbsoluteCoords(winData, 2140/2415, 115/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150

	; Close Training window
	coords := ToAbsoluteCoords(winData, 2330/2415, 150/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150

	; Clear any remaining UI elements by clicking on dead space
	coords := ToAbsoluteCoords(winData, 2400/2415, 400/1440)
	MouseClick, left, coords.x, coords.y
	sleep 150
	MouseClick, left, coords.x, coords.y
	sleep 150
}

SearchMatch(winData) {
	; Click Start
	coords := ToAbsoluteCoords(winData, 150/2415, 1200/1440)
	MouseClick, left, coords.x, coords.y
	sleep 450

	; Click Find
	coords := ToAbsoluteCoords(winData, 400/2415, 1025/1440)
	MouseClick, left, coords.x, coords.y
	sleep 450

	; Click Attack
	coords := ToAbsoluteCoords(winData, 2130/2415, 1250/1440)
	MouseClick, left, coords.x, coords.y
	sleep 4000
}

; Deploy at edge of map, spread out, from the furthest zoomed out state.
Deploy(winData) {
	global menuBarOffset, firstTroopCenterX, troopIconSize, deploymentBarBufferSize
	global numTroops, clicksPerTroop, hasCastle, deployCastle, numHero, numSpell

	Loop, %numTroops%
    {
        ; Calculate the X position of the current troop icon
        currentTroopX := firstTroopCenterX + ((A_Index - 1) * troopIconSize)

        coords := ToAbsoluteCoords(winData, currentTroopX, 1250/1440)
        MouseClick, left, coords.x, coords.y
        sleep 150

        ClickOnLine(winData, 1050/2415, 40/1440, 240/2415, 715/1440, clicksPerTroop)
        sleep 150
    }

	; Figure out CC Location, accounting for slight offset.
	castleBaseLocation := firstTroopCenterX + (numTroops * troopIconSize) + deploymentBarBufferSize

	; Deploy Castle at midpoint of hero deployment line
	if (hasCastle && deployCastle) {
		coords := ToAbsoluteCoords(winData, castleBaseLocation, 1250/1440)
		MouseClick, left, coords.x, coords.y
		sleep 150
		coords := ToAbsoluteCoords(winData, 630/2415, 381/1440)
		MouseClick, left, coords.x, coords.y
		sleep 150
	}

	; Heroic/Special
    firstHeroLocation := hasCastle ? castleBaseLocation + troopIconSize + deploymentBarBufferSize : castleBaseLocation
    Loop, %numHero%
    {
        heroOffset := (A_Index - 1) * troopIconSize
        coords := ToAbsoluteCoords(winData, firstHeroLocation + heroOffset, 1250/1440)
        MouseClick, left, coords.x, coords.y
        sleep 150
        coords := ToAbsoluteCoords(winData, 630/2415 + ((A_Index - 1) * 10/2415), 375/1440 + ((A_Index - 1) * 3/1440))
        MouseClick, left, coords.x, coords.y
        sleep 150
    }


	; Cast all spells in the first spell slot, based on offset from heroes.
	spellLocation := firstHeroLocation + (numHero * troopIconSize) + deploymentBarBufferSize
    coords := ToAbsoluteCoords(winData, spellLocation, 1250/1440)
    MouseClick, left, coords.x, coords.y
    sleep 150
	spellsPerLine := (numSpell / 2) + 1
    ClickOnLine(winData, 1390/2415, 490/1440, 975/2415, 890/1440, spellsPerLine)
    sleep 150
}

ReturnHome(winData) {
    ; Client Out of Sync Prompt
	coords := ToAbsoluteCoords(winData, 790/2415, 800/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

	; Surrender and Return
	coords := ToAbsoluteCoords(winData, 150/2415, 1050/1440)
	MouseClick, left, coords.x, coords.y
	sleep 450
	coords := ToAbsoluteCoords(winData, 1475/2415, 900/1440)
	MouseClick, left, coords.x, coords.y
	sleep 700
	coords := ToAbsoluteCoords(winData, 1200/2415, 1200/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000
}

ClickOnLine(winData, startFracX, startFracY, endFracX, endFracY, numClicks) {
    ; Calculate the differences between the start and end points
    deltaX := endFracX - startFracX
    deltaY := endFracY - startFracY

    ; Calculate step sizes
    stepX := deltaX / (numClicks - 1)
    stepY := deltaY / (numClicks - 1)

    ; Perform the clicks at each point along the line
    Loop, %numClicks% {
        ; Calculate the current click position
        currentFracX := startFracX + (stepX * (A_Index - 1))
        currentFracY := startFracY + (stepY * (A_Index - 1))

        ; Click the current position
        coords := ToAbsoluteCoords(winData, currentFracX, currentFracY)
        MouseClick, left, coords.x, coords.y

        ; Add delay between clicks (adjust if necessary)
        sleep, 150
    }
}
