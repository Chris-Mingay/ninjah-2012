Import ninjah

Class OptionsScreen Extends Screen

	Global gfxTitle:Image
	Global gfxVolumeBar:Image
	Global gfxVolumeMark:Image
	
	Global gfxTicked:Image
	Global gfxNotTicked:Image
	
	Const CON_SFX:Int = 0
	Const CON_MUS:Int = 1
	Const CON_GHOST:Int = 2
	Const CON_RESET:Int = 3
	Const CON_BACK:Int = 4
	Global ActiveControl:Int = CON_SFX
	
	Global ControlTimer:Int = 0
	
	Global DeleteSure:Bool = False
	
	Global OldX:Int
	Global OldY:Int
	Global MX:Int
	Global MY:Int
	Global MH:Int
	
	Method OnStart:Void()
		DeleteSure = False
	End
	
	Method Update:Void()
	
		OldX = MX
		OldY = MY
		
		MX = VMouseX()
		MY = VMouseY()
		
		MH = MouseHit()
		
	
		If JoyHit(JOY_B) Or KeyHit(KEY_ESCAPE)
			AppState.Save()
			MyScreenManager.InitiateChangeScreen("main")
		End
		
		If ControlTimer = 0
			If JoyY(0) > 0.2 Or KeyHit(KEY_W) Or KeyHit(KEY_UP)
				ActiveControl -= 1
				ControlTimer = 10
				MySoundSystem.Play("click")
				DeleteSure = False
			EndIf
			If JoyY(0) < 0 - 0.2 Or KeyHit(KEY_S) Or KeyHit(KEY_DOWN)
				ActiveControl += 1
				ControlTimer = 10
				MySoundSystem.Play("click")
				DeleteSure = False
			EndIf
			
			If ActiveControl < 0
				ActiveControl = 4
			EndIf
			
			If ActiveControl > 4
				ActiveControl = 0
			EndIf
			
			If ActiveControl < 2
				If JoyX(0) > 0.1 Or KeyHit(KEY_RIGHT) Or KeyHit(KEY_D)
					MySoundSystem.Play("click")
					ControlTimer = 10
					Select ActiveControl
						Case CON_SFX
							MySoundSystem.Volume += 0.05
						Case CON_MUS
							MySoundSystem.MusicVolume = Clamp(MySoundSystem.MusicVolume + 0.05,0.0,1.0)
							MaxModSetMusicVolume(MySoundSystem.MusicVolume)
					End
						
				EndIf
				
				If JoyX(0) < 0 - 0.1 Or KeyHit(KEY_A) Or KeyHit(KEY_LEFT)
					ControlTimer = 10
					MySoundSystem.Play("click")
					Select ActiveControl
						Case CON_SFX
							MySoundSystem.Volume -= 0.05
						Case CON_MUS
							MySoundSystem.MusicVolume = Clamp(MySoundSystem.MusicVolume - 0.05,0.0,1.0)
							MaxModSetMusicVolume(MySoundSystem.MusicVolume)
					End
				End
				
				
				MySoundSystem.Volume = Clamp(MySoundSystem.Volume,0.0,1.0)
				
				
			End
			
		Else
			ControlTimer -= 1
		End
		
		If ActiveControl = CON_GHOST
			If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or MH
				Game.ShowGhost = Not Game.ShowGhost
				MySoundSystem.Play("click")
			EndIf
		EndIf
		
		If ActiveControl = CON_BACK
			If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or MH
				MyScreenManager.InitiateChangeScreen("main")
				AppState.Save()
			EndIf
		EndIf
		
		If ActiveControl <> CON_RESET
			DeleteSure = False
		EndIf
		
		If ActiveControl = CON_RESET
			If DeleteSure = False
				If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or MH
					DeleteSure = True
					MySoundSystem.Play("click")
				EndIf
			Else
				If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or MH
					MySoundSystem.Play("click")
					DeleteSure = False
					
					AppState.Reset()
				EndIf
			End
		EndIf
		
		Local checkX:Int = NinjahApp.sx1 + 16
		Local checkY:Int = NinjahApp.sy1 + 166
		
		If MX <> OldX or MY <> OldY
			If PointWithinRect(MX, MY, checkX, checkY, checkX + 700, checkY + 40)
				If ActiveControl <> CON_SFX
					ActiveControl = CON_SFX
					MySoundSystem.Play("click")
				EndIf
			EndIf
		EndIf
		
		If ActiveControl = CON_SFX
			If MouseDown()
				If PointWithinRect(MX, MY, checkX + 300, checkY, checkX + 700, checkY + 40)
					
					
					MySoundSystem.Volume = (MX - (checkX + 300)) / 400.0
					
				
					MySoundSystem.Volume = Clamp(MySoundSystem.Volume, 0.0, 1.0)
				
				
				EndIf
			EndIf
		EndIf
		
		checkY += 60
		
		If MX <> OldX or MY <> OldY
			If PointWithinRect(MX, MY, checkX, checkY, checkX + 700, checkY + 40)
				If ActiveControl <> CON_MUS
					ActiveControl = CON_MUS
					MySoundSystem.Play("click")
				EndIf
			EndIf
		EndIf
		
		If ActiveControl = CON_MUS
			If MouseDown()
				If PointWithinRect(MX, MY, checkX + 300, checkY, checkX + 700, checkY + 40)
					
					MySoundSystem.MusicVolume = (MX - (checkX + 300)) / 400.0
					MySoundSystem.MusicVolume = Clamp(MySoundSystem.MusicVolume, 0.0, 1.0)
					MaxModSetMusicVolume(MySoundSystem.MusicVolume)
				
				EndIf
			EndIf
		EndIf
		
		checkY += 60
		
		If MX <> OldX or MY <> OldY
			If PointWithinRect(MX, MY, checkX, checkY, checkX + 700, checkY + 40)
				If ActiveControl <> CON_GHOST
					ActiveControl = CON_GHOST
					MySoundSystem.Play("click")
				EndIf
			EndIf
		
			checkY += 60
		
			If PointWithinRect(MX, MY, checkX, checkY, checkX + 700, checkY + 40)
				If ActiveControl <> CON_RESET
					ActiveControl = CON_RESET
					MySoundSystem.Play("click")
				EndIf
			EndIf
			
			If PointWithinRect(MX, MY, NinjahApp.sx1 + NinjahApp.sw - 100, NinjahApp.sy1 + NinjahApp.sh - 40, NinjahApp.sx1 + NinjahApp.sw, NinjahApp.sy1 + NinjahApp.sh)
				If ActiveControl <> CON_BACK
					ActiveControl = CON_BACK
					MySoundSystem.Play("click")
				EndIf
			End
			
			
		EndIf
		
	
		
		
	
	End
	
	Method Draw:Void()
	
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(Game.gfxBack, 0, 0)
		
		
		Local drawY:Int = NinjahApp.sy1+ 16
		Local drawX:Int = NinjahApp.sx1 + 16
		
		DrawImage(gfxTitle,drawX, drawY)
		
		If ActiveControl = CON_SFX
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		TextImages.Draw(TextImages.SFX_VOLUME,drawX + 32, drawY + 166)
		If ActiveControl = CON_MUS
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		TextImages.Draw(TextImages.MUS_VOLUME,drawX + 32, drawY + 226)
	
		SetAlpha(0.5)
		
		If ActiveControl = CON_SFX
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		DrawImage(gfxVolumeBar, drawX + 300, drawY + 166)
		
		If ActiveControl = CON_MUS
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		DrawImage(gfxVolumeBar, drawX + 300, drawY + 226)
		
		SetAlpha(1)
		
		If ActiveControl = CON_SFX
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		DrawImage(gfxVolumeMark, drawX + 300 + (MySoundSystem.Volume * 400), drawY + 166)
		
		If ActiveControl = CON_MUS
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		DrawImage(gfxVolumeMark, drawX + 300 + (MySoundSystem.MusicVolume * 400), drawY + 226)
		
		If ActiveControl = CON_GHOST
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		TextImages.Draw(TextImages.SHOW_GHOST,drawX + 32, drawY + 286)
		
		If Game.ShowGhost = True
			DrawImage(gfxTicked, drawX + 280, drawY + 268)
		Else
			DrawImage(gfxNotTicked, drawX + 280, drawY + 268)
		EndIf
		
		If ActiveControl = CON_RESET
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		If DeleteSure = False
			TextImages.Draw(TextImages.RESET_DATA,drawX + 32, drawY + 346)
		Else
			TextImages.Draw(TextImages.ARE_YOU_SURE,drawX + 32, drawY + 346)
		End
		
		If ActiveControl = CON_BACK
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		DrawImage(NinjahApp.gfxBack, NinjahApp.sx1 + NinjahApp.sw - 100, NinjahApp.sy1 + NinjahApp.sh - 40)
		
		SetColor(255, 255, 255)
		DrawImage(LevelRope.TileSet, VMouseX(), VMouseY())
		
		
	End


End