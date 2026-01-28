; Program that manages registration of multiple windows and multiplex clicks across them.
; Note there are issues with sending clicks to emulators, as some of these require window focus.
; Some may allow backround input, some may not.
; Also see multiplex_control_click regarding bringing of window to focus.

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; -------------------------
; Global State
; -------------------------
global windows := []
global loop_running := false

; -------------------------
; Hotkeys
; -------------------------

; Ctrl + Z → Register active window
^z::
{
    if (loop_running)
    {
        MsgBox, 49, Cannot Register Window, Cannot register new window while the main loop is running.`n`nClick OK to stop the main loop.
        IfMsgBox, OK
            Gosub, StopMainLoop
        return
    }

    try_register_window()
    return
}

; Ctrl + C → Stop main loop
^c::
StopMainLoop:
{
    if (!loop_running)
        return

    loop_running := false
    MsgBox, 48, Main Loop Stopped, The main loop has been stopped.
    return
}

; Ctrl + X → Start main loop
^x::
{
    if (loop_running)
        return

    if (windows.Length() = 0)
    {
        MsgBox, 48, No Windows Registered, Please register at least one window first (Ctrl + Z).
        return
    }

    loop_running := true

    msg_text := "Registered Windows: " . windows.Length() . "`n`nPress Ctrl + C to stop."
    MsgBox, 64, Main Loop Started, %msg_text%

    while (loop_running)
    {
        ; Generate random fractional ratios for center 50% of the window
        Random, rand_x_ratio, 0.25, 0.75
        Random, rand_y_ratio, 0.25, 0.75

        ; Call multiplex function with fractional ratios
        multiplex_control_click(rand_x_ratio, rand_y_ratio, "Left", "NA")

        Sleep, 750   ; Interval between iterations
    }
    return
}

; -------------------------
; Functions
; -------------------------

try_register_window()
{
    global windows

    WinGet, hwnd, ID, A
    WinGetTitle, title, ahk_id %hwnd%

    ; Prevent duplicate registration
    for _, win in windows
    {
        if (win["win_id"] = hwnd)
        {
            MsgBox, 48, Already Registered, This window is already registered.
            return
        }
    }

    ; Get client size
    VarSetCapacity(rect, 16, 0)
    DllCall("GetClientRect", "Ptr", hwnd, "Ptr", &rect)
    client_w := NumGet(rect, 8, "Int")
    client_h := NumGet(rect, 12, "Int")

    if (client_w <= 0 || client_h <= 0)
    {
        MsgBox, 16, Error, Failed to read window dimensions.
        return
    }

    ; Create window object
    win_obj := { win_id: hwnd, win_title: title, win_w: client_w, win_h: client_h }
    windows.Push(win_obj)

    ; Build safe message string
    msg_text := "Window Name:`n" . title
        . "`n`nClient Size:`n" . client_w . " x " . client_h
        . "`n`nTotal Registered Windows:`n" . windows.Length()

    MsgBox, 64, Window Registered, %msg_text%
}

; -------------------------
; Multiplex ControlClick (fractions, single click per window)
; -------------------------
; x_ratio, y_ratio: values between 0.0 and 1.0
; button: "Left" / "Right"
; options: ControlClick options (e.g., "NA")
multiplex_control_click(x_ratio := 0.5, y_ratio := 0.5, button := "Left", options := "")
{
    global windows

    ; Loop through each registered window
    for _, win in windows
    {
        target_hwnd := win["win_id"]

        ; Convert fractional ratio to absolute pixel coordinates
        click_x := Floor(x_ratio * win["win_w"])
        click_y := Floor(y_ratio * win["win_h"])

        ; OPTIONAL: Bring window into focus in background
        ; WinSet, Bottom,, ahk_id %target_hwnd%

        ControlClick, x%click_x% y%click_y%, ahk_id %target_hwnd%, , %button%, 1, %options%
        ; No sleep — clicks happen as fast as possible
    }
}
