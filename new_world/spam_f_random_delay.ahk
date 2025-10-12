^c:: break++
^x::

break := -1

while break < 0 {
	Random, sleepTime, 500, 250
	sleep %sleepTime%
	Send, f
}
