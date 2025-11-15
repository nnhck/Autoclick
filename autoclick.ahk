#Requires AutoHotkey v1.1.37.02

; Generic Multi-Click Script with Config File
; Displays instructions on startup

#SingleInstance Force
CoordMode, Mouse, Screen

global isPaused := true
global clickCount := 0
global clicks := []
global delayBetweenClicks := 100
global delayAfterSequence := 300

; Show instructions on startup
MsgBox, 64, Multi-Click Script, 
(
CONTROLS:

F1 = Start/Resume clicking sequence
F2 = Pause sequence
F3 = Capture current mouse position
F5 = Exit script

Place config.ini in the same folder as this script.
Edit config.ini to set click coordinates and timing.

Press OK to continue...
)

; Read config on startup
ReadConfig()

ReadConfig()
{
    global clicks, delayBetweenClicks, delayAfterSequence
    
    ; Read timing
    IniRead, delayBetweenClicks, config.ini, Timing, delayBetweenClicks, 100
    IniRead, delayAfterSequence, config.ini, Timing, delayAfterSequence, 300
    
    ; Read number of clicks
    IniRead, numClicks, config.ini, Coordinates, numClicks, 0
    
    ; Read each coordinate pair
    clicks := []
    Loop, %numClicks%
    {
        IniRead, x, config.ini, Coordinates, click%A_Index%X, 0
        IniRead, y, config.ini, Coordinates, click%A_Index%Y, 0
        clicks.Push({x: x, y: y})
    }
    
    if (clicks.Length() = 0)
        MsgBox, Warning: No clicks configured in config.ini
}

F3::
{
    MouseGetPos, xpos, ypos
    MsgBox, Position:`nX: %xpos%`nY: %ypos%`n`nAdd to config.ini
    return
}

F1::
{
    isPaused := false
    
    if (clicks.Length() = 0)
    {
        MsgBox, No clicks configured. Check config.ini
        return
    }
    
    Loop
    {
        if (isPaused)
            break
        
        ; Execute all clicks in sequence
        For index, coord in clicks
        {
            if (isPaused)
                break
                
            x := coord.x
            y := coord.y
            Click, %x%, %y%
            
            ; Use shorter delay between clicks, longer after last click
            if (index = clicks.Length())
                Sleep, %delayAfterSequence%
            else
                Sleep, %delayBetweenClicks%
        }
        
        clickCount++
        ToolTip, Cycles: %clickCount% | F2=Pause
    }
    return
}

F2::
{
    isPaused := true
    ToolTip, PAUSED | F1=Resume
    return
}

F5::
{
    ExitApp
}