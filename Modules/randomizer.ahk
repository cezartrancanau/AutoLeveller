#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
DetectHiddenWindows, On
DetectHiddenText, On

Randomizer(a)
{
    Random, variation, -2, 2
    a:=a+variation
    return %a%
}

IngameRandomizer(a)
{
    Random, variation, -1, 1
    a:=a+variation
    return %a%
}

RandomizerHard(a)
{
    Random, variation, -12, 12
    a:=a+variation
    return %a%
}

TimeRandom(a)
{
	Random, variation, 1, 10
	a:=a*variation/5
	return %a%
}

SmallTimeRandom(a)
{
	Random, variation, -a/8, a/3
	a:=a+variation
	return %a%
}

LoopRandom(a)
{
	Random, variation, -3, 10
	a:=a+variation
	return %a%
}

SleepRandom(time)
{
    sleeptime:=SmallTimeRandom(time)
    sleep, %sleeptime%
}
