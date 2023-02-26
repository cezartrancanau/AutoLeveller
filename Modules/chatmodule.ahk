#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
DetectHiddenWindows, On
DetectHiddenText, On


champselectrandommessage()
{
    sleep 1500
    IniRead, entry, chat.ini, section2, last
    sleep 50
    entry:=entry+1
    IniWrite, %entry%, chat.ini, section2, last
    sleep 50
    IniRead, message, chat.ini, section1, %entry%, Limit
    if (message="Limit")
    {
        IniWrite, 1, chat.ini, section2, last
        IniRead, entry, chat.ini, section2, last
        IniRead, message, chat.ini, section1, %entry%
    }
    ChatDisplay("Last sent message in chat: "message)
	MouseMove, 100, 680
	sleep 1000
	MouseClick, Left
    sleep 500
    SendRaw, %message%
    sleep 500
    send {enter}
    return
}

postgamerandommessage()
{
    sleep 1500
    IniRead, entry, chat.ini, section6, last
    sleep 50
    entry:=entry+1
    IniWrite, %entry%, chat.ini, section6, last
    sleep 50
    IniRead, message, chat.ini, section5, %entry%, Limit
    if (message="Limit")
    {
        IniWrite, 1, chat.ini, section6, last
        IniRead, entry, chat.ini, section6, last
        IniRead, message, chat.ini, section5, %entry%
    }
    ChatDisplay("Last sent message in chat: "message)
	MouseMove, 100, 680
	sleep 1000
	MouseClick, Left
    sleep 500
    SendRaw, %message%
    sleep 500
    send {enter}
    return
}


ingamerandommessage()
{
	if not WinExist("League of Legends (TM)")
	{
		return
	}
    click, left up
    sleep 250
    click, left up
    sleep 250
    send {enter up}
    sleep 2500
    IniRead, entry, chat.ini, section4, last
    sleep 50
    entry:=entry+1
    IniWrite, %entry%, chat.ini, section4, last
    sleep 50
    IniRead, message, chat.ini, section3, %entry%, Limit
    if (message="Limit")
    {
        IniWrite, 1, chat.ini, section4, last
        IniRead, entry, chat.ini, section4, last
        IniRead, message, chat.ini, section3, %entry%
    }
    ChatDisplay("Last sent message in chat: "message)
    sleep 1000
    send {enter}
    sleep 1500
    PixelSearch, ef, ff, 0, 0, 160, 90, 0x1e2329,, Fast RGB
    if ErrorLevel=0
    {
        SendRaw, %message%
        sleep 1000
    }
    Else
    {
        return
    }
    Loop, 8
    {
        sleep 500
        PixelSearch, ef, ff, 0, 0, 160, 90, 0x1e2329,, Fast RGB
        if ErrorLevel=0
            {
            MouseMove, ef+8, ff+1
            sleep 500
            click, Left
            sleep 1000
            send {enter}
            sleep 1000
            break
         }
    }
    send {enter up}
    sleep 1500
    return
}

