^c:: break++
^x::

break := -1

; Timings
; Water Pickup - 4000ms 
; Boar picup - 3000 ms

while break < 0 {
	Random, sleepTime, 2400, 2500
	sleep sleepTime
	Send, f
}
