^c:: break++
^x::

break := -1

sleep 1000

; 120 150 210 240
ITERATIONS:=120

while break < 0 {

	; Do clicks
	itor = 0
	while itor < ITERATIONS {
		MouseClick, left, 1900, 661
		sleep 50
		itor := itor + 1
	}

	sleep 250

	; Open NRG
	MouseClick, left, 1980, 230

	sleep 250

	; Double Confirm
	MouseClick, left, 1980, 950
	sleep 250
	MouseClick, left, 1980, 950

	sleep 250

}
