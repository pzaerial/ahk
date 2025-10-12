SetWorkingDir,%A_ScriptDir%

^c:: break++
^x::

lastRepairTime := A_TickCount

curTime := lastRepairTime + 14400001
elapsedTime := curTime - lastRepairTime
if(elapsedTime > 14400000) {
	; open inventory
	Send, {LAlt}
	Sleep 250

	; hold r and click on rod
	Send, {r down}
	MouseClick, left, 868, 661
	Send, {r up}
	Sleep 250

	; confirm repair
	Send, f
	Sleep 250

	; exit inventory
	Send, {LAlt}
	Sleep 250

	lastRepairTime := curTime
}
