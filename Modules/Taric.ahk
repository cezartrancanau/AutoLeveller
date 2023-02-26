#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative

InitialSpellLevelTaric()
{
	SleepRandom(500)
	send ^e
	SleepRandom(250)
	AttemptShoppingTeemo()
}

TaricExplore(side, ChampIndex)
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
		send a
	}
	send {Space up}
	return
}

TaricAttack()
{
	PixelSearch, ax, bx, 80, 87, 75, 87, 0x010d07, 10, Fast RGB
	if ErrorLevel=0
	{
		return
	}
	RandomClickR(80, 45)
	send e4
	SleepRandom(250)
	return
}

TaricLogic(side, ChampIndex, gametime)
{
	Target:="f"5-ChampIndex
	send {%Target% down} ;centers camera on teammate to follow
	PixelSearch, ax, bx, 78, 87, 75, 87, 0x010d07, 10, Fast RGB ;check if low
	if ErrorLevel=0
	{
		RecallChannel:=TaricRetreat(side, RecallChannel)
		if RecallChannel>=25
		{
			RecallChannel=0
			if BotRecall()=1 ;recall after 40 clicks ~ 10 seconds of walking to base
			{
				AttemptShoppingTaric()
			}
		}
		SleepRandom(100)
	}
	Else
	{
		PixelSearch, xx, xy, 157-ChampIndex*6, 62, 157-ChampIndex*6, 62, 0x131313,, Fast RGB ;checks if ally lost hp
		if (ErrorLevel=0 or gametime>=15)
		{
			RecallChannel=0
			send q
			SleepRandom(100)
			MouseMove, 155-ChampIndex*6, 60 ;target ally
			SleepRandom(100)
			send w
			SleepRandom(100)
		}
		HumanClickR(80, 45)
		SleepRandom(50)
		send ^r^q^w^e
		send {%Target% up}
		SleepRandom(100)
	}
	Return
}

TaricRetreat(side, RecallChannel)
{
	send qrdf
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

Global TaricitemsBought=0

AttemptShoppingTaric()
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

	while(TaricitemsBoughtOld!=TaricitemsBought)
	{
		if not WinExist("League of Legends (TM)")
		{
			return ;ends function early if the game ended
		}
		TaricitemsBoughtOld:=TaricitemsBought
		switch TaricitemsBought
		{
			case 0:TaricitemsBought+=TaricbuyItem("",450)
			case 1:TaricitemsBought+=TaricbuyItem("oracle",0)
			case 2:TaricitemsBought+=TaricbuyItem("tear",400)
			case 3:TaricitemsBought+=TaricbuyItem("mantle",450)
			case 4:TaricitemsBought+=TaricbuyItem("treads",650)
			case 5:TaricitemsBought+=TaricbuyItem("cloth",300)
			case 6:TaricitemsBought+=TaricbuyItem("sapphire",350)
			case 7:TaricitemsBought+=TaricbuyItem("glacial",250)
			case 8:TaricitemsBought+=TaricbuyItem("cloth",300)
			case 9:TaricitemsBought+=TaricbuyItem("warden",700)
			case 10:TaricitemsBought+=TaricbuyItem("frozen",600)
			case 11:TaricitemsBought+=TaricbuyItem("kindlegem",800)
			case 12:TaricitemsBought+=TaricbuyItem("approach",1400)
			case 13:TaricitemsBought+=TaricbuyItem("kindlegem",800)
			case 14:TaricitemsBought+=TaricbuyItem("of the leg",1400)
			case 15:TaricitemsBought+=TaricbuyItem("Evenshroud",300)

			default: TaricbuyItem("",0)
		}
	}
	return
}

TaricbuyItem(itemName, itemCost)
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

TaricResetItemsBought()
{
	TaricitemsBought=0
}