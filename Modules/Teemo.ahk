#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative

InitialSpellLevelTeemo()
{
	SleepRandom(500)
	send ^q
	SleepRandom(100)
	AttemptShoppingTeemo()
}

TeemoExplore(side, ChampIndex)
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

TeemoAttack()
{
	PixelSearch, ax, bx, 80, 87, 75, 87, 0x010d07, 10, Fast RGB ;check own HP
	if ErrorLevel=0
	{
		return
	}
	RandomClickR(80, 45)
	SleepRandom(100)
	send q4
	return
}

TeemoLogic(side, ChampIndex, gametime)
{
	Target:="f"5-ChampIndex
	send {%Target% down} ;centers camera on teammate to follow
	PixelSearch, ax, bx, 78, 87, 75, 87, 0x010d07, 10, Fast RGB 
	if ErrorLevel=0
	{
		RecallChannel:=TeemoRetreat(side, RecallChannel)
		if RecallChannel>=25
		{
			RecallChannel=0
			if BotRecall()=1 ;recall after 40 clicks ~ 10 seconds of walking to base
			{
				AttemptShoppingTeemo()
			}
		}
		SleepRandom(100)
	}
	Else
	{
		RecallChannel=0
		send qwr
		HumanClickR(80, 45)
		SleepRandom(50)
		send ^r^w^e^q
		send {%Target% up}
		SleepRandom(100)
	}
	Return
}

TeemoRetreat(side, RecallChannel)
{
	send wdf
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

Global TeemoitemsBought=0

AttemptShoppingTeemo()
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

	while(TeemoitemsBoughtOld!=TeemoitemsBought)
	{
		if not WinExist("League of Legends (TM)")
		{
			return ;ends function early if the game ended
		}
		TeemoitemsBoughtOld:=TeemoitemsBought
		switch TeemoitemsBought
		{
			case 0:TeemoitemsBought+=TeemobuyItem("spellthief",450)
			case 1:TeemoitemsBought+=TeemobuyItem("oracle",0)
			case 2:TeemoitemsBought+=TeemobuyItem("sapphire",350)
			case 3:TeemoitemsBought+=TeemobuyItem("null-magic mantle",450)
			case 4:TeemoitemsBought+=TeemobuyItem("mercury",650)
			case 5:TeemoitemsBought+=TeemobuyItem("lost chapter",950)
			case 6:TeemoitemsBought+=TeemobuyItem("amplifying tome",435)
			case 7:TeemoitemsBought+=TeemobuyItem("fiendish codex",465)
			case 8:TeemoitemsBought+=TeemobuyItem("liandry",1000)
			case 9:TeemoitemsBought+=TeemobuyItem("giant",900)
			case 10:TeemoitemsBought+=TeemobuyItem("blasting wand",850)
			case 11:TeemoitemsBought+=TeemobuyItem("demonic embrace",1250)
			case 12:TeemoitemsBought+=TeemobuyItem("phage",1100)
			case 13:TeemoitemsBought+=TeemobuyItem("sterak",2000)

			default: TeemobuyItem("",0)
		}
	}
	return
}

TeemobuyItem(itemName, itemCost)
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

TeemoResetItemsBought()
{
	TeemoitemsBought=0
}