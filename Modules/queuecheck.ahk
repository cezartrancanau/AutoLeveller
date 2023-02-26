#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
DetectHiddenWindows, On
DetectHiddenText, On

QueueCheck()
{
    MouseMove, 0, 0
    sleep 50
    PixelSearch, ei, fi, 530, 656, 530, 656, 0x18838b, 10, Fast RGB
    if ErrorLevel=0
    {
        return 2
    }
    sleep 50
    PixelSearch, ci, di, 530, 656, 530, 656, 0x5b5a56, 10, Fast RGB
    if ErrorLevel=0
	{
        return 1
	}
    return 0
}