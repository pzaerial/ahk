; Multi-window homebase automation script
; BS windows must not be sized such that there are black bars on the side.
; Ctrl+Z: Register window | Ctrl+X: Start loop | Ctrl+C: Break

; Use absolute coordinates (based on active display)
CoordMode, Mouse, Screen

break := -1
registeredWindows := []
menuBarOffset := 30

; Fixed layout values (as fractions of 2415x1440)
firstTroopCenterX := 250/2415
troopIconSize := 180/2415
deploymentBarBufferSize := 20/2415

tempWinId := ""
tempWinName := ""
tempWinX := 0
tempWinY := 0
tempWinW := 0
tempWinH := 0

^c:: break++

^z::
    WinGet, tempWinId, ID, A
    WinGetTitle, tempWinName, A
    WinGetPos, tempWinX, tempWinY, tempWinW, tempWinH, A

    ; Check if window is already registered
    foundIndex := FindRegisteredWindow(tempWinId)
    if (foundIndex > 0) {
        MsgBox, 4, Unregister Window, Window "%tempWinName%" is already registered.`n`nDo you want to unregister it?
        IfMsgBox Yes
        {
            registeredWindows.RemoveAt(foundIndex)
        }
        return
    }

    ShowRegisterGui()
return

^x::
    windowCount := registeredWindows.Length()
    if (windowCount = 0) {
        MsgBox, No windows registered! Press Ctrl+Z on each window first.
        return
    }
    break := 0
    MainLoop()
return

ShowRegisterGui() {
    global tempWinName, tempWinW, tempWinH

    numTroops := 2
    hasCastle := 1
    deployCastle := 1
    numHero := 4
    numSpell := 11

    Gui, Register:New, , Register Window
    Gui, Register:Add, Text, , Window: %tempWinName%
    Gui, Register:Add, Text, , Size: %tempWinW% x %tempWinH%
    Gui, Register:Add, Text, w200, ---------------------------------
    Gui, Register:Add, Text, , Number of Troops:
    Gui, Register:Add, Edit, vNumTroopsInput w100, %numTroops%
    Gui, Register:Add, Text, , Has Castle (0/1):
    Gui, Register:Add, Edit, vHasCastleInput w100, %hasCastle%
    Gui, Register:Add, Text, , Deploy Castle (0/1):
    Gui, Register:Add, Edit, vDeployCastleInput w100, %deployCastle%
    Gui, Register:Add, Text, , Number of Heroes:
    Gui, Register:Add, Edit, vNumHeroInput w100, %numHero%
    Gui, Register:Add, Text, , Number of Spells:
    Gui, Register:Add, Edit, vNumSpellInput w100, %numSpell%
    Gui, Register:Add, Button, Default gRegisterSubmit w100, OK
    Gui, Register:Add, Button, gRegisterCancel x+10 w100, Cancel
    Gui, Register:Show
}

RegisterSubmit:
    Gui, Register:Submit
    windowData := {id: tempWinId, name: tempWinName, x: tempWinX, y: tempWinY, width: tempWinW, height: tempWinH, numTroops: NumTroopsInput, hasCastle: HasCastleInput, deployCastle: DeployCastleInput, numHero: NumHeroInput, numSpell: NumSpellInput}
    registeredWindows.Push(windowData)
return

RegisterCancel:
RegisterGuiClose:
    Gui, Register:Destroy
return

FindRegisteredWindow(winId) {
    global registeredWindows
    for index, winData in registeredWindows {
        if (winData.id = winId)
            return index
    }
    return 0
}

; Converts fractional coords (e.g., 750/2415) to absolute screen coords with menu bar offset
ToAbsoluteCoords(winData, fracX, fracY) {
    global menuBarOffset
    absX := winData.x + (fracX * winData.width)
    absY := winData.y + (fracY * winData.height) + menuBarOffset
    return {x: absX, y: absY}
}

MainLoop() {
    global break, registeredWindows

    while (break = 0) {
        for index, winData in registeredWindows {
            if (break != 0)
                break
            HomeBaseLoop(winData)
        }

        ; Buffer for battle timers if looping through each window doesn't take long enough.
        ; 60000 for single instance, for 4+ instances don't sleep
        ; sleep 60000
    }
}

HomeBaseLoop(winData) {
    ; Activate Window
    WinActivate, % "ahk_id " . winData.id
    sleep 250
    centerX := winData.x + (winData.width / 2)
    centerY := winData.y + (winData.height / 2)
    MouseClick, left, centerX, centerY
    sleep 50

    ; Game Loop
    ReturnHome(winData)
    ClearUI(winData)
    SearchMatch(winData)
    Deploy(winData)
    Deploy(winData)
}

