^c:: break++
^x::

break := -1

while break < 0 {
	; Click on Item
	Click, 340 340
	Sleep 100

	; Click on Sell, Wait for price query.
	Click, 980 450
	Sleep 5000

	; Click on Trade Length
	Click, 860 675
	Sleep 500

	; Click on 1 Day
	Click, 840 725
	Sleep 250

	; Click on Sell, Wait for Post
	Click, 1120, 950
	Sleep 4000
}
