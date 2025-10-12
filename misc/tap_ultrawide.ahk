^c:: break++
^x::

break := -1

sleep 1000

; 120 then 150 then 210 then 240
NUM_CLICKS_PER_REFILL:=120

while break < 0 {

	; Do clicks
	itor = 0
	while itor < NUM_CLICKS_PER_REFILL {
		MouseClick, left, 2150, 1000
		sleep 50
		itor := itor + 1
	}

	sleep 250

	; Open NRG
	MouseClick, left, 1950, 230

	sleep 250

	; Double Confirm
	MouseClick, left, 1960, 975
	sleep 250
	MouseClick, left, 1960, 975

	sleep 250

}
