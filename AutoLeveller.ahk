#NoEnv
#SingleInstance, force
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
DetectHiddenWindows, On
DetectHiddenText, On
SetBatchLines, -1

#Include, Modules\chatmodule.ahk
#Include, Modules\queuecheck.ahk
#Include, Modules\humanclick.ahk
#Include, Modules\randomizer.ahk
#Include, Modules\Teemo.ahk
#Include, Modules\Yuumi.ahk
#Include, Modules\Taric.ahk
#Include, Modules\Sona.ahk
#Include, Modules\Soraka.ahk


OsVersion:=SubStr(A_OSVersion, 1, 2)
if not (A_ScreenHeight>=1080 && A_ScreenWidth>=1920 && OsVersion>=10)
{
	msgbox, 16,, This machine does not meet the required minimum specs, in order to run, you must have at least Windows 10 and a 1920x1080 screen!
	ExitApp
}
if not FileExist("config.ini")
{
	msgbox,16,,No config.ini file found, is it named "config.ini"? If it is missing, please reinstall the bot!
	ExitApp
}


start:
IniRead, username1, config.ini, section1, username1
IniRead, password1, config.ini, section1, password1
IniRead, username2, config.ini, section1, username2
IniRead, password2, config.ini, section1, password2
IniRead, AccountCount, config.ini, section1, AccountCount
IniRead, azerty, config.ini, section1, azerty
IniRead, Yuumi, config.ini, section2, Yuumi
IniRead, Teemo, config.ini, section2, Teemo
IniRead, Taric, config.ini, section2, Taric
IniRead, Sona, config.ini, section2, Sona
IniRead, Soraka, config.ini, section2, Soraka
IniRead, gamemode, config.ini, section3, gamemode
IniRead, mode, config.ini, section4, mode
IniRead, timeperaccountinminutes, config.ini, section4, timeperaccountinminutes
IniRead, sleeptimeafterswitch, config.ini, section4, sleeptimeafterswitch
IniRead, sleeptimebetweenmatch, config.ini, section4, sleeptimebetweenmatch
IniRead, starttime, config.ini, section4, starttime
IniRead, stoptime, config.ini, section4, stoptime
IniRead, randomsummoners, config.ini, section4, randomsummoners
IniRead, randomrunes, config.ini, section4, randomrunes
IniRead, randomchat, config.ini, section4, randomchat
IniRead, buffergames, config.ini, section4, buffergames
IniRead, newbiehelp, config.ini, section4, newbiehelp
IniRead, prioritypick, config.ini, section4, prioritypick
IniRead, LeagueConfigFolder, config.ini, section5, LeagueConfigFolder
IniRead, fillgames, config.ini, section5, fillgames
IniRead, regulargames, config.ini, section5, regulargames
Gui, Add, Button, default, Apply Settings
Gui, Add, Button, default yp x+5, Reset to default
Gui, Add, Button, default yp x+5, Start Bot

Gui, Add, Tab3, xm+1 y+15 w400 h580, Accounts|Champions|Gamemode|Gameplay
Gui, Tab, 1
Gui, Add, Text,, Username1:
Gui, Add, Edit, vUsername1
GuiControl,, Username1, %username1%
Gui, Add, Text,, Password1:
Gui, Add, Edit, vPassword1
GuiControl,, password1, %password1%
Gui, Add, Text,, Username2:
Gui, Add, Edit, vUsername2
GuiControl,, Username2, %username2%
Gui, Add, Text,, Password2:
Gui, Add, Edit, vPassword2
GuiControl,, password2, %password2%
Gui, Add, Text,, Number of Accounts (Enter credentials manually in config.ini if 3+ Accounts):
Gui, Add, Edit, vAccountCount
GuiControl,, AccountCount, %AccountCount%


Gui, Add, Text, y+20, League of Legends config folder: `nPlease make a backup of your old config folder before applying the settings.
Gui, Add, Text,, %LeagueConfigFolder%
Gui, Add, Button, yp-5 default x+5, Change Folder

Gui, Add, CheckBox, y+20 xm+12 vazerty, AZERTY Keyboard
GuiControl,, azerty, %azerty%

Gui, Tab, 2
Gui, Add, CheckBox, vYuumi, Yuumi
GuiControl,, Yuumi, %Yuumi%
Gui, Add, CheckBox, vSona, Sona
GuiControl,, Sona, %Sona%
Gui, Add, CheckBox, vTaric, Taric
GuiControl,, Taric, %Taric%
Gui, Add, CheckBox, vTeemo, Teemo
GuiControl,, Teemo, %Teemo%
Gui, Add, CheckBox, vSoraka, Soraka
GuiControl,, Soraka, %Soraka%

Gui, Tab, 3
Gui, Add, Text,, Choose gamemode
if gamemode=1
{
	Gui, Add, Radio, vgamemode checked, Ranked Solo/Duo
	Gui, Add, Radio,, Ranked Flex
	Gui, Add, Radio,, Normal Blindpick 5v5
	Gui, Add, Radio,, Intro Bots
}
if gamemode=2
{
	Gui, Add, Radio, vgamemode, Ranked Solo/Duo
	Gui, Add, Radio, checked, Ranked Flex
	Gui, Add, Radio,, Normal Blindpick 5v5
	Gui, Add, Radio,, Intro Bots
}
if gamemode=3
{
	Gui, Add, Radio, vgamemode, Ranked Solo/Duo
	Gui, Add, Radio,, Ranked Flex
	Gui, Add, Radio, checked, Normal Blindpick 5v5
	Gui, Add, Radio,, Intro Bots
}
if gamemode=4
{
	Gui, Add, Radio, vgamemode, Ranked Solo/Duo
	Gui, Add, Radio,, Ranked Flex
	Gui, Add, Radio,, Normal Blindpick 5v5
	Gui, Add, Radio, checked, Intro Bots
}


Gui, Tab, 4
Gui, Add, Text,, Mode 1 means that the bot plays within a defined timespan per day,`nMode 2 makes the bot play for a certain time regardless of daytime.
if mode=1
{
	Gui, Add, Radio, vMode checked , 1
	Gui, Add, Radio,, 2
}
Else
{
	Gui, Add, Radio, vMode , 1
	Gui, Add, Radio, checked, 2
}
Gui, Add, GroupBox, w300 h50, Mode 1 Options
Gui, Add, Text, yp+20 xp+15, Starttime
Gui, Add, Edit, vStarttimeH yp-3 x+4 w20
StarttimeH := SubStr(starttime, 1, 2)
GuiControl,, StarttimeH, %StarttimeH%
Gui, Add, Text, yp x+4, :
Gui, Add, Edit, vStarttimeM yp x+4 w20
StarttimeM := SubStr(starttime, 3, 2)
GuiControl,, StarttimeM, %StarttimeM%
Gui, Add, Text,yp x+4, : 
Gui, Add, Edit, vStarttimeS yp x+4 w20
StarttimeS := SubStr(starttime, 5, 2)
GuiControl,, StarttimeS, %StarttimeS%

Gui, Add, Text, yp+3 x+15, Stoptime 
Gui, Add, Edit, vStoptimeH yp-3 x+4 w20
StoptimeH := SubStr(Stoptime, 1, 2)
GuiControl,, StoptimeH, %StoptimeH%
Gui, Add, Text, yp x+4, :
Gui, Add, Edit, vStoptimeM yp x+4 w20
StoptimeM := SubStr(Stoptime, 3, 2)
GuiControl,, StoptimeM, %StoptimeM%
Gui, Add, Text,yp x+4, : 
Gui, Add, Edit, vStoptimeS yp x+4 w20
StoptimeS := SubStr(Stoptime, 5, 2)
GuiControl,, StoptimeS, %StoptimeS%

