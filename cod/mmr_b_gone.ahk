^c:: break++
^x::

break := -1

while break < 0 {
	ControlSend,,{G Down},ahk_exe ModernWarfare.exe
	sleep 4000
	ControlSend,,{G Up},ahk_exe ModernWarfare.exe
}
