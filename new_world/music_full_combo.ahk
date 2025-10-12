^c:: break++
^x::

break := -1

avgSleep:=250
sleepVariance:=100


while break < 0 {
	PixelGetColor, color, 1540, 1000
	if(color == 0xC3C3C3){
 		Random, sleepTime, %avgSleep%-%sleepVariance%, %avgSleep%+%sleepVariance%
		sleep %sleepTime%
		MouseClick, left
	}
}
