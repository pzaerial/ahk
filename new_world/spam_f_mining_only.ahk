^c:: break++
^x::

break := -1
Random, runSleepTime, 500, 2000
lastRunTime := 0
Random, fSleepTime, 10, 50
lastFTime := 0
Random, jumpSleepTime, 250, 500
lastJump := 0

while break < 0 {
    ImageSearch, OutputVarX, OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, pickaxeGreenIcon.PNG
    if(OutputVarX > 0){
        ; Do nothing while mining
        continue
    } else {
        curTime := A_TickCount
        elapsedTime := curTime - lastRunTime
        if(elapsedTime > runSleepTime) {
            Send, w
            Random, slp, 10, 50
            Sleep, slp
            Send {``}
            Random, runSleepTime, 500, 2000
            lastRunTime := A_TickCount
        }
    }

    curTime := A_TickCount
    elapsedTime := curTime - lastFTime
    if(elapsedTime > fSleepTime) {
        Send, f
        Random, fSleepTime, 10, 50
        lastFTime := A_TickCount
    }

    curTime := A_TickCount
    elapsedTime := curTime - lastJumpTime
    if(elapsedTime > jumpSleepTime) {
        Send, {Space}
        Random, jumpSleepTime, 1000, 1250
        lastJumpTime := A_TickCount
    }
}