Gui, Add, GroupBox, w335 h50 xm+12 y+15, Mode 2 Options
Gui, Add, Text, yp+20 xp+15, Time per account (M)
Gui, Add, Edit, vtimeperaccountinminutes yp-3 x+4 w30
GuiControl,, timeperaccountinminutes, %timeperaccountinminutes%

Gui, Add, Text, yp+3 x+19, Time after switching (M)
Gui, Add, Edit, vsleeptimeafterswitch yp-3 x+4 w30
GuiControl,, sleeptimeafterswitch, %sleeptimeafterswitch%

Gui, Add, Text, xm+12 y+15, Time between games (Minutes)
Gui, Add, Edit, vsleeptimebetweenmatch w40
GuiControl,, sleeptimebetweenmatch, %sleeptimebetweenmatch%


Gui, Add, Text,,
Gui, Add, CheckBox, vrandomsummoners, Use random Summoner spells
GuiControl,, randomsummoners, %randomsummoners%

Gui, Add, CheckBox, vrandomrunes, Use random Runes
GuiControl,, randomrunes, %randomrunes%

Gui, Add, CheckBox, vrandomchat, Use random chat (from chat.ini)
GuiControl,, randomchat, %randomchat%

Gui, Add, GroupBox, w380 h170, Buffergames
Gui, Add, CheckBox, vbuffergames yp+18 xm+18, Play Buffergames (alternate between botgames and selected gamemode)
GuiControl,, buffergames, %buffergames%

Gui, Add, Text, y+8 xm+18, Amount of Buffergames
Gui, Add, Text,, 1
Gui, Add, Slider, yp x+5 vfillgames w200 Range1-10 ToolTipLeft ToolTipRight TickInterval1, 5
GuiControl,, fillgames, %fillgames%
Gui, Add, Text, yp x+5, 10
Gui, Add, Text, y+20 xm+18, Amount of Games with selected Gamemode
Gui, Add, Text,, 1
Gui, Add, Slider, yp x+5 vregulargames w200 Range1-10 ToolTipLeft ToolTipRight TickInterval1, 5
GuiControl,, regulargames, %regulargames%
Gui, Add, Text, yp x+5, 10


Gui, Add, Text, xm+12 y+40, Prioritize Champion:
if prioritypick=sona
	{
		Gui, Add, Radio, vprioritypick checked, Sona
		Gui, Add, Radio, yp x+5, Teemo
		Gui, Add, Radio, yp x+5, Taric
		Gui, Add, Radio, yp x+5, Yuumi
		Gui, Add, Radio, yp x+5, Soraka
		Gui, Add, Radio, yp x+5, None
	}
if prioritypick=teemo
	{
		Gui, Add, Radio, vprioritypick, Sona
		Gui, Add, Radio, checked yp x+5, Teemo
		Gui, Add, Radio, yp x+5, Taric
		Gui, Add, Radio, yp x+5, Yuumi
		Gui, Add, Radio, yp x+5, Soraka
		Gui, Add, Radio, yp x+5, None
	}
if prioritypick=taric
	{
		Gui, Add, Radio, vprioritypick, Sona
		Gui, Add, Radio, yp x+5, Teemo
		Gui, Add, Radio, checked yp x+5, Taric
		Gui, Add, Radio, yp x+5, Yuumi
		Gui, Add, Radio, yp x+5, Soraka
		Gui, Add, Radio, yp x+5, None
	}
if prioritypick=yuumi
	{
		Gui, Add, Radio, vprioritypick, Sona
		Gui, Add, Radio, yp x+5, Teemo
		Gui, Add, Radio, yp x+5, Taric
		Gui, Add, Radio, checked yp x+5, Yuumi
		Gui, Add, Radio, yp x+5, Soraka
		Gui, Add, Radio, yp x+5, None
	}
if prioritypick=soraka
	{
		Gui, Add, Radio, vprioritypick, Sona
		Gui, Add, Radio, yp x+5, Teemo
		Gui, Add, Radio, yp x+5, Taric
		Gui, Add, Radio, yp x+5, Yuumi
		Gui, Add, Radio, checked yp x+5, Soraka
		Gui, Add, Radio, yp x+5, None
	}
if !prioritypick
	{
		Gui, Add, Radio, vprioritypick checked, Sona
		Gui, Add, Radio, yp x+5, Teemo
		Gui, Add, Radio, yp x+5, Taric
		Gui, Add, Radio, yp x+5, Yuumi
		Gui, Add, Radio, yp x+5, Soraka
		Gui, Add, Radio, checked yp x+5 , None
	}


Gui, Show,, Configuration Settings
flag=false
return


GuiClose:
GuiEscape:
{
    ExitApp
	return
}

ButtonChangeFolder:
FileSelectFolder, OutputVar, , 3
if OutputVar =
    MsgBox, 64,, Not a valid folder!
else
    IniWrite, %OutputVar%, config.ini, section5, LeagueConfigFolder
Gui, Submit
Reload
return

