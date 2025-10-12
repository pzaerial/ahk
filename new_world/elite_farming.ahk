SetWorkingDir,%A_ScriptDir%

^c:: break++
^x::

break := -1

while break < 0 {
	if (isEliteThere() == 1) {
		MsgBox, Found Elite!
	}
}

IsEliteThere() {
	ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, eliteMob.PNG
    if(OutputVarX > 0){
   	    return 1
   	} else {
   	    return 0
   	}
}
