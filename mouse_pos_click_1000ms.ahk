shouldStop := 0
selectedWinID := ""

^c:: shouldStop := 1

^x::
{
    ; Get the active window's ID and store it
    selectedWinID := WinGetID("A")
    
    if !selectedWinID {
        MsgBox("No active window found!")
        return
    }
    
    ; Show a tooltip with the selected window's ID
    ToolTip("Selected window ID: " selectedWinID)
    Sleep(2000)  ; Wait 2 seconds
    ToolTip()  ; Remove tooltip

    shouldStop := 0
    
    ; Ensure the target window is active before sending input
    WinActivate(selectedWinID)
    Sleep(500)  ; Allow time for the window to activate
    
    while !shouldStop {
        ; Click in the active window
        Click
        Sleep(1000)
    }
}
