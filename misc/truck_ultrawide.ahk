^c:: break++
^x::

break := -1

sleep 1000

while break < 0 {

	; Open Truck
	MouseClick, left, 100, 550
	sleep 250

	; Click Send
	MouseClick, left, 1600, 1200
	sleep 250

	; Click Quick Craft Location 1 x2
	MouseClick, left, 1720, 940
	sleep 250
	MouseClick, left, 1720, 940
	sleep 250

	; Click Quick Craft Location 2 x2
	MouseClick, left, 1720, 1100
	sleep 250
	MouseClick, left, 1720, 1100
	sleep 250

	; Click Fast Forward x2
	MouseClick, left, 1600, 1200
	sleep 250
	MouseClick, left, 1600, 1200
	sleep 250

	; Click Confirm
	MouseClick, left, 1560, 1000
	sleep 250

	; Click Choice x3
	MouseClick, left, 2200, 920
	sleep 250
	MouseClick, left, 2200, 920
	sleep 250
	MouseClick, left, 2200, 920
	sleep 250


}