ButtonApplySettings:
Gui, Submit
IniWrite, %username1%, config.ini, section1, username1
IniWrite, %password1%, config.ini, section1, password1
IniWrite, %username2%, config.ini, section1, username2
IniWrite, %password2%, config.ini, section1, password2
IniWrite, %AccountCount%, config.ini, section1, AccountCount
IniWrite, %azerty%, config.ini, section1, azerty
IniWrite, %Yuumi%, config.ini, section2, Yuumi
IniWrite, %Teemo%, config.ini, section2, Teemo
IniWrite, %Taric%, config.ini, section2, Taric
IniWrite, %Sona%, config.ini, section2, Sona
IniWrite, %Soraka%, config.ini, section2, Soraka
IniWrite, %gamemode%, config.ini, section3, gamemode
IniWrite, %mode%, config.ini, section4, mode
IniWrite, %timeperaccountinminutes%, config.ini, section4, timeperaccountinminutes
IniWrite, %sleeptimeafterswitch%, config.ini, section4, sleeptimeafterswitch
IniWrite, %sleeptimebetweenmatch%, config.ini, section4, sleeptimebetweenmatch
IniWrite, %StarttimeH%%StarttimeM%%StarttimeS%, config.ini, section4, starttime
IniWrite, %StoptimeH%%StoptimeM%%StoptimeS%, config.ini, section4, stoptime
IniWrite, %randomsummoners%, config.ini, section4, randomsummoners
IniWrite, %randomrunes%, config.ini, section4, randomrunes
IniWrite, %randomchat%, config.ini, section4, randomchat
IniWrite, %buffergames%, config.ini, section4, buffergames
IniWrite, %fillgames%, config.ini, section5, fillgames
IniWrite, %regulargames%, config.ini, section5, regulargames
if prioritypick=1
{
	IniWrite, Sona, config.ini, section4, prioritypick
}
if prioritypick=2
{
	IniWrite, Teemo, config.ini, section4, prioritypick
}
if prioritypick=3
{
	IniWrite, Taric, config.ini, section4, prioritypick
}
if prioritypick=4
{
	IniWrite, Yuumi, config.ini, section4, prioritypick
}
if prioritypick=5
{
	IniWrite, Soraka, config.ini, section4, prioritypick
}
if prioritypick=6
{
	IniWrite, %A_Space%, config.ini, section4, prioritypick
}
IniRead, LeagueConfigFolder, config.ini, section5, LeagueConfigFolder
IniRead, azertymode, config.ini, section1, azerty
if azertymode=0
{
	FileCopyDir, Config, %LeagueConfigFolder%, 1
	if ErrorLevel=1
	{
		msgbox, Error while copying config folder, make sure you select the path where your League of Legends is installed!
	}
}
if azertymode=1
{
	FileCopyDir, ConfigAZERTY, %LeagueConfigFolder%, 1
	if ErrorLevel=1
	{
		msgbox, Error while copying config folder, make sure you select the path where your League of Legends is installed!
	}
}
if (Yuumi=0 && Teemo=0 && Taric=0 && Sona=0 && Soraka=0)
msgbox, Please select 1 or more champions.
Gui, Show,, Configuration Setttings
return
ButtonResettodefault:
IniWrite, %A_Space%, config.ini, section1, username1
IniWrite, %A_Space%, config.ini, section1, password1
IniWrite, %A_Space%, config.ini, section1, username2
IniWrite, %A_Space%, config.ini, section1, password2
IniWrite, 2, config.ini, section1, AccountCount
IniWrite, 0, config.ini, section1, azerty
IniWrite, 1, config.ini, section2, Yuumi
IniWrite, 1, config.ini, section2, Teemo
IniWrite, 1, config.ini, section2, Taric
IniWrite, 1, config.ini, section2, Sona
IniWrite, 1, config.ini, section2, Soraka
IniWrite, 3, config.ini, section3, gamemode
IniWrite, 2, config.ini, section4, mode
IniWrite, 600, config.ini, section4, timeperaccountinminutes
IniWrite, 140, config.ini, section4, sleeptimeafterswitch
IniWrite, 0, config.ini, section4, sleeptimebetweenmatch
IniWrite, 000001, config.ini, section4, starttime
IniWrite, 000000, config.ini, section4, stoptime
IniWrite, 1, config.ini, section4, randomsummoners
IniWrite, 1, config.ini, section4, randomrunes
IniWrite, 1, config.ini, section4, randomchat
IniWrite, 1, config.ini, section4, buffergames
IniWrite, %A_Space%, config.ini, section4, prioritypick
IniWrite, C:\Riot Games\League of Legends\Config, config.ini, section5, LeagueConfigFolder
IniWrite, 5, config.ini, section5, fillgames
IniWrite, 5, config.ini, section5, regulargames
Reload
return

;-----------------------------------------------------------------------------------------------------------------------------------------------------------



SleepingModule()
{
	IniRead, starttime, config.ini, section4, starttime
	sleep 500
	IniRead, stoptime, config.ini, section4, stoptime
	sleep 500
	timenow := A_Now
	timenow := SubStr(timenow, 9, 10)
	if (starttime>stoptime)
	{
		while !((timenow >= starttime and timenow <= 235959) or (timenow >= 000000 and timenow <= stoptime))
		{
			IniRead, starttime, config.ini, section4, starttime
			sleep 500
			IniRead, stoptime, config.ini, section4, stoptime
			sleep 500
			timenow := A_Now
			timenow := SubStr(timenow, 9, 10)
			send {Space up}
			sleep, %c%
			send {Space}
			sleep 15000
		}
	}
	Else
	{
		while !(timenow >= starttime and timenow <= stoptime)
		{
			IniRead, starttime, config.ini, section4, starttime
			sleep 500
			IniRead, stoptime, config.ini, section4, stoptime
			sleep 500
			timenow := A_Now
			timenow := SubStr(timenow, 9, 10)
			send {Space up}
			sleep, %c%
			send {Space}
			sleep 15000
		}
	}
	return
}


