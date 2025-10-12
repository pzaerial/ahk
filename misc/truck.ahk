^c:: break++
^x::

break := -1

sleep 1000

while break < 0 {

	; Open Truck
	MouseClick, left, 100, 400
	sleep 250

	; Click Send
	MouseClick, left, 850, 900
	sleep 250

	; Click Quick Craft Location 1 x2
	MouseClick, left, 950, 700
	sleep 250
	MouseClick, left, 950, 700
	sleep 250

	; Click Quick Craft Location 2 x2
	MouseClick, left, 950, 800
	sleep 250
	MouseClick, left, 950, 800
	sleep 250

	; Click Fast Forward x2
	MouseClick, left, 850, 900
	sleep 250
	MouseClick, left, 850, 900
	sleep 250

	; Click Confirm
	MouseClick, left, 850, 750
	sleep 250

	; Click Choice x3
	MouseClick, left, 1320, 975
	sleep 250
	MouseClick, left, 1320, 975
	sleep 250
	MouseClick, left, 1320, 975
	sleep 250


}
