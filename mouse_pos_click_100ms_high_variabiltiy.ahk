global shouldContinue := -1  ; Declare and initialize the global variable

^c:: {
	global shouldContinue := 1
}

^x:: {
    global shouldContinue := -1

    while shouldContinue < 0 {
        Click()
        sleepTime := Random(50, 150)  ; Random time between 50-150ms (centered around 100ms)
        Sleep(sleepTime)
    }
}
