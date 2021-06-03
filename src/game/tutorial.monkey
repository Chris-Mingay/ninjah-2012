Import ninjah

Class GameTutorial
	
	Global LevelNames:String[]
	Global Texts:Image[]
	Global A:Float
	
	Global Background:Image
	
	Function Init()
		Texts = New Image[10]
		LevelNames = New String[50]
		Background = LoadImage("graphics/tutorial_background.png")
		
		Texts[0] = LoadImage("text/tut_0.png")
		Texts[1] = LoadImage("text/tut_1.png")
		Texts[2] = LoadImage("text/tut_2.png")
		Texts[3] = LoadImage("text/tut_3.png")
		Texts[4] = LoadImage("text/tut_4.png")
		Texts[5] = LoadImage("text/tut_5.png")
		Texts[6] = LoadImage("text/tut_6.png")
		Texts[7] = LoadImage("text/tut_7.png")
		Texts[8] = LoadImage("text/tut_8.png")
		Texts[9] = LoadImage("text/tut_9.png")
		
'		
'		LevelNames[0] = "Tutorial 1 : Moving"
'		LevelNames[1] = "Tutorial 2 : Moving and Rope"
'		LevelNames[2] = "Tutorial 3 : Moving and Gun"
'		LevelNames[3] = "Tutorial 4 : Rope Only"
'		LevelNames[4] = "Tutorial 5 : Gun Only"
'		LevelNames[5] = "Tutorial 6 : Collecting Coins"
'		LevelNames[6] = "Tutorial 7 : Colour Blocks"
'		LevelNames[7] = "Tutorial 8 : Colour Zones"
'		LevelNames[8] = "Tutorial 9 : No Rope Zones"
'		LevelNames[9] = "Tutorial 10 : Good Luck!"
'		LevelNames[10] = "Change Me"
'		LevelNames[11] = "Change Me"
'		LevelNames[12] = "Change Me"
'		LevelNames[13] = "Change Me"
'		LevelNames[14] = "Change Me"
'		LevelNames[15] = "Change Me"
'		LevelNames[16] = "Change Me"
'		LevelNames[17] = "Change Me"
'		LevelNames[18] = "Change Me"
'		LevelNames[19] = "Change Me"
'		LevelNames[20] = "Change Me"
'		LevelNames[21] = "Change Me"
'		LevelNames[22] = "Change Me"
'		LevelNames[23] = "Change Me"
'		LevelNames[24] = "Change Me"
'		LevelNames[25] = "Change Me"
'		LevelNames[26] = "VVVVVV"
'		LevelNames[27] = "Change Me"
'		LevelNames[28] = "Change Me"
'		LevelNames[29] = "Change Me"
'		LevelNames[30] = "Change Me"
'		LevelNames[31] = "Change Me"
'		LevelNames[32] = "Change Me"
'		LevelNames[33] = "Change Me"
'		LevelNames[34] = "Change Me"
'		LevelNames[35] = "Change Me"
'		LevelNames[36] = "Change Me"
'		LevelNames[37] = "Change Me"
'		LevelNames[38] = "Change Me"
'		LevelNames[39] = "Change Me"
'		LevelNames[40] = "Change Me"
'		LevelNames[41] = "Change Me"
'		LevelNames[42] = "Change Me"
'		LevelNames[43] = "Change Me"
'		LevelNames[44] = "Change Me"
'		LevelNames[45] = "Change Me"
'		LevelNames[46] = "Change Me"
'		LevelNames[47] = "Change Me"
'		LevelNames[48] = "Change Me"
'		LevelNames[49] = "Change Me"
		
	End
	
	Function Update:Void()
		If Abs(Game.Player.XS) > 1 Or Abs(Game.Player.YS) > 1
			If A > 0
				A -= 0.1
			End
		Else
			If A < 1
				A += 0.1
			End
		End
	End
	
	Function Draw:Void(levelNumber:Int)
		If levelNumber < 10
			SetColor(0,0,0)
			SetAlpha(0.8)
			'DrawRect(NinjahApp.sx1,NinjahApp.sy1,NinjahApp.sw,125)
			DrawImage(Background,0,0)
			SetColor(255,255,255)
			SetAlpha(1)
			DrawImage(Texts[levelNumber],NinjahApp.sx1,NinjahApp.sy1)
		End
	End


End