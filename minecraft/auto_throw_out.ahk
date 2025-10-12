^c:: running := 1  ; Press Ctrl+C to stop

^x:: {
    running := -1  ; Press Ctrl+X to start
    while running < 0 {
        Send("^q")
        Sleep(1)
    }
}
