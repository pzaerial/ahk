running := false
max_itors := 100

; Hotkey to start the loop (Ctrl + X)
^x::{
    running := true
    itors := 0

    ToolTip("Starting script!")
    Sleep(2000)
    ToolTip()

    Sleep(1000)

    while (running && itors < max_itors) {
    	; Set Tooltip
        ToolTip("Itor  " (itors) "/" (max_itors))

        ; Open Truck
        MouseClick("left", 180, 837)
        Sleep(250)

        ; Click Send
        MouseClick("left", 1700, 1800)
        Sleep(250)

        ; Click Quick Craft Location 1 x2
        MouseClick("left", 1900, 1400)
        Sleep(250)
        MouseClick("left", 1900, 1400)
        Sleep(250)

        ; Click Quick Craft Location 2 x2
        MouseClick("left", 1900, 1600)
        Sleep(250)
        MouseClick("left", 1900, 1600)
        Sleep(250)

        ; Click Fast Forward x2
        MouseClick("left", 1750, 1775)
        Sleep(250)
        MouseClick("left", 1750, 1775)
        Sleep(250)

        ; Click Confirm
        MouseClick("left", 1750, 1800)
        Sleep(250)

        ; Click Choice x3
        MouseClick("left", 2550, 1900)
        Sleep(250)
        MouseClick("left", 2550, 1900)
        Sleep(250)
        MouseClick("left", 2550, 1900)
        Sleep(250)

        itors += 1

        ; Close Tooltip
        ToolTip()
    }
}