ClearUI(winData) {
	global menuBarOffset

    ; 1s buffer to click between iterations
	sleep 500

	; Reset after connecting from another device
	coords := ToAbsoluteCoords(winData, 790/2415, 800/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

	; Close Profile/League window
	coords := ToAbsoluteCoords(winData, 2100/2415, 142/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50

	; Close Battle Window
	coords := ToAbsoluteCoords(winData, 2220/2415, 100/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50

	; Close Chat
	coords := ToAbsoluteCoords(winData, 990/2415, 650/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50

	; Close Battle pass window
	coords := ToAbsoluteCoords(winData, 2140/2415, 115/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50

	; Close Training window
	coords := ToAbsoluteCoords(winData, 2330/2415, 150/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50

	; Clear any remaining UI elements by clicking on dead space
	coords := ToAbsoluteCoords(winData, 2400/2415, 400/1440)
	MouseClick, left, coords.x, coords.y
	sleep 50
	MouseClick, left, coords.x, coords.y
	sleep 50
}

SearchMatch(winData) {
	; Click Start
	coords := ToAbsoluteCoords(winData, 150/2415, 1200/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250

	; Click Find
	coords := ToAbsoluteCoords(winData, 400/2415, 1025/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250

	; Click Attack
	coords := ToAbsoluteCoords(winData, 2130/2415, 1250/1440)
	MouseClick, left, coords.x, coords.y
	sleep 4000
}

; Deploy at edge of map, spread out, from the furthest zoomed out state.
Deploy(winData) {
	global menuBarOffset, firstTroopCenterX, troopIconSize, deploymentBarBufferSize

	numTroops := winData.numTroops
	numHeroes := winData.numHero
	hasCastle := winData.hasCastle
	deployCastle := winData.deployCastle
	numSpells := winData.numSpell

	Loop, %numTroops%
    {
        ; Calculate the X position of the current troop icon
        currentTroopX := firstTroopCenterX + ((A_Index - 1) * troopIconSize)

        coords := ToAbsoluteCoords(winData, currentTroopX, 1250/1440)
        MouseClick, left, coords.x, coords.y
        sleep 50

        ClickOnLine(winData, 1050/2415, 40/1440, 240/2415, 715/1440, 8)
        sleep 50
    }

	; Figure out CC Location, accounting for slight offset.
	castleBaseLocation := firstTroopCenterX + (numTroops * troopIconSize) + deploymentBarBufferSize

	; Deploy Castle at midpoint of hero deployment line
	if (hasCastle && deployCastle) {
		coords := ToAbsoluteCoords(winData, castleBaseLocation, 1250/1440)
		MouseClick, left, coords.x, coords.y
		sleep 50
		coords := ToAbsoluteCoords(winData, 630/2415, 381/1440)
		MouseClick, left, coords.x, coords.y
		sleep 50
	}

	; Heroic/Special
    firstHeroLocation := hasCastle ? castleBaseLocation + troopIconSize + deploymentBarBufferSize : castleBaseLocation
    Loop, %numHeroes%
    {
        heroOffset := (A_Index - 1) * troopIconSize
        coords := ToAbsoluteCoords(winData, firstHeroLocation + heroOffset, 1250/1440)
        MouseClick, left, coords.x, coords.y
        sleep 50
        coords := ToAbsoluteCoords(winData, 630/2415 + ((A_Index - 1) * 10/2415), 375/1440 + ((A_Index - 1) * 3/1440))
        MouseClick, left, coords.x, coords.y
        sleep 50
    }


	; Cast all spells in the first spell slot, based on offset from heroes.
	spellLocation := firstHeroLocation + (numHeroes * troopIconSize) + deploymentBarBufferSize
    coords := ToAbsoluteCoords(winData, spellLocation, 1250/1440)
    MouseClick, left, coords.x, coords.y
    sleep 50
	spellsPerLine := (numSpells / 2) + 1
    ClickOnLine(winData, 1390/2415, 490/1440, 975/2415, 890/1440, spellsPerLine)
    sleep 50
}

ReturnHome(winData) {
    ; Client Out of Sync Prompt
	coords := ToAbsoluteCoords(winData, 790/2415, 800/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

	; Surrender and Return
	coords := ToAbsoluteCoords(winData, 150/2415, 1050/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 1475/2415, 900/1440)
	MouseClick, left, coords.x, coords.y
	sleep 500
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
        sleep, 25
    }
}
