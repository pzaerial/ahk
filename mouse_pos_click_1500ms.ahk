; Press Ctrl+X to start clicking every 1.5s.
; Since we send controls to the window exactly, just switch focus to stop the script as other hotkey doesn't seem to work in v2.

shouldStop := 0
selectedWin := ""

^c:: shouldStop := 1

^x::
{
    ; Get the active window and store its reference
    selectedWin := WinGetTitle("A")
    
    ; Show a tooltip with the selected window's title
    ToolTip("Selected window: " selectedWin)
    Sleep(2000)  ; Wait 2 seconds
    ToolTip()  ; Remove tooltip

    shouldStop := 0
    while !shouldStop {
        ; Click in the selected window
        MouseClick("left")
        Sleep(1500)
    }
}
