#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative


InitialSpellLevelSona()
{
	SleepRandom(500)
	send ^q4
	SleepRandom(100)
	AttemptShoppingSona()
}

SonaExplore(side, ChampIndex)
{
	send {Space up}
	Target:="f"5-ChampIndex
	send {%Target% up} ;unfocusing teammate with camera
	sleep 150
	send {Space down}
	LoopCount:=LoopRandom(15)
	loop, %LoopCount%
	{
		PixelSearch, xx, xy, 154-ChampIndex*6, 58, 154-ChampIndex*6, 58, 0x8b8c8b, 20, Fast RGB ;check if allyX is dead
		if ErrorLevel=0
		{
			break
		}
		PixelSearch, ax, bx, 0, 0, 133, 78, 0x3E0700,, Fast, RGB
		if ErrorLevel=0
		{
			break
		}
		PixelSearch, ax, bx, 83, 87, 75, 87, 0x010d07, 10, Fast RGB
		if ErrorLevel=0
		{
			break
		}
		if side=1
		{
			RandomClickR(85, 40)
		}
		Else
		{
			RandomClickR(75, 50)
		}
		SleepRandom(200)
		send aq
	}
	send {Space up}
	return
}

SonaAttack()
{
	PixelSearch, ax, bx, 80, 87, 75, 87, 0x010d07, 10, Fast RGB
	if ErrorLevel=0
	{
		return
	}
	send q
	SleepRandom(100)
	send e4
	return
}

SonaLogic(side, ChampIndex, gametime)
{
	Target:="f"5-ChampIndex
	send {%Target% down} ;centers camera on teammate to follow
	PixelSearch, ax, bx, 78, 87, 75, 87, 0x010d07, 10, fast RGB 
	if ErrorLevel=0
	{
		RecallChannel:=SonaRetreat(side, RecallChannel)
		if RecallChannel>=25
		{
			RecallChannel=0
			if BotRecall()=1 ;recall after 40 clicks ~ 10 seconds of walking to base
			{
				AttemptShoppingSona()
			}
		}
		SleepRandom(100)
	}
	Else
	{
		RecallChannel=0
		send r
		PixelSearch, xx, xy, 157-ChampIndex*6, 62, 157-ChampIndex*6, 62, 0x131313,, Fast RGB ;checks if ally lost hp
		if (ErrorLevel=0 or gametime>=15)
		{
			send w
		}
		HumanClickR(80, 45)
		SleepRandom(50)
		send ^r^w^e^q
		send {%Target% up}
		SleepRandom(100)
	}
	Return
}

SonaRetreat(side, RecallChannel)
{
	send wedf
	if side=1
	{
		IngameHumanClickR(136, 87) ;clicks blue fountain on the map
	}
	if side=2
	{
		IngameHumanClickR(158, 66) ;clicks red fountain on the map
	}
	SleepRandom(100)
	return RecallChannel+1 ;increase recall score...
}


Global SonaitemsBought=0

AttemptShoppingSona()
{

	if not WinExist("League of Legends (TM)")
	{
		return ;ends function early if the game ended
	}
	PixelSearch, ax, by, 0, 0, 160, 90, 0x705729,, Fast RGB ;checking for opened shop window
	if ErrorLevel=0
	{
		send {Escape} ;closing shop if shop window exists
		SleepRandom(500)
	}

	while(SonaitemsBoughtOld!=SonaitemsBought)
	{
		if not WinExist("League of Legends (TM)")
		{
			return ;ends function early if the game ended
		}
		SonaitemsBoughtOld:=SonaitemsBought
		switch SonaitemsBought
		{
			case 0:SonaitemsBought+=SonabuyItem("spellthief",450)
			case 1:SonaitemsBought+=SonabuyItem("oracle",0)
			case 2:SonaitemsBought+=SonabuyItem("amplifying tome",435)
			case 3:SonaitemsBought+=SonabuyItem("mantle",450)
			case 4:SonaitemsBought+=SonabuyItem("treads",650)
			case 5:SonaitemsBought+=SonabuyItem("faerie charm",250)
			case 6:SonaitemsBought+=SonabuyItem("bandleglass mirror",265)
			case 7:SonaitemsBought+=SonabuyItem("ruby crystal",400)
			case 8:SonaitemsBought+=SonabuyItem("kindlegem",400)
			case 9:SonaitemsBought+=SonabuyItem("moonstone renewer",750)
			case 10:SonaitemsBought+=SonabuyItem("amplifying tome",435)
			case 11:SonaitemsBought+=SonabuyItem("forbidden idol",800)
			case 12:SonaitemsBought+=SonabuyItem("amplifying tome",435)
			case 13:SonaitemsBought+=SonabuyItem("ardent censer",630)
			case 14:SonaitemsBought+=SonabuyItem("amplifying tome",435)
			case 15:SonaitemsBought+=SonabuyItem("forbidden idol",800)
			case 16:SonaitemsBought+=SonabuyItem("staff of flowing water",1065)

			default: SonabuyItem("",0)
		}
	}
	return
}

SonabuyItem(itemName, itemCost)
{
	if not WinExist("League of Legends (TM)")
		{
		return 0
		}
	
	strStdOut:=StdOutToVar("curl --insecure https://127.0.0.1:2999/liveclientdata/activeplayer")
	goldPos := InStr(strStdOut, "currentGold" , CaseSensitive := true, StartingPos := 1, Occurrence := 1)
	offset=0
	while (char!=".")
	{
		if not WinExist("League of Legends (TM)")
		{
			return 0 ;ends function early if the game ended
		}
		offset:=offset+1
	   	char:=SubStr(strStdOut, goldPos+12+offset, 1)
	}
	goldEndPos:=goldPos+offset-2
	lenght:=(goldEndPos-goldPos)
	currentGold := SubStr(strStdOut, goldPos+14, lenght)

	if (currentGold>itemCost)
		{

		send p
		SleepRandom(500)
		send ^l
		SleepRandom(500)
		send %itemName%
		SleepRandom(500)
		send {enter}
		SleepRandom(500)
		send {escape}
		SleepRandom(500)
		return 1
		}
	
	return 0
}

SonaResetItemsBought()
{
	SonaitemsBought=0
}