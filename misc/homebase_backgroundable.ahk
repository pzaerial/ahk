; Ctrl + Z → Register active window
; Ctrl + X → Start main loop
; Ctrl + C → Stop main loop
; For alignment, zoom into the top left of the map, then use down arrow key to zoom out fully.

; ------------------------------------
; Global variables
; ------------------------------------
global windows := []
global is_running := false
global break_loop := false

; ------------------------------------
; Hotkeys
; ------------------------------------

; Ctrl + Z → Register active window
^z::
    if (is_running) {
        MsgBox, 48, Cannot Register, Cannot register new window while main loop is running.`n`nPress OK to continue or Stop main loop to stop.
        return
    }
    tryRegisterWindow()
return

; Ctrl + C → Stop main loop
^c::
    break_loop := true
    is_running := false
return

; Ctrl + X → Start main loop
^x::
    if (windows.Length() = 0) {
        MsgBox, 48, No Windows, No windows registered! Press Ctrl+Z to register windows first.
        return
    }

    if (is_running) {
        MsgBox, 48, Already Running, Main loop is already running!
        return
    }

    ; Atomically update state
    break_loop := false
    is_running := true

    num_windows := windows.Length()
    MsgBox, 64, Main Loop Started, Registered Windows: %num_windows%`n`nPress Ctrl + C to stop.

    ; Start the loop
    while (is_running && !break_loop) {
        sleep, 750  ; interval between multiplexed clicks

        Loop, % windows.Length() {
            win := windows[A_Index]
            win_id := win["win_id"]

            ; Reset UI and connect
            multiplex_control_click(win, "left", 1270/3440, 810/1440)
            sleep, 3000

            ClearUiElements(win)

            ; Click Start
            multiplex_control_click(win, "left", 600/3440, 1200/1440)
            sleep, 250

            ; Click Find
            multiplex_control_click(win, "left", 875/3440, 1025/1440)
            sleep, 250

            ; Click Attack
            multiplex_control_click(win, "left", 2450/3440, 1250/1440)
            sleep, 7500

            ; Deploy troops
            DeployZoomedOut(win)

            ; Wait for timer (1 min)
            sleep, 60000

            ; Client out of sync prompt
            multiplex_control_click(win, "left", 1300/3440, 800/1440)
            sleep, 250

            ; Surrender and Return
            multiplex_control_click(win, "left", 650/3440, 1050/1440)
            sleep, 250
            multiplex_control_click(win, "left", 1950/3440, 900/1440)
            sleep, 500
            multiplex_control_click(win, "left", 1700/3440, 1200/1440)
            sleep, 3000
        }
    }

    ; Ensure clean state when loop finishes
    break_loop := false
    is_running := false
return

; ------------------------------------
; Helper Functions
; ------------------------------------

multiplex_control_click(win, button, x_frac, y_frac) {
    CoordMode, Mouse, Screen
    win_id := win["win_id"]
    WinGetPos, winX, winY, winW, winH, ahk_id %win_id%
    clickX := winX + Round(x_frac * winW)
    clickY := winY + Round(y_frac * winH)

    ; Bring window to top
    WinActivate, ahk_id %win_id%
    ControlClick,, ahk_id %win_id%, , %button%, 1, NA x%clickX% y%clickY%
}

tryRegisterWindow() {
    global windows
    WinGet, active_id, ID, A
    WinGetTitle, active_title, ahk_id %active_id%

    result := show_window_registration_gui(active_title)
    if (result = "cancel") {
        MsgBox, 64, Cancelled, Window registration cancelled.
        return
    }

    win := {}
    win["win_id"] := active_id
    win["title"] := active_title
    win["number_of_troops"] := result["numberOfTroops"]
    win["number_of_heroes"] := result["numberOfHeroes"]
    win["castle_present"] := result["castlePresent"]

    windows.Push(win)

    MsgBox, 64, Success, Window "%active_title%" registered successfully.
}

show_window_registration_gui(title) {
    global
    static numberOfTroops, numberOfHeroes, castlePresent
    GuiSubmitted := false

    numberOfTroops := 2
    numberOfHeroes := 3
    castlePresent := 1

    Gui, New, +AlwaysOnTop, Register Window - %title%
    Gui, Add, Text,, Number of Troops:
    Gui, Add, Edit, vnumberOfTroops w100, %numberOfTroops%
    Gui, Add, Text,, Number of Heroes:
    Gui, Add, Edit, vnumberOfHeroes w100, %numberOfHeroes%
    Gui, Add, Text,, Castle Present? (1=yes, 0=no):
    Gui, Add, Edit, vcastlePresent w100, %castlePresent%
    Gui, Add, Button, Default gGuiOK, OK
    Gui, Add, Button, gGuiCancel, Cancel
    Gui, Show,, Window Settings - %title%

    while !GuiSubmitted
        Sleep, 50

    gui_result := {}
    gui_result["numberOfTroops"] := numberOfTroops
    gui_result["numberOfHeroes"] := numberOfHeroes
    gui_result["castlePresent"] := castlePresent
    return gui_result
}

GuiOK:
    Gui, Submit, NoHide
    GuiSubmitted := true
    Gui, Destroy
return

GuiCancel:
    GuiSubmitted := false
    Gui, Destroy
return

ClickOnLine(startX, startY, endX, endY, numClicks, win) {
    deltaX := endX - startX
    deltaY := endY - startY
    stepX := deltaX / (numClicks - 1)
    stepY := deltaY / (numClicks - 1)
    Loop, %numClicks% {
        currentX := startX + (stepX * (A_Index - 1))
        currentY := startY + (stepY * (A_Index - 1))
        multiplex_control_click(win, "left", currentX/3440, currentY/1440)
        sleep, 150
    }
}

ClearUiElements(win) {
    multiplex_control_click(win, "left", 2600/3440, 130/1440)
    sleep, 250
    multiplex_control_click(win, "left", 2700/3440, 100/1440)
    sleep, 250
    multiplex_control_click(win, "left", 1480/3440, 650/1440)
    sleep, 250
    multiplex_control_click(win, "left", 2650/3440, 120/1440)
    sleep, 250
    multiplex_control_click(win, "left", 2800/3440, 150/1440)
    sleep, 250
    multiplex_control_click(win, "left", 2860/3440, 400/1440)
    sleep, 250
    multiplex_control_click(win, "left", 2860/3440, 400/1440)
    sleep, 250
}

DeployZoomedOut(win) {
    win_numTroops := win["number_of_troops"]
    win_numHeroes := win["number_of_heroes"]
    win_castle := win["castle_present"]

    firstTroopCenterX := 760
    troopIconSize := 180
    deploymentBarBufferSize := 20

    Loop, %win_numTroops% {
        currentX := firstTroopCenterX + ((A_Index - 1) * troopIconSize)
        multiplex_control_click(win, "left", currentX/3440, 1250/1440)
        sleep, 50
        ClickOnLine(1480, 80, 790, 790, 8, win)
        sleep, 250
    }

    castleBaseLocation := firstTroopCenterX + (win_numTroops * troopIconSize) + deploymentBarBufferSize
    firstHeroLocation := win_castle ? castleBaseLocation + troopIconSize + deploymentBarBufferSize : castleBaseLocation
    Loop, %win_numHeroes% {
        heroOffset := (A_Index - 1) * troopIconSize
        multiplex_control_click(win, "left", (firstHeroLocation + heroOffset)/3440, 1250/1440)
        sleep, 50
        multiplex_control_click(win, "left", (1060 + ((A_Index - 1) * 10))/3440, (375 + ((A_Index - 1) * 3))/1440)
        sleep, 150
    }

    spellLocation := firstHeroLocation + (win_numHeroes * troopIconSize) + deploymentBarBufferSize
    multiplex_control_click(win, "left", spellLocation/3440, 1250/1440)
    sleep, 50
    ClickOnLine(1820, 370, 1480, 850, 5, win)
    sleep, 250
}