CleanPopups()
{
	WinActivate, League of Legends ahk_exe LeagueClientUx.exe
	MouseMove, 0, 0
	GamestepDisplay("Scanning for selection popup...")
	imagesearch, eij, fij, 0, 0, 1280, 720, *35 Images\select.png
	if ErrorLevel=0
	{
		HumanClickL(eij+8, fij+8)
		MouseMove, 0, 0
		SleepRandom(3000)
	}
	GamestepDisplay("Scanning for leaverbuster popup...")
	imagesearch, eii, fii, 0, 0, 1280, 720, *35 Images\understand.png
	if ErrorLevel=0
	{
		HumanClickL(eii+8, fii+8)
		MouseMove, 0, 0
		SleepRandom(3000)
	}
	GamestepDisplay("Scanning for leaver punishment popup...")
	PixelSearch, xx, yy, 640, 440, 640, 440, 0x1e2328,, Fast RGB
	if ErrorLevel=0
	{
		HumanClickL(640, 384)
		SleepRandom(2000)
		send, I Agree
		SleepRandom(2000)
		HumanClickL(638, 450)
		SleepRandom(2000)
		MouseMove, 0, 0
	}
	GamestepDisplay("Scanning for leaverbuster popup...")
	ImageSearch, eif, fif, 0, 0, 1280, 720, *35 Images\leaverbuster.png
	if ErrorLevel=0
	{
		HumanClickL(640, 404)
		SleepRandom(2000)
		send, I Agree
		SleepRandom(2000)
		HumanClickL(638, 470)
		SleepRandom(2000)
		MouseMove, 0, 0
	}
	GamestepDisplay("Scanning for checkbox...")
	imagesearch, eq, fq, 0, 0, 1280, 720, *70 Images\check.png
	if ErrorLevel=0
	{
		a:=Randomizer(eq)+4
		b:=Randomizer(fq)+4
		MouseMove, %a%, %b%
		SleepRandom(250)
		click, %a% %b% Left 
		MouseMove, 0, 0
		SleepRandom(3000)
	}
	PixelSearch, cid, did, 880, 80, 900, 100, 0x1E282D,, Fast RGB
	if ErrorLevel=0
	{
		HumanClickL(cid+8, did+8)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	PixelSearch, cid, did, 640, 520, 650, 530, 0xC8AA6E,, Fast, RGB
	if ErrorLevel=0
	{
		HumanClickL(cid+8, did+8)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	PixelSearch, eikk, fikk, 642, 526, 642, 526, 0xc7a96d,, Fast RGB
	if ErrorLevel=0
	{
		HumanClickL(eikk, fikk)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	GamestepDisplay("Scanning for close-button...")
	ImageSearch, ax, ay, 0, 0, 1280, 720, *25 Images\close.png
	if ErrorLevel=0
	{
		HumanClickL(ax, ay)
	}
	SleepRandom(1000)
	GamestepDisplay("Scanning for close-button....")
	ImageSearch, ax, ay, 0, 0, 1280, 720, *25 Images\close2.png
	if ErrorLevel=0
	{
		HumanClickL(ax, ay)
	}
	GamestepDisplay("Scanning for ok-button..")
	imagesearch, eix, fix, 0, 0, 1280, 720, *25 Images\ok3.png
	if ErrorLevel=0
	{
		HumanClickL(eix, fix)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	GamestepDisplay("Scanning for ok-button...")
	imagesearch, eib, fib, 0, 0, 1280, 720, *35 Images\ok.png
	if ErrorLevel=0
	{
		HumanClickL(eib+6, fib+6)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	SleepRandom(1000)
	GamestepDisplay("Scanning for honor levelup popup...")
	ImageSearch, ax, ay, 0, 0, 1280, 720, *35 Images\honorgg.png
	if ErrorLevel=0
	{
		HumanClickL(ax, ay)
	}
	GamestepDisplay("Scanning for leaverbuster popup...")
	imagesearch, eic, fic, 0, 0, 1280, 720, *35 Images\leaverok.png
	if ErrorLevel=0
	{
		HumanClickL(eic-3, fic-3)
		MouseMove, 0, 0
		SleepRandom(2000)
	}
	GamestepDisplay("Popups cleared...")
	return
}


RankedtoBotQueue(index, ByRef bots, ByRef game)
{
	game=0
	bots=1
	rankedtobotstart:
	GamestepDisplay("Switching to Buffergames...")
	IniRead, username, config.ini, section1, username%index%
	IniRead, password, config.ini, section1, password%index%
	if RestartClientAndLogIn(username, password)=0
		goto rankedtobotstart
	if WinExist("Riot Client")
	{
		HumanClickL(200, 800)
	}
	Loop, 10
	{
		WinActivate, League of Legends ahk_exe LeagueClientUx.exe
		CleanPopups()
		PixelSearch, ax, ay, 90, 30, 150, 50, 0xF0E6D2,, Fast RGB
		if ErrorLevel=0
		{
			break
		}
		WinActivate, Riot Client ahk_exe RiotClientUx.exe
		SleepRandom(500)
		PixelSearch, ax, by, 0, 0, 1, 1, 0xf9f9f9, Fast RGB
		if ErrorLevel=0
		{
			SleepRandom(5000)
			goto, rankedtobotstart
		}
	}
	SleepRandom(10000)
	HumanClickL(110, 30)
	SleepRandom(5000)
	HumanClickL(150, 95)
	SleepRandom(10000)
	HumanClickL(455, 496)
	SleepRandom(10000)
	HumanClickL(540, 685)
	SleepRandom(10000)

	MouseMove, 0, 0
	SleepRandom(2500)
    PixelSearch, ei, fi, 530, 656, 530, 656, 0x18838b, 10, Fast RGB
	if ErrorLevel=0
	{
		return
	}
	Else
	{
		SleepRandom(2500)
		goto, rankedtobotstart
	}
	return
}


RandomRunes()
{
	GamestepDisplay("Selecting random Rune page...")
	HumanClickL(570, 680)
	SleepRandom(1000)
	Random, Rune, 1, 5
	if Rune=1
	{
		HumanClickL(550, 470)
	}
	if Rune=2
	{
		HumanClickL(550, 540)
	}
	if Rune=3
	{
		HumanClickL(550, 580)
	}
	if Rune=4
	{
		HumanClickL(550, 610)
	}
	if Rune=5
	{
		HumanClickL(550, 645)
	}
	SleepRandom(1000)
	MouseMove, 0, 0
	return
}


RandomSummoner(a)
{
	GamestepDisplay("Selecting random summoner spells...")
	Random, Spell, 1, 5
	if a=1
	{
		HumanClickL(690, 680)
	}
	if a=2
	{
		HumanClickL(740, 680)
	}
	SleepRandom(2000)
	if Spell=1
	{
		HumanClickL(625, 480)
	}
	if Spell=2
	{
		HumanClickL(750, 480)
	}
	if Spell=3
	{
		HumanClickL(805, 480)
	}
	if Spell=4
	{
		;HumanClickL(625, 540)
	}
	if Spell=5
	{
		HumanClickL(625, 600)
	}
	MouseMove, 0, 0
	return
}


PerformLogin(username, password)
{	
	HumanClickL(70, 240)
	SleepRandom(5000)
	sendraw, %username%
	SleepRandom(10000)
	HumanClickL(70, 310)
	SleepRandom(5000)
	sendraw, %password%
	SleepRandom(10000)
	send {enter}
	SleepRandom(10000)
}


TerminateClient()
{
	Process, Close, RiotClientServices.exe
	Process, Close, RiotClient.exe
	Process, Close, League of legends.exe
	Process, Close, LeagueClient.exe
	Process, Close, LeagueClientUx.exe
	Process, Close, RiotClientUx.exe
	Process, Close, RiotClientUxRender.exe
	sleep 10000
}


RestartClientAndLogIn(username, password)
{
	TerminateClient()
	Run, shortcut.lnk
	sleep 25000
	WinActivate, Riot Client ahk_exe RiotClientUx.exe

	CoordMode, Pixel, Screen
	CoordMode, Mouse, Screen
	HumanClickL(960, 540)
	CoordMode, Pixel, Relative
	CoordMode, Mouse, Relative

	PixelSearch, ax, by, 0, 0, 1, 1, 0xf9f9f9, Fast RGB
	if ErrorLevel=1
	{
		SleepRandom(5000)
		return 0
	}
	PerformLogin(username, password)

	CleanPopups()
	return 1
}


SwitchAccount(index, ByRef bots, ByRef game)
{
	game=0
	bots=0
	cleanup:
	GamestepDisplay("Switching Accounts")
	IniRead, username, config.ini, section1, username%index%
	IniRead, password, config.ini, section1, password%index%
	IniRead, gamemode, config.ini, section3, gamemode
	GamestepDisplay("Logging in...")
	if RestartClientAndLogIn(username, password)=0
		goto cleanup
	SleepRandom(5000)
	if WinExist("Riot Client")
	{
		HumanClickL(200, 800)
	}
	SleepRandom(5000)
	Loop, 10
	{
		WinActivate, League of Legends ahk_exe LeagueClientUx.exe
		CleanPopups()
		PixelSearch, ax, ay, 90, 30, 150, 50, 0xF0E6D2,, Fast RGB
		if ErrorLevel=0
		{
			break
		}
		WinActivate, Riot Client ahk_exe RiotClientUx.exe
		SleepRandom(500)
		PixelSearch, ax, by, 0, 0, 1, 1, 0xf9f9f9, Fast RGB
		if ErrorLevel=0
		{
			SleepRandom(5000)
			goto, cleanup
		}
	}
	SleepRandom(10000)
	CleanPopups()
	SleepRandom(5000)
	HumanClickL(110, 30)
	SleepRandom(10000)
	GamestepDisplay("Selecting Gamemode...")
	if gamemode=1
	{
		HumanClickL(60, 95)
		SleepRandom(5000)
		HumanClickL(170, 210)
		SleepRandom(5000)
		ImageSearch, ax, ay, 0, 0, A_ScreenWidth, A_ScreenHeight, *110 Images\ranked.png
		HumanClickL(ax, ay)
		SleepRandom(10000)
	}
	if gamemode=2
	{
		HumanClickL(60, 95)
		SleepRandom(5000)
		HumanClickL(170, 210)
		SleepRandom(5000)
		ImageSearch, ax, ay, 0, 0, A_ScreenWidth, A_ScreenHeight, *110 Images\flex.png
		HumanClickL(ax, ay)
		SleepRandom(10000)
	}
	if gamemode=3
	{
		HumanClickL(60, 95)
		SleepRandom(5000)
		HumanClickL(170, 210)
		SleepRandom(5000)
		ImageSearch, ax, ay, 0, 0, A_ScreenWidth, A_ScreenHeight, *110 Images\blindpick.png
		HumanClickL(ax, ay)
		SleepRandom(10000)
	}
	if gamemode=4
	{
		HumanClickL(150, 95)
		SleepRandom(10000)
		HumanClickL(455, 496)
		SleepRandom(10000)
	}
	HumanClickL(540, 685)
	SleepRandom(10000)
	
	if (gamemode=1 or gamemode=2)
	{
		HumanClickL(655, 680)
		SleepRandom(5000)
		HumanClickL(740, 620)
		SleepRandom(5000)
		HumanClickL(695, 680)
		SleepRandom(5000)
		HumanClickL(665, 620)
		SleepRandom(5000)
	}
	MouseMove, 0, 0
	SleepRandom(2500)
    PixelSearch, ei, fi, 530, 656, 530, 656, 0x18838b, 10, Fast RGB
	if ErrorLevel=0
	{
		return
	}
	Else
	{
		SleepRandom(2500)
		goto, cleanup
	}
	GamestepDisplay("Ready to queue up...")
	return
}


PickChampion()
{
	GamestepDisplay("Picking Champion")
    IniRead, Yuumi, config.ini, section2, Yuumi
    IniRead, Teemo, config.ini, section2, Teemo
    IniRead, Taric, config.ini, section2, Taric
    IniRead, Sona, config.ini, section2, Sona
	IniRead, Soraka, config.ini, section2, Soraka
    IniRead, priority, config.ini, section4, prioritypick
    Loop
    {
        Pool := []
        PoolLenght := Taric + Teemo + Sona + Yuumi + Soraka
        if PoolLenght=0
        {
            return None
        }
        PixelSearch, kj, mj, 828, 36, 828, 36, 0xE9E5D1, 5, Fast RGB ;check if champ select exited early
		if ErrorLevel=1
		{
			return None
		}

        if Taric=1
        {
            Pool.Push("Taric")
        }
        if Teemo=1
        {
            Pool.Push("Teemo")
        }
        if Yuumi=1
        {
            Pool.Push("Yuumi")
        }
        if Sona=1
        {
            Pool.Push("Sona")
        }
        if Soraka=1
        {
            Pool.Push("Soraka")
        }

        Random, luck, 1, PoolLenght
        Champion:=Pool[luck]
        if (priority!="" && priority!=used)
        {
            Champion:=priority
            priority:=used
        }

        HumanClickL(875, 102)
        SleepRandom(600)
        HumanClickL(875, 102)
        SleepRandom(600)
        sendraw, %Champion%
        SleepRandom(3500)

        ImageSearch, ai, bi, 100, 100, 700, 500, *50 Images\No%Champion%.png
        if ErrorLevel=0
        {
            if Champion=Taric
            {
                Taric=0
            }
            if Champion=Teemo
            {
                Teemo=0
            }
            if Champion=Yuumi
            {
                Yuumi=0
            }
            if Champion=Sona
            {
                Sona=0
            }
            if Champion=Soraka
            {
                Soraka=0
            }
            SleepRandom(700)
            loop, 3
            {
                send ^a
                sleep 100
                send {Backspace}
            }
        }
        else
        {
			GamestepDisplay("Picked " Champion)
            return %Champion%
        }
    }
}


GameDisconnectCheck(byRef GameDisconnect)
{
	PixelSearch, axx, byy, 71, 38, 71, 38, 0x59401f, 3, Fast RGB
	if ErrorLevel=0
	{
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
	}
	PixelSearch, axx, byy, 75, 38, 75, 38, 0x000b13, 3, Fast RGB
	if ErrorLevel=0
	{
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 40)
		SleepRandom(150)
		click, left up
		HumanClickL(80, 25)
		SleepRandom(150)
		click, left up
	}
	PixelSearch, axx, byy, 69, 7, 69, 7, 0x161c1e,, Fast RGB
	if ErrorLevel=0
	{
		GameDisconnect:=GameDisconnect+1
	}
	Else
	{
		GameDisconnect=0
	}
	return
}


StdOutToVar(cmd) 
{
	DllCall("CreatePipe", "PtrP", hReadPipe, "PtrP", hWritePipe, "Ptr", 0, "UInt", 0)
	DllCall("SetHandleInformation", "Ptr", hWritePipe, "UInt", 1, "UInt", 1)

	VarSetCapacity(PROCESS_INFORMATION, (A_PtrSize == 4 ? 16 : 24), 0)    ; http://goo.gl/dymEhJ
	cbSize := VarSetCapacity(STARTUPINFO, (A_PtrSize == 4 ? 68 : 104), 0) ; http://goo.gl/QiHqq9
	NumPut(cbSize, STARTUPINFO, 0, "UInt")                                ; cbSize
	NumPut(0x100, STARTUPINFO, (A_PtrSize == 4 ? 44 : 60), "UInt")        ; dwFlags
	NumPut(hWritePipe, STARTUPINFO, (A_PtrSize == 4 ? 60 : 88), "Ptr")    ; hStdOutput
	NumPut(hWritePipe, STARTUPINFO, (A_PtrSize == 4 ? 64 : 96), "Ptr")    ; hStdError
	
	if !DllCall(
	(Join Q C
		"CreateProcess",             ; http://goo.gl/9y0gw
		"Ptr",  0,                   ; lpApplicationName
		"Ptr",  &cmd,                ; lpCommandLine
		"Ptr",  0,                   ; lpProcessAttributes
		"Ptr",  0,                   ; lpThreadAttributes
		"UInt", true,                ; bInheritHandles
		"UInt", 0x08000000,          ; dwCreationFlags
		"Ptr",  0,                   ; lpEnvironment
		"Ptr",  0,                   ; lpCurrentDirectory
		"Ptr",  &STARTUPINFO,        ; lpStartupInfo
		"Ptr",  &PROCESS_INFORMATION ; lpProcessInformation
	)) {
		DllCall("CloseHandle", "Ptr", hWritePipe)
		DllCall("CloseHandle", "Ptr", hReadPipe)
		return ""
	}

	DllCall("CloseHandle", "Ptr", hWritePipe)
	VarSetCapacity(buffer, 4096, 0)
	while DllCall("ReadFile", "Ptr", hReadPipe, "Ptr", &buffer, "UInt", 4096, "UIntP", dwRead, "Ptr", 0)
		sOutput .= StrGet(&buffer, dwRead, "CP0")

	DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION, 0))         ; hProcess
	DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION, A_PtrSize)) ; hThread
	DllCall("CloseHandle", "Ptr", hReadPipe)
	return sOutput
}


