running := false
max_itors := 100

^x::
Go:
    running := true
    itors := 0

    ToolTip, Starting script!
    Sleep, 2000
    ToolTip

    Sleep, 1000

    while (running && itors < max_itors) {
        ToolTip, % "Itor " itors "/" max_itors

        MouseClick, left, 180, 837
        Sleep, 250

        MouseClick, left, 1700, 1800
        Sleep, 250

        MouseClick, left, 1900, 1400
        Sleep, 250
        MouseClick, left, 1900, 1400
        Sleep, 250

        MouseClick, left, 1900, 1600
        Sleep, 250
        MouseClick, left, 1900, 1600
        Sleep, 250

        MouseClick, left, 1750, 1775
        Sleep, 250
        MouseClick, left, 1750, 1775
        Sleep, 250

        MouseClick, left, 1750, 1800
        Sleep, 250

        MouseClick, left, 2550, 1900
        Sleep, 250
        MouseClick, left, 2550, 1900
        Sleep, 250
        MouseClick, left, 2550, 1900
        Sleep, 250

        itors += 1

        ToolTip
    }
    Return