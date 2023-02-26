#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative

InitialSpellLevelSoraka()
{
	SleepRandom(500)
	send ^w ;level up W spell
	SleepRandom(100)
	AttemptShoppingSoraka()
}

SorakaExplore(side, ChampIndex)
{
	send {Space up} ;key resetting
	Target:="f"5-ChampIndex
	send {%Target% up} ;unfocusing teammate with camera
	sleep 150
	send {Space down} ;center camera on self
	LoopCount:=LoopRandom(8)
	loop, %LoopCount%
	{
		PixelSearch, xx, xy, 154-ChampIndex*6, 58, 154-ChampIndex*6, 58, 0x8b8c8b, 20, Fast RGB ;check if allyX is dead
		if ErrorLevel=0
		{
			break
		}
		PixelSearch, ax, bx, 0, 0, 133, 78, 0x3E0700,, Fast, RGB ;check for enemies on screen
		if ErrorLevel=0
		{
			break
		}
		PixelSearch, ax, bx, 83, 87, 75, 87, 0x010d07, 10, Fast RGB ;check own HP
		if ErrorLevel=0
		{
			break
		}
		RandomClickR(80, 45) ;wander around
		SleepRandom(200)
		send aq ;attack nearest + press Q
	}
	send {Space up}
	return
}

SorakaAttack()
{
	PixelSearch, ax, bx, 80, 87, 75, 87, 0x010d07, 10, Fast RGB
	if ErrorLevel=0
	{
		return
	}
	RandomClickL(80, 45) ;clicks in a Random spot within a 10x10 Area around the Pixel(80, 45) and presses Q + activates trinket
	SleepRandom(100)
	send q4
	return
}

SorakaLogic(side, ChampIndex, gametime)
{
	Target:="f"5-ChampIndex
	send {%Target% down} ;centers camera on teammate to follow
	PixelSearch, ax, bx, 78, 87, 75, 87, 0x010d07, 10, Fast RGB ;checks for own HP specifically if below 65% HP
	if ErrorLevel=0
	{
		RecallChannel:=SonaRetreat(side, RecallChannel) ;increase recall score every time the bot clicks to base to recall
		if RecallChannel>=25
		{
			RecallChannel=0
			if BotRecall()=1 ;recall after 40 clicks ~ 10 seconds of walking to base
			{
				AttemptShoppingSoraka()
			}
		}
		SleepRandom(100)
	}
	Else
	{
		RecallChannel=0 ;resets Recall score
		HumanClickR(80, 45) ;camera centered on target ally, movement click
		SleepRandom(50)
		PixelSearch, xx, xy, 157-ChampIndex*6, 62, 157-ChampIndex*6, 62, 0x131313,, Fast RGB ;checks if ally lost hp
		if ErrorLevel=0
		{
			send r ;use ult if ally is low
			MouseMove, 155-ChampIndex*6, 60 ;target ally
			SleepRandom(100)
			send w ;press w to heal said ally
		}
		send ^r^q^w^e ;level up spells with priority
		send {%Target% up} ;resets camera focus ingame
		SleepRandom(100)
	}
	Return
}

SorakaRetreat(side, RecallChannel) ;function to retreat to base
{
	send rdf ;using spells
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

Global SorakaitemsBought=0

AttemptShoppingSoraka()
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

	while(SorakaitemsBoughtOld!=SorakaitemsBought)
	{
		if not WinExist("League of Legends (TM)")
		{
			return ;ends function early if the game ended
		}
		SorakaitemsBoughtOld:=SorakaitemsBought
		switch SorakaitemsBought
		{
			case 0:SorakaitemsBought+=SorakabuyItem("spellthief",450)
			case 1:SorakaitemsBought+=SorakabuyItem("oracle",0)
			case 2:SorakaitemsBought+=SorakabuyItem("amplifying tome",435)
			case 3:SorakaitemsBought+=SorakabuyItem("mantle",450)
			case 4:SorakaitemsBought+=SorakabuyItem("treads",650)
			case 5:SorakaitemsBought+=SorakabuyItem("faerie charm",250)
			case 6:SorakaitemsBought+=SorakabuyItem("bandleglass mirror",265)
			case 7:SorakaitemsBought+=SorakabuyItem("ruby crystal",400)
			case 8:SorakaitemsBought+=SorakabuyItem("kindlegem",400)
			case 9:SorakaitemsBought+=SorakabuyItem("moonstone renewer",750)
			case 10:SorakaitemsBought+=SorakabuyItem("amplifying tome",435)
			case 11:SorakaitemsBought+=SorakabuyItem("forbidden idol",800)
			case 12:SorakaitemsBought+=SorakabuyItem("amplifying tome",435)
			case 13:SorakaitemsBought+=SorakabuyItem("ardent censer",630)
			case 14:SorakaitemsBought+=SorakabuyItem("amplifying tome",435)
			case 15:SorakaitemsBought+=SorakabuyItem("forbidden idol",800)
			case 16:SorakaitemsBought+=SorakabuyItem("staff of flowing water",1065)

			default: SorakabuyItem("",0)
		}
	}
	return
}

SorakabuyItem(itemName, itemCost)
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

SorakaResetItemsBought()
{
	SorakaitemsBought=0
}