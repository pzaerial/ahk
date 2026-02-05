; Multi-window builder base automation script
; Ctrl+Z: Register window | Ctrl+X: Start loop | Ctrl+C: Break

CoordMode, Mouse, Screen

break := -1
registeredWindows := []
menuBarOffset := 30

; Fixed layout values (as fractions of 2415x1440)
firstHeroCenterX := 250/2415
troopIconSize := 170/2415
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

    heroActive := 1
    numCamps := 6
    numReinforcementCamps := 2

    Gui, Register:New, , Register Window
    Gui, Register:Add, Text, , Window: %tempWinName%
    Gui, Register:Add, Text, , Size: %tempWinW% x %tempWinH%
    Gui, Register:Add, Text, w200, ---------------------------------
    Gui, Register:Add, Text, , Hero Active (0/1):
    Gui, Register:Add, Edit, vHeroActiveInput w100, %heroActive%
    Gui, Register:Add, Text, , Number of Camps:
    Gui, Register:Add, Edit, vNumCampsInput w100, %numCamps%
    Gui, Register:Add, Text, , Number of Reinforcement Camps:
    Gui, Register:Add, Edit, vNumReinforcementCampsInput w100, %numReinforcementCamps%
    Gui, Register:Add, Button, Default gRegisterSubmit w100, OK
    Gui, Register:Add, Button, gRegisterCancel x+10 w100, Cancel
    Gui, Register:Show
}

RegisterSubmit:
    Gui, Register:Submit
    windowData := {id: tempWinId, name: tempWinName, x: tempWinX, y: tempWinY, width: tempWinW, height: tempWinH, heroActive: HeroActiveInput, numCamps: NumCampsInput, numReinforcementCamps: NumReinforcementCampsInput}
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

        ; Return home on all and queue/start battle 1
        for index, winData in registeredWindows {
            if (break != 0)
                break
            ActivateWindow(winData)
            ReturnHome(winData)
            ClearUI(winData)
            SearchMatch(winData)
            Deploy(winData)
            Deploy(winData)
        }

        ; Phase 1 battle buffer timer if deployment on all does not take long enough.
        ; sleep 45000 

        ; Start battle 2 on all
        for index, winData in registeredWindows {
            if (break != 0)
                break
            ActivateWindow(winData)
            Deploy(winData)
            Deploy(winData)
        }

        ; Phase 2 battle buffer timer if not running on multiple windows.
        ; sleep 45000
    }
}

ActivateWindow(winData) {
    ; Activate Window
    WinActivate, % "ahk_id " . winData.id
    sleep 250
    centerX := winData.x + (winData.width / 2)
    centerY := winData.y + (winData.height / 2)
    MouseClick, left, centerX, centerY
    sleep 50
}

ClearUI(winData) {
	; Clear any UI elements

	coords := ToAbsoluteCoords(winData, 2110/2415, 140/1440) ; Clear Profile window
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 2090/2415, 180/1440) ; Clear League window
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 980/2415, 650/1440) ; Clear Chat
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 1960/2415, 160/1440) ; Clear Defense Log window
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 2170/2415, 230/1440) ; Clear Army window
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 2150/2415, 120/1440) ; Clear Battle pass window
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 1990/2415, 130/1440) ; Clear Events window
	MouseClick, left, coords.x, coords.y
	sleep 250

	; Clear any remaining UI elements by clicking on dead space
	coords := ToAbsoluteCoords(winData, 2360/2415, 200/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250
	MouseClick, left, coords.x, coords.y
	sleep 250
}

SearchMatch(winData) {
	; Click Start
	coords := ToAbsoluteCoords(winData, 150/2415, 1200/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250

	; Click Find
	coords := ToAbsoluteCoords(winData, 1775/2415, 925/1440)
	MouseClick, left, coords.x, coords.y
	sleep 4000
}

Deploy(winData) {
	global firstHeroCenterX, troopIconSize, deploymentBarBufferSize

	heroActive := winData.heroActive
	numCamps := winData.numCamps
	numReinforcementCamps := winData.numReinforcementCamps
	totalCamps := numCamps + numReinforcementCamps

	; Hero
	if (heroActive) {
		coords := ToAbsoluteCoords(winData, firstHeroCenterX, 1250/1440)
		MouseClick, left, coords.x, coords.y
		sleep 50
		coords := ToAbsoluteCoords(winData, 50/2415, 750/1440)
		MouseClick, left, coords.x, coords.y
		sleep 250
	}

	; Select Troops
	troopStartX := firstHeroCenterX + troopIconSize + deploymentBarBufferSize
	troopEndX := troopStartX + (totalCamps * troopIconSize)
	ClickOnLine(winData, troopStartX, 1250/1440, troopEndX, 1250/1440, totalCamps, 1)
	sleep 50

	; Deploy in 2 lines
	lineClicks := Ceil((totalCamps) / 2)
	ClickOnLine(winData, 270/2415, 245/1440, 970/2415, 65/1440, lineClicks, 1)
	sleep 50
	ClickOnLine(winData, 1530/2415, 50/1440, 2180/2415, 420/1440, lineClicks, 1)
	sleep 50

	; Activate Troop Abilities
	ClickOnLine(winData, troopStartX, 1250/1440, troopEndX, 1250/1440, totalCamps, 2)
}

ReturnHome(winData) {
    ; Client Out of Sync Prompt
	coords := ToAbsoluteCoords(winData, 790/2415, 800/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

	; Surrender and Return
	coords := ToAbsoluteCoords(winData, 200/2415, 980/1440)
	MouseClick, left, coords.x, coords.y
	sleep 250
	coords := ToAbsoluteCoords(winData, 1475/2415, 900/1440)
	MouseClick, left, coords.x, coords.y
	sleep 500
	coords := ToAbsoluteCoords(winData, 1200/2415, 1180/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000

    ; Star Bonus
	coords := ToAbsoluteCoords(winData, 1200/2415, 1080/1440)
	MouseClick, left, coords.x, coords.y
	sleep 2000
}

ClickOnLine(winData, startFracX, startFracY, endFracX, endFracY, numClicks, clicksPerStop) {
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

        ; Click the current position clicksPerStop times.
        coords := ToAbsoluteCoords(winData, currentFracX, currentFracY)
		Loop, %clicksPerStop% {
        	MouseClick, left, coords.x, coords.y
        	sleep, 50
		}

        ; Add delay between clicks (adjust if necessary)
        sleep, 50
    }
}