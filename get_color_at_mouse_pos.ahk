; Gets color at mouse position.

^c::ExitApp()

^x:: {
    MouseGetPos(&mouseX, &mouseY)
    pixelColor := PixelGetColor(mouseX, mouseY)
    MsgBox("Pixel at (" mouseX ", " mouseY ") has color " pixelColor)
}
