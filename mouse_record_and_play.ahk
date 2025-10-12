; Ctrl + C to close the app.
^c:: ExitApp

; OPTIONAL Debug Mode
^t::
	is_debug_mode := true
return

; 1. Ctrl + S to clear memory and start recording mode.
^s:: 
	is_recording_mode := true
	recorded_something := false
	locations := []
	idx := 1
	while is_recording_mode {
		KeyWait, LButton, down
			MouseGetPos,x,y
			if (is_recording_mode) {
				point := [x, y]
				locations[idx] := [point[1], point[2]]
				if (is_debug_mode) {
					MsgBox % "Left button clicked at " . x . ", " . y . "."
					MsgBox % "x: " . locations[idx][1] . ", y: " . locations[idx][2]
				}
				idx := idx + 1
			}
	}
return

; 2. Ctrl + D finishes recording mode.
^d::
	is_recording_mode := false
	recorded_something := true

	idx := idx - 1
	;if (is_debug_mode) {
	msg := "Click Locations`n"
	Loop %idx% {
		msg := msg . "Location(" . locations[A_Index][1] . ", " . locations[A_Index][2] . ")`n"
	}
	MsgBox, %msg%
	;}
return

; 3. Ctrl + X to start playback mode. 
^x::
	if (is_recording_mode == false and recorded_something == true) {
		forever := 1
		is_full_control_mode := false
		time_between_clicks = 1000  ; 500 ms
		while forever {
			Loop %idx% {
				msg := msg . "Clicking (" . locations[A_Index][1] . ", " . locations[A_Index][2] . ")`n"
				MouseClick, left, locations[A_Index][1], locations[A_Index][2]
				if (is_full_control_mode) {
					KeyWait, RButton, down
						sleep 1
				} else {
					sleep time_between_clicks
				}
			}
		}	
	} else {
		MsgBox, "Nothing is recorded."
	}
return

; Ctrl + F to either wait between clicks for the right click or to do all at once with delay.
^f::
	if (is_full_control_mode) {
		is_full_control_mode := false
	} else {
		is_full_control_mode := true
	}
