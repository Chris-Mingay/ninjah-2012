Import raz
Import ninjah

Class AppState

	

	Const L_CLOSED:Int = 0
	Const L_OPEN:Int = 1
	Const L_COMPLETED:Int = 2
	Const L_BEST_BEATEN:Int = 3

	Const LevelCount:Int = 50
	Const TimesPerLevel:Int = 5

	Global BestTimes:Int[]
	Global LevelStates:Int[]
	Global LevelTimes:Int[][]
	
	Global AllBest:Bool = False
	Global AllComplete:Bool = False
	
	Global Options:StringMap<IntObject>
	
	Function Init:Void()
		LevelStates = New Int[LevelCount]
		LevelTimes = New Int[LevelCount][]
		For Local i:Int = 0 To (LevelCount - 1)
			LevelTimes[i] = New Int[TimesPerLevel]
		Next
		Options = New StringMap<IntObject>
		
		' BEST TIMES
		BestTimes = New Int[LevelCount]
		BestTimes[0] = 4944
		BestTimes[1] = 2608
		BestTimes[2] = 3424
		BestTimes[3] = 1620
		BestTimes[4] = 7928
		BestTimes[5] = 7200
		BestTimes[6] = 7596
		BestTimes[7] = 5136
		BestTimes[8] = 7052
		BestTimes[9] = 2068
		
		BestTimes[10] = 5976
		BestTimes[11] = 19428
		BestTimes[12] = 8092
		BestTimes[13] = 57876
		BestTimes[14] = 2296
		BestTimes[15] = 6524
		BestTimes[16] = 4244
		BestTimes[17] = 27868
		BestTimes[18] = 11344
		BestTimes[19] = 5228
		
		BestTimes[20] = 11112
		BestTimes[21] = 17884
		BestTimes[22] = 18632
		BestTimes[23] = 66252
		BestTimes[24] = 12696
		BestTimes[25] = 36484
		BestTimes[26] = 9620
		BestTimes[27] = 20588
		BestTimes[28] = 98652
		BestTimes[29] = 10152
		
		BestTimes[30] = 11812
		BestTimes[31] = 7500
		BestTimes[32] = 2276
		BestTimes[33] = 54044
		BestTimes[34] = 45028
		BestTimes[35] = 18596
		BestTimes[36] = 3320
		BestTimes[37] = 24992
		BestTimes[38] = 82232
		BestTimes[39] = 12264
		
		BestTimes[40] = 3032
		BestTimes[41] = 11192
		BestTimes[42] = 24364
		BestTimes[43] = 2748
		BestTimes[44] = 29696
		BestTimes[45] = 12552
		BestTimes[46] = 17404
		BestTimes[47] = 39560
		BestTimes[48] = 18852
		BestTimes[49] = 27752
		
	End
	
	Function OpenNextLevel:Void()
		For Local i:Int = 0 To LevelCount - 1
			If LevelStates[i] = L_CLOSED
				LevelStates[i] = L_OPEN
				Exit;
			EndIf
		Next
	End

	Function Load:Void()
		Local txt:String = LoadState()
		txt = DecodeBase64(txt)
		Local Created:Bool = False
		If txt.Length() = 0 or txt[0 .. 8] <> "hellodoy"
			txt = Create()
			
			Created = True
		End
		
		Local settings:String[] = txt.Split(",")
		Local gi:Int = 1
		Local AllFinished:Bool = True
		For Local i:Int = 0 To (LevelCount - 1)
			LevelStates[i] = Int(settings[gi])
			If LevelStates[i] < L_COMPLETED
				AllFinished = False
			EndIf
			gi+=1
		Next
		
		If AllFinished = True
			AppState.AllComplete = True
			LevelSelector.CanChangeOptions = True
			LevelSelector.ChangeOptionsAlpha = 1
		EndIf
		
		For Local yi:Int = 0 To (LevelCount - 1)
			For Local xi:Int = 0 To (TimesPerLevel - 1)
				LevelTimes[yi][xi] = Int(settings[gi])
				gi+=1
			Next
		Next
		'Options.Set("option_1",Int(settings[gi]))
		MySoundSystem.Volume = Float(settings[gi])
		gi+=1
		'Options.Set("option_2",Int(settings[gi]))
		MySoundSystem.MusicVolume = Float(settings[gi])
		gi += 1
		'Options.Set("option_3",Int(settings[gi]))
		If Int(settings[gi]) = 1
			Game.ShowGhost = True
		Else
			Game.ShowGhost = False
		EndIf
		gi+=1
		Options.Set("option_4",Int(settings[gi]))
		gi+=1
		Options.Set("option_5",Int(settings[gi]))
		gi+=1
		Options.Set("option_6",Int(settings[gi]))
		gi+=1
		Options.Set("option_7",Int(settings[gi]))
		gi+=1
		Options.Set("option_8",Int(settings[gi]))
		gi+=1
		Options.Set("option_9",Int(settings[gi]))
		gi+=1
		Options.Set("option_10",Int(settings[gi]))
		gi+=1
		
		Save()
	End
	
	Function Save:Void()
		Local txt:String = "hellodoy,"
		For Local i:Int = 0 To (LevelCount - 1)
			txt += LevelStates[i]+","
		Next
		For Local yi:Int = 0 To (LevelCount - 1)
			For Local xi:Int = 0 To (TimesPerLevel - 1)
				txt += LevelTimes[yi][xi]+","
			Next
		Next
		'txt += Options.Get("option_1")+","
		'txt += Options.Get("option_2")+","
		'txt += Options.Get("option_3")+","
		txt += MySoundSystem.Volume+","
		txt += MySoundSystem.MusicVolume+","
		If Game.ShowGhost = True
			txt += "1,"
		Else
			txt += "0,"
		EndIf
		txt += Options.Get("option_4")+","
		txt += Options.Get("option_5")+","
		txt += Options.Get("option_6")+","
		txt += Options.Get("option_7")+","
		txt += Options.Get("option_8")+","
		txt += Options.Get("option_9")+","
		txt += Options.Get("option_10") + ","
		
		txt = EncodeBase64(txt)
		SaveState(txt)
	End
	
	Function Create:String()
		Local txt:String = "hellodoy,"
		For Local i:Int = 0 To (LevelCount - 1)
			If i < 3
				txt += "1,"
			Else
				txt += "0,"
			EndIf
			
		Next
		For Local yi:Int = 0 To (LevelCount - 1)
			For Local xi:Int = 0 To (TimesPerLevel - 1)
				txt += "0,"
			Next
		Next
		For Local i:Int = 0 To 9
			Select i
				Case 0 ' SFX VOLUME
					txt += "1.0,"
				Case 1 ' MUSIC VOLUME
					txt += "0.33,"
				Case 2 ' SHOW GHOST
					txt += "1,"
				Default
					txt += "0,"
			End
		Next
		Return txt
	End
	
	Function Reset:Void()
		Local txt:String = Create()
		Local settings:String[] = txt.Split(",")
		Local gi:Int = 0
		For Local i:Int = 0 To (LevelCount - 1)
			LevelStates[i] = Int(settings[gi])
			gi+=1
		Next
		For Local yi:Int = 0 To (LevelCount - 1)
			For Local xi:Int = 0 To (TimesPerLevel - 1)
				LevelTimes[yi][xi] = Int(settings[gi])
				gi+=1
			Next
		Next
		'Options.Set("option_1",Int(settings[gi]))
		MySoundSystem.Volume = Float(settings[gi])
		gi+=1
		'Options.Set("option_2",Int(settings[gi]))
		MySoundSystem.MusicVolume = Float(settings[gi])
		gi+=1
		'Options.Set("option_3",Int(settings[gi]))
		If Int(settings[gi]) = 1
			Game.ShowGhost = True
		Else
			Game.ShowGhost = False
		EndIf
		gi+=1
		Options.Set("option_4",Int(settings[gi]))
		gi+=1
		Options.Set("option_5",Int(settings[gi]))
		gi+=1
		Options.Set("option_6",Int(settings[gi]))
		gi+=1
		Options.Set("option_7",Int(settings[gi]))
		gi+=1
		Options.Set("option_8",Int(settings[gi]))
		gi+=1
		Options.Set("option_9",Int(settings[gi]))
		gi+=1
		Options.Set("option_10",Int(settings[gi]))
		gi+=1
		
		Save()
		
		
	End
	
	Function UpdateBestTimes:Int(levelNumber:Int,time:Int)

		Local BetterThan:Int = AppState.TimesPerLevel
		
		For Local i:Int = 0 to (AppState.TimesPerLevel - 1)
			If ( time < AppState.LevelTimes[levelNumber][i] Or AppState.LevelTimes[levelNumber][i] = 0 ) And BetterThan = AppState.TimesPerLevel
				BetterThan = i
			End
		Next
		
		If BetterThan <> AppState.TimesPerLevel
			For Local i:Int = (AppState.TimesPerLevel - 2) To BetterThan Step - 1
				AppState.LevelTimes[levelNumber][i+1] = AppState.LevelTimes[levelNumber][i]
			Next
			AppState.LevelTimes[levelNumber][BetterThan] = time
		End
		
		Return BetterThan
	
	End
	
End