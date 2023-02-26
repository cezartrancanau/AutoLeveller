#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
DetectHiddenWindows, On
DetectHiddenText, On

HumanClickL(x, y)
{
	a:=Randomizer(x)
	b:=Randomizer(y)
	SendEvent, {Click Left %a%, %b%}
	return
}

HumanClickR(x, y)
{
	a:=Randomizer(x)
	b:=Randomizer(y)
	SendEvent, {Click Right %a%, %b%}
	return
}

IngameHumanClickL(x, y)
{
	a:=IngameRandomizer(x)
	b:=IngameRandomizer(y)
	SendEvent, {Click Left %a%, %b%}
	return
}

IngameHumanClickR(x, y)
{
	a:=IngameRandomizer(x)
	b:=IngameRandomizer(y)
	SendEvent, {Click Right %a%, %b%}
	return
}

RandomClickL(x, y)
{
	a:=RandomizerHard(x)
	b:=RandomizerHard(y)
	SendEvent, {Click Left %a%, %b%}
	return
}

RandomClickR(x, y)
{
	a:=RandomizerHard(x)
	b:=RandomizerHard(y)
	SendEvent, {Click Right %a%, %b%}
	return
}