TeamCheck()
{
    strStdOut:=StdOutToVar("curl --insecure https://127.0.0.1:2999/liveclientdata/activeplayer")
	namePos := InStr(strStdOut, "summonerName" , CaseSensitive := true, StartingPos := 1, Occurrence := 1)
    offset=0
    while (char!="""")
    {
        offset:=offset+1
        char:=SubStr(strStdOut, namePos+15+offset, 1)
    }
    nameEndPos:=namePos+offset-1
	lenght:=(nameEndPos-namepos)
	activeplayer := SubStr(strStdOut, namePos+16, lenght)

    strStdOut:=StdOutToVar("curl --insecure https://127.0.0.1:2999/liveclientdata/playerlist")
	activeplayerPos := InStr(strStdOut, activeplayer , CaseSensitive := true, StartingPos := 1, Occurrence := 1)
	teamPos := InStr(strStdOut, "team" , CaseSensitive := true, StartingPos := activeplayerPos, Occurrence := 1)
	team := SubStr(strStdOut, teamPos+8, 5)
	if team=ORDER
	{
		return 1
	}
	if team=CHAOS
	{
		return 2
	}
}

BotInt(side)
{
	send df
	if side=2
	{
		IngameHumanClickR(136, 87) ;clicks blue fountain on the map
		send a
		SleepRandom(2500)
	}
	if side=1
	{
		IngameHumanClickR(158, 66) ;clicks red fountain on the map
		send a
		SleepRandom(2500)
	}
}

BotRecall()
{
	send b ;begin channeling recall
	loop, 32
	{
		PixelSearch, ax, bx, 65, 87, 70, 87, 0x010d07, 10, Fast RGB ;check if very low / dead
		if ErrorLevel=0
		{
			return 0 ;cancel recall
		}
		Else
		{
			sleep 260 ;continue channeling recall
		}
	}
	SleepRandom(1000)
	return 1 ;return success value
}


TimeDisplay(timemessage)
{
    if not (timemessage=0)
    {
        gametime:=timemessage
    }
    GuiControl, Panel:Text, gametime, %gametime%
    return
}


GamestepDisplay(gamestepmessage)
{
    if not (gamestepmessage=0)
    {
        gamestep:=gamestepmessage
    }
    GuiControl, Panel:Text, gamestep, %gamestep%
    return
}


ChampionDisplay(championmessage)
{
    if not (championmessage=0)
    {
        championdisplay:=championmessage
    }
    GuiControl, Panel:Text, championdisplay, %championdisplay%
    return
}


StopDisplay(stopmessage)
{
    if not (stopmessage=0)
    {
        stopmessagedisplay:=stopmessage
    }
    GuiControl, Panel:Text, stopmessagedisplay, %stopmessagedisplay%
    return
}


ChatDisplay(chatmessage)
{
    if not (chatmessage=0)
    {
        chatmessagedisplay:=chatmessage
    }
    GuiControl, Panel:Text, chatmessagedisplay, %chatmessagedisplay%
    return
}


InitGUI()
{
	Gui, Panel:Destroy
	Gui, Panel:Color,Black,000000
	Gui, Panel:Show, x-3 y-27 h1180 w1920, Console
	Gui, Panel:Font,Arial s12
	Gui, Panel:Add, Text, cWhite vgamestep w2000,Current Action: ?
	Gui, Panel:Add, Text, cWhite vstopmessagedisplay w2000, Bot stops playing after this game: No
	Gui, Panel:Add, Text, cWhite vchampiondisplay w2000,Picked Champion: ?
	Gui, Panel:Add, Text, cWhite vchatmessagedisplay w2000, Recent message sent in chat: ?
	Gui, Panel:Add, Text, cWhite vgametime w2000, Game Duration: ? Minutes
	return
}


ClientDisconnectCheck()
{
	PixelSearch, ax, bx, 740, 315, 740, 315, 0xf0e6d2,, Fast RGB
	if ErrorLevel=0
	{
		return 1
	}
	return 0
}


;---------------------------------------------------------------------------------------------------------------------------------------------------------------


ButtonStartBot:
flag=true
Settingspath:=LeagueConfigFolder "\" "check.txt"
if not FileExist(Settingspath)
{
	msgbox, Please apply the settings first, make sure you select the correct Config folder where your League of Legends is installed!
	Gui, Destroy
	goto, start
}
Gui, Submit
FileCopyDir, Config, C:\Riot Games\League of Legends\Config, 1
IniWrite, %username1%, config.ini, section1, username1
IniWrite, %password1%, config.ini, section1, password1
IniWrite, %username2%, config.ini, section1, username2
IniWrite, %password2%, config.ini, section1, password2
IniWrite, %AccountCount%, config.ini, section1, AccountCount
IniWrite, %Yuumi%, config.ini, section2, Yuumi
IniWrite, %Teemo%, config.ini, section2, Teemo
IniWrite, %Taric%, config.ini, section2, Taric
IniWrite, %Sona%, config.ini, section2, Sona
IniWrite, %Soraka%, config.ini, section2, Soraka
IniWrite, %gamemode%, config.ini, section3, gamemode
IniWrite, %mode%, config.ini, section4, mode
IniWrite, %timeperaccountinminutes%, config.ini, section4, timeperaccountinminutes
IniWrite, %sleeptimeafterswitch%, config.ini, section4, sleeptimeafterswitch
IniWrite, %sleeptimebetweenmatch%, config.ini, section4, sleeptimebetweenmatch
IniWrite, %StarttimeH%%StarttimeM%%StarttimeS%, config.ini, section4, starttime
IniWrite, %StoptimeH%%StoptimeM%%StoptimeS%, config.ini, section4, stoptime
IniWrite, %randomsummoners%, config.ini, section4, randomsummoners
IniWrite, %randomrunes%, config.ini, section4, randomrunes
IniWrite, %randomchat%, config.ini, section4, randomchat
IniWrite, %buffergames%, config.ini, section4, buffergames
IniWrite, %fillgames%, config.ini, section5, fillgames
IniWrite, %regulargames%, config.ini, section5, regulargames
if prioritypick=1
{
	IniWrite, Sona, config.ini, section4, prioritypick
}
if prioritypick=2
{
	IniWrite, Teemo, config.ini, section4, prioritypick
}
if prioritypick=3
{
	IniWrite, Taric, config.ini, section4, prioritypick
}
if prioritypick=4
{
	IniWrite, Yuumi, config.ini, section4, prioritypick
}
if prioritypick=5
{
	IniWrite, Soraka, config.ini, section4, prioritypick
}
if prioritypick=6
{
	IniWrite, %A_Space%, config.ini, section4, prioritypick
}
if (Yuumi=0 && Teemo=0 && Taric=0 && Sona=0 && Soraka=0)
msgbox, Please select 1 or more champions.
Gui, Destroy

SleepRandom(2500)
global gamestep="Next action: Bot start"
global stopmessagedisplay="Bot stops playing after this game: No"
global championdisplay="Picked Champion: ?"
global chatmessagedisplay="Recent message sent in chat: ?"
global gametime="Game Duration: ? Minutes"
InitGUI()
IniRead, gamemode, config.ini, section3, gamemode
IniRead, mode, config.ini, section4, mode
if mode=1
{
	SleepingModule()
}
totalgames=0
bottimepass=0
Account=1
SwitchAccount(Account, bots, game)
botstart:=A_TickCount

loop
{
	startqueue:
	WinActivate, League of Legends ahk_exe LeagueClientUx.exe
	loop
	{
		PixelSearch, ei, fi, 530, 656, 530, 656, 0x18838b, 10, Fast RGB
		if ErrorLevel=0
		{
			HumanClickL(540, 680)
			MouseMove, 0, 0
			goto, inqueue
		}
		else
		{
			sleep 100
		}
	}
	
	inqueue:
	ChampionDisplay("Champion: "-)
	GamestepDisplay("Waiting in Queue...")
	RestartBot=0
	loop
	{
		if ClientDisconnectCheck()=1
		{		
			SwitchAccount(Account, bots, game)
			Goto, startqueue
		}
		if not WinExist("League of Legends")
		{
			RestartBot:=RestartBot+1
			if RestartBot>=200
			{		
				SwitchAccount(Account, bots, game)
				goto, startqueue
			}
		}
		imagesearch, eix, fix, 400, 200, 1080, 720, *25 Images\ok3.png
		if ErrorLevel=0
		{
			a:=Randomizer(eix)
			b:=Randomizer(fix)
			click, %a% %b% Left
			MouseMove, 0, 0
			SleepRandom(2000)
		}
		send {Space}
		PixelSearch, ei, fi, 530, 656, 530, 656, 0x18838b, 10, Fast RGB
		if ErrorLevel=0
		{
			goto, startqueue
		}
		PixelSearch, matchx, matchy, 510, 510, 750, 600, 0x1e252a,, Fast RGB ;detect Match
		if ErrorLevel=0
		{
			HumanClickL(600, 550)
			SleepRandom(150)
			MouseMove, 0, 0
		}
		PixelSearch, ci, di, 620, 50, 660, 80, 0xF0E6D2,, Fast RGB
		if ErrorLevel=0
		{
			goto, inlobby
		}
	}


	inlobby:
	GamestepDisplay("In Champ select...")
	WinActivate, League of Legends ahk_exe LeagueClientUx.exe
	IniRead, priority, config.ini, section4, prioritypick
	IniRead, Teemo, config.ini, section2, Teemo
	IniRead, Taric, config.ini, section2, Taric
	IniRead, Yuumi, config.ini, section2, Yuumi
	IniRead, Sona, config.ini, section2, Sona
	IniRead, Soraka, config.ini, section2, Soraka
	IniRead, randomrunes, config.ini, section4, randomrunes
	IniRead, randomsummoners, config.ini, section4, randomsummoners
	IniRead, randomchat, config.ini, section4, randomchat
	RestartBot=0
	Loop
	{
		if ClientDisconnectCheck()=1
		{		
			SwitchAccount(Account, bots, game)
			Goto, startqueue
		}
		if QueueCheck()=1
		{
			goto, inqueue
		}
		if QueueCheck()=2
		{
			goto, startqueue
		}
		PixelSearch, kj, mj, 828, 36, 828, 36, 0xE9E5D1, 5, Fast RGB
		if ErrorLevel=0
		{
			break
		}
	}
	PickedChampion:=PickChampion()
	if (PickedChampion!=None)
	{
		ChampionDisplay("Champion: "PickedChampion)
		HumanClickL(385, 185)
		SleepRandom(1000)
		loop
		{
			ImageSearch, ax, ay, 0, 0, A_ScreenWidth, A_ScreenHeight, *30 Images\close4.png
			if ErrorLevel=0
			{
				HumanClickL(ax, ay)
			}
			if QueueCheck()=1
			{
				goto, inqueue
			}
			if QueueCheck()=2
			{
				goto, startqueue
			}
			HumanClickL(610, 600)
			SleepRandom(250)
			MouseMove, 0, 0
			imagesearch, ei, fi, 0, 0, A_ScreenWidth, A_ScreenHeight, *18 Images\clickpick.png
			if ErrorLevel=1
			break
		}
		SleepRandom(1000)
		if randomchat=1
		{
			champselectrandommessage()
			SleepRandom(1000)
		}
		if randomsummoners=1
		{
			RandomSummoner(1)
			SleepRandom(1000)
			RandomSummoner(2)
			SleepRandom(1000)
		}
		if QueueCheck()=1
		{
			goto, inqueue
		}
		if QueueCheck()=2
		{
			goto, startqueue
		}
		if randomrunes=1
		{
			RandomRunes()
		}
		loop
		{
			PixelSearch, ax, bx, 781, 399, 781, 399, 0x010A13,, Fast RGB
			if ErrorLevel=0
			{
				HumanClickL(640, 390)
			}
			if ClientDisconnectCheck()=1
			{		
				SwitchAccount(Account, bots, game)
				Goto, startqueue
			}
			GamestepDisplay("Waiting for Game to start...")
			WinActivate, League of Legends ahk_exe LeagueClientUx.exe
			sleep 250
			HumanClickL(470, 360) ;click Reconnect button (even if not present)
			WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
			sleep 250
			if QueueCheck()=1
			{
				goto, inqueue
			}
			if QueueCheck()=2
			{
				goto, startqueue
			}
			CoordMode, Mouse, Screen
			mousemove, A_ScreenWidth/2, A_ScreenHeight/2
			click, Right
			CoordMode, Mouse, Relative
			PixelSearch, ci, di, 137, 0, 137, 0, 0xceae63, 5, Fast RGB
			if ErrorLevel=0
			{
				WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
				SleepRandom(150)
				goto, ingame
			}
			if ErrorLevel=1
			{
				SleepRandom(4000)
			}
		}
	}
	Else
	{
		Loop
		{
			if QueueCheck()=1
			{
				goto, inqueue
			}
			if QueueCheck()=2
			{
				goto, startqueue
			}
		}
	}


;----------------------------------------------------------------------------------------------------------------------------------;

	ingame:
	gamestart:=A_TickCount
	GamestepDisplay("Ingame - Playing")
	WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
	CoordMode, Pixel, Relative
	CoordMode, Mouse, Relative
	SleepRandom(1000)
	team:=TeamCheck()
	Global RecallChannel=0
	GameDisconnect=0
	ChampIndex=0
	if randomchat=1
	{
		SleepRandom(1500)
		ingamerandommessage()
		SleepRandom(2500)
	}

	InitialSpellLevel%PickedChampion%()

	ResumePlaying:
	loop
	{
		WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
		if not WinExist("League of Legends (TM)")
		{
			goto, aftergame
		}
		TimeDisplay("Game Duration: " ingametime_m " Minutes")
		Random, Chance, 1, 2
		if (Chance=2 && ingametime_m<=20)
		{
			PixelSearch, ax, bx, 0, 0, 133, 78, 0xf2d65d,, Fast, RGB
			if ErrorLevel=0
			{
				%PickedChampion%Explore(team, ChampIndex)
			}
		}
		
		LoopCount:=LoopRandom(30)
		loop, %LoopCount%
		{
			GameDisconnectCheck(GameDisconnect)
			if GameDisconnect>=200
			{
				Process, Close, League of legends.exe
			}
			if GetKeyState("i", "P")
			{
				StopDisplay("Bot stops playing after this game: Yes")
				k=1
			}
			ingametime_m:=Floor((A_TickCount-gamestart)/60000)+1
			if not WinExist("League of Legends (TM)")
			{
				goto, aftergame
			}

			if ingametime_m>=20
			{
				ChampIndex=1
			}
			PixelSearch, xx, xy, 154-ChampIndex*6, 58, 154-ChampIndex*6, 58, 0x8b8c8b, 20, Fast RGB ;check if allyX is dead
			if ErrorLevel=0
			{
				RecallChannel:=%PickedChampion%Retreat(team, RecallChannel) ;increase recall score every time the bot clicks to base to recall
				if RecallChannel>=25
				{
					RecallChannel=0
					if BotRecall()=1 ;recall after 50 clicks ~ 10 seconds of walking to base
					{
						AttemptShopping%PickedChampion%()
					}
				}
				PixelSearch, ax, bx, 65, 87, 65, 87, 0x010d07, 10, Fast RGB ;check if dead
				if ErrorLevel=0
				{
					AttemptShopping%PickedChampion%()
					SleepRandom(1200)
					if randomchat=1
					{
						SleepRandom(1500)
						ingamerandommessage()
						SleepRandom(2500)
					}
				}
				SleepRandom(100)
			}
			Else
			{
				%PickedChampion%Logic(team, ChampIndex, ingametime_m)
			}
		}
		PixelSearch, ax, bx, 0, 0, 133, 78, 0x3E0700, 5, Fast, RGB ;check for enemies on screen
		if ErrorLevel=0
		{
			%PickedChampion%Attack()
		}
	}


;-------------------------------------------------------------------------------------------------------------;

	aftergame:
	sleep 25000
	loop, 20
	{
		WinActivate, League of Legends ahk_exe LeagueClientUx.exe
		sleep 250
		MouseMove, 0, 0
		PixelSearch, ReconnectX, ReconnectY, 470, 360, 470, 360, 0x1E2328, 5, Fast RGB ;Check for reconnect button
		if !ErrorLevel
		{
			Loop
			{
				HumanClickL(470, 360)
				WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
				sleep 1000
				if WinExist("League of Legends (TM)")
				{
					break
				}
				sleep 5000
			}
			Goto, ResumePlaying
		}
		sleep 1000
	}
	GamestepDisplay("Game ended - concluding")
	ChampionDisplay("Picked Champion: ?")
	%PickedChampion%ResetItemsBought()
	IniRead, sleeptimeswitch, config.ini, section4, sleeptimeafterswitch
	IniRead, starttime, config.ini, section4, starttime
	IniRead, stoptime, config.ini, section4, stoptime
	IniRead, buffergames, config.ini, section4, buffergames
	game:=game+1
	totalgames:=totalgames+1
	RestartBot=0
    if k=1
    {
		msgbox, stopped.
        ExitApp
    }
	loop
	{
		if not WinExist("League of Legends")
		{
			RestartBot:=RestartBot+1
			if RestartBot>=25
			{		
				SwitchAccount(Account, bots, game)
				break
			}
		}
		if ClientDisconnectCheck()=1
		{		
			SwitchAccount(Account, bots, game)
			break
		}
		WinActivate, League of Legends ahk_exe LeagueClientUx.exe
		SleepRandom(150)
		CoordMode, Mouse, Screen
		CoordMode, Pixel, Screen
		SleepRandom(150)
		mousemove, A_ScreenWidth/2, A_ScreenHeight/2
		click, Right
		CoordMode, Mouse, Relative
		CoordMode, Pixel, Relative
		SleepRandom(150)
		HumanClickL(30, 380)
		SleepRandom(2000)
		CleanPopups()
		SleepRandom(150)
		PixelSearch, ei, fi, 470, 685, 625, 685, 0xA3C7C7,, Fast RGB
		if ErrorLevel=0
		{
			if randomchat=1
			{
				postgamerandommessage()
				SleepRandom(1000)
			}
			loop, 10
			{
				SleepRandom(1000)
				HumanClickL(540, 680)
				SleepRandom(1000)
				MouseMove, 0, 0
				PixelSearch, ei, fi, 470, 685, 625, 685, 0xA3C7C7,, Fast RGB
				if ErrorLevel=1
				{
					break
				}
			}
			SleepRandom(10000)
			IniRead, fillgames, config.ini, section5, fillgames
			IniRead, regulargames, config.ini, section5, regulargames
			if (game>=regulargames && bots=0 && buffergames=1)
			{
				SleepRandom(10000)
				RankedtoBotQueue(Account, bots, game)
			}
			if (game>=fillgames && bots=1 && buffergames=1)
			{
				IniRead, gamemode, config.ini, section3, gamemode
				SwitchAccount(Account, bots, game)
			}
			timenow := A_Now
			timenowmode2 := A_TickCount
    		timenow := SubStr(timenow, 9, 10)
			bottimepass := (timenowmode2-botstart)
			IniRead, mode, config.ini, section4, mode
			IniRead, timeperaccountM, config.ini, section4, timeperaccountinminutes
			timeperaccount:=timeperaccountM*60000

			IniRead, accountCount, config.ini, section1, accountCount

			if mode=1
			{
				if (starttime > stoptime)
				{
					if !((timenow >= starttime and timenow <= 235959) or (timenow >= 000000 and timenow <= stoptime))
					{
						Account := Mod( Account, accountCount) + 1
						TerminateClient()
						GamestepDisplay("Finished playing for today, sleeping...")
						SleepingModule()
						SwitchAccount(Account, bots, game)
						botstart:=A_TickCount
						bottimepass=0
						goto, startqueue
					}
				}
				else
				{
					if !(timenow >= starttime and timenow <= stoptime) 
					{
						Account := Mod( Account, accountCount) + 1
						TerminateClient()
						GamestepDisplay("Finished playing for today, sleeping...")
						SleepingModule()
						SwitchAccount(Account, bots, game)
						botstart:=A_TickCount
						bottimepass=0
						goto, startqueue
					}
				}
			}
			Else
			{
				if (bottimepass > timeperaccount)
				{
					TerminateClient()
					c:=(sleeptimeswitch*1000*60)/300
					startsleep:=A_TickCount
					c:=SmallTimeRandom(c)
					cshow:=(c*300)/60000
					GamestepDisplay("Finished playing, sleeping...")
					Loop, 300
						{
						send {Space up}
						sleep, %c%
						send {Space}
						}
					cshow:=
					Account := Mod( Account, accountCount) + 1
					SwitchAccount(Account, bots, game)
					botstart:=A_TickCount
					bottimepass=0
					goto, startqueue
				}
			}
		GamestepDisplay("Finished a game, waiting to start next one...")
		IniRead, sleeptimematch, config.ini, section4, sleeptimebetweenmatch
		c:=(sleeptimematch*1000*60)/100
		c:=SmallTimeRandom(c)
		Loop, 100
			{
			send {Space up}
			sleep, %c%
			send {Space}
			}
		goto, startqueue
		}
		else
		{
			SleepRandom(1000)
		}
	}
}


!o::
msgbox, stopped!
ExitApp


#k::
if flag=false
{
	return
}
flag=false
IniRead, starttime, config.ini, section4, starttime
IniRead, stoptime, config.ini, section4, stoptime
IniRead, mode, config.ini, section4, mode
IniRead, displayUsername, config.ini, section1, username%Account%
IniRead, timeperaccountM, config.ini, section4, timeperaccountinminutes
Sta1 := SubStr(starttime, 1, 2)
Sta2 := SubStr(starttime, 3, 2)
Sta3 := SubStr(starttime, 5, 2)
Sto1 := SubStr(stoptime, 1, 2)
Sto2 := SubStr(stoptime, 3, 2)
Sto3 := SubStr(stoptime, 5, 2)
sleptnow := A_TickCount
sleepleft := Floor((sleptnow-startsleep)/60000)
bottimepassM := Floor(bottimepass/60000)
Gui, Panel:Destroy
Gui, Paused:Destroy
Gui, Paused:Add, Picture, w100 h100, Images\NoTeemo.png
Gui, Paused:Font, s14
Gui, Paused:Add, Text,,This is the debug report for the bot:
Gui, Paused:Add, text,,I am playing on account "%displayUsername%" and played %game% Games so far.
Gui, Paused:Add, text,,Since the start i played %totalgames% Games!
Gui, Paused:Add, text,,I started botting %bottimepassM% Minutes ago!
if mode=1
{
	Gui, Paused:Add, text,,I can play from %Sta1%:%Sta2%:%Sta3% until %Sto1%:%Sto2%:%Sto3%.
}
Else
{
	if cshow
	{
		Gui, Paused:Add, text,,I have been sleeping %sleepleft% ouf of %cshow% Minutes right now!
	}
	Else
	{
		Gui, Paused:Add, text,,I played %bottimepassM% out of %timeperaccountM% Minutes right now!
	}
}
Gui, Paused:Add, Button, default xm, Continue Running
Gui, Paused:Show,, Paused
while (flag="false")
{
	sleep 250
}
return
PausedGuiClose:
PausedButtonContinueRunning:
flag=true
Gui, Paused:Destroy
InitGUI()
TimeDisplay(0)
GamestepDisplay(0)
StopDisplay(0)
ChatDisplay(0)
ChampionDisplay(0)
WinActivate, Riot Client ahk_exe RiotClientUx.exe
SleepRandom(100)
WinActivate, League of Legends ahk_exe LeagueClientUx.exe
SleepRandom(100)
WinActivate, League of Legends (TM) Client ahk_exe League of Legends.exe
SleepRandom(100)
return