Import ninjah

Class LevelSelector

	Global currentLevel:Int = 0
	Global delayTicker:Int = 0
	Const delayTickerTime:Int = 10
	
	Global gfxSelectLeft:Image
	Global gfxSelectRight:Image
	
	Global OldX:Int
	Global OldY:Int
	Global MX:Int
	Global MY:Int
	
	Global MH:Int
	

	Method New()
		
	End
	
	Method Update:Void()
	
		OldX = MX
		OldY = MY
		MX = VMouseX()
		MY = VMouseY()
		
		MH = MouseHit()
	
		If delayTicker > 0
			delayTicker -= 1
		Else
			If JoyX(0) < (0 - 0.1) Or KeyDown(KEY_A) Or KeyDown(KEY_LEFT)
				UpdateSelectedLevel(LEFT)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
			
			If JoyX(0) > (0.1) Or KeyDown(KEY_D) Or KeyDown(KEY_RIGHT)
				UpdateSelectedLevel(RIGHT)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
			
			If JoyY(0) < (0 - 0.1) Or KeyDown(KEY_S) Or KeyDown(KEY_DOWN)
				UpdateSelectedLevel(UP)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
			
			If JoyY(0) > (0.1) Or KeyDown(KEY_W) Or KeyDown(KEY_UP)
				UpdateSelectedLevel(DOWN)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
		End
		
		If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or (MH And PointWithinRect(MX, MY, SelectOriginX, SelectOriginY, SelectOriginX + ( (BlockWidth + BlockPadding) * 10), SelectOriginY + ( (BlockHeight + BlockPadding) * 6)))
			' IF LEVEL IS ACTIVE
			If AppState.LevelStates[currentLevel] > AppState.L_CLOSED
				MySoundSystem.Play("click")
				Game.LoadLevelFromEditor(currentLevel)
				MyScreenManager.InitiateChangeScreen("game")
			End
		End
		
		If JoyHit(JOY_B) Or KeyHit(KEY_ESCAPE)
			' Game.LoadLevelFromEditor(currentLevel)
			MyScreenManager.InitiateChangeScreen("main")
		End
		
		If OldX <> MX or OldY <> MY
			If PointWithinRect(MX, MY, SelectOriginX, SelectOriginY, SelectOriginX + ( (BlockWidth + BlockPadding) * 10), SelectOriginY + ( (BlockHeight + BlockPadding) * 6))
				Local tRow:Int = ( (MX - SelectOriginX) - ( (MX - SelectOriginX) Mod(BlockWidth + BlockPadding))) / (BlockHeight + BlockPadding)
				Local tCol:Int = ( (MY - SelectOriginY) - ( (MY - SelectOriginY) Mod(BlockHeight + BlockPadding))) / (BlockHeight + BlockPadding)
				
				If tCol <> 1
					If tCol > 1
						tCol -= 1
					EndIf
					
					If tCol = 5
						tCol = 4
					EndIf
				
					Local tLev:Int = (tRow) + (tCol * 10)
					If tLev <> currentLevel
						currentLevel = tLev
						MySoundSystem.Play("click")
					EndIf
				EndIf
				
				
			EndIf
		EndIf
		
		UpdateVisualOptions()
		
		ParticleManager.UpdateAll()
	End
	
	Method Draw:Void()
		SetColor(255,255,255)
		'NinjahApp.fontLarge.DrawText("Select a level",NinjahApp.sx1,NinjahApp.sy1)
		TextImages.Draw(TextImages.TITLE_SELECT,NinjahApp.sx1,NinjahApp.sy1)
		DrawSelector()
		If CanChangeOptions = True
			DrawVisualOptions()
		End
		DrawBestTimes()
		
		DrawPreview()
		
		SetColor(255, 255, 255)
		DrawImage(LevelRope.TileSet, VMouseX(), VMouseY())
		
		ParticleManager.DrawAll()
	End
	
	Field SelectOriginX:Int = NinjahApp.sx1 + 116
	Field SelectOriginY:Int = NinjahApp.sy1 + 72	
	Field BlockWidth:Int = 50
	Field BlockHeight:Int = 50
	Field BlockPadding:Int = 5
	Method DrawSelector:Void()
	
		SetAlpha(1)
		SetColor(255,255,255)
		'NinjahApp.fontLarge.DrawText("Tutorials:",SelectOriginX - 10,SelectOriginY + 20, AngelFont.ALIGN_RIGHT)
		TextImages.Draw(TextImages.TUTORIALS,SelectOriginX - 110,SelectOriginY + 20)
		
	
		For Local Y:Int = 0 To 4
			For Local X:Int = 0 To 9
			
				Local yOffSet:Int = 0
				
				If Y = 0
					yOffSet = 0
				Else
					yOffSet = 50
				End
			
				Local tL:Int = (Y * 10) + X
				Local tLS:Int = tL + 1
				
				Local active:Bool = False
				Local selected:Bool = False
				
				Select AppState.LevelStates[tL]
					Case AppState.L_CLOSED
						SetColor(128,128,128)
						active = False
					Case AppState.L_OPEN
						SetColor(255,255,255)
						active = True
					Case AppState.L_COMPLETED,AppState.L_BEST_BEATEN
					 	SetColor(255,255,255)
						active = True
				End
				
				' active = True
				
				If tL = currentLevel
					selected = True
				Else
					selected = False
				End
				'Local tS:String
				'If tLS < 10
				'	tS = "0"+String(tLS)
				'Else
				'	tS = String(tLS)
				'End
				' DrawButton(SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5),SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5),BlockWidth,BlockHeight,tS,selected,active)
				'\DrawHelper.RoundedRect(SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5) + 4,SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5) + 4, BlockWidth,BlockHeight)
				DrawButton(SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5),SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5),BlockWidth,BlockHeight,selected,active)
				TextImages.DrawNumber(tLS,SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5) + 4,SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5) + 4)
				
				SetColor(255,255,255)
				
				If AppState.LevelStates[tL] > AppState.L_CLOSED
					If AppState.LevelStates[tL] >= AppState.L_COMPLETED
						SetAlpha(1)
					Else	
						SetAlpha(0.1)
					EndIf
					
					DrawImage(NinjahApp.gfxTick,SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5) + 4,SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5) + 33, 0, 0.6, 0.6, 0)
				End
				
				If AppState.LevelStates[tL] = AppState.L_BEST_BEATEN
					SetAlpha(1)
					DrawImage(NinjahApp.gfxMedal,SelectOriginX + (X * (BlockWidth + BlockPadding)) + (BlockPadding * 2.5) + 31,SelectOriginY + yOffSet + (Y * (BlockHeight + BlockPadding)) + (BlockPadding * 2.5) + 33, 0, 0.4, 0.4, 0)
				End
						
			Next
		Next
	End
	
	Field TimesOriginX:Int = NinjahApp.sx1 + ((55) * 11) + 100
	Field TimesOriginY:Int = NinjahApp.sy1 + 72 + 20
	Method DrawBestTimes:Void()
	
		SetAlpha(1)
	
		Local tY:Int = TimesOriginY
		Local tX:Int = TimesOriginX
		
		SetColor(255,255,255)
		' NinjahApp.fontNormal.DrawText("Best Times for "+GameTutorial.LevelNames[currentLevel],tX,tY)
		TextImages.Draw(TextImages.BEST_TIMES,tX,tY)
		If AppState.LevelStates[currentLevel] > AppState.L_CLOSED
			TextImages.DrawName(currentLevel,tX + 150,tY)
		Else
			TextImages.DrawName(51,tX + 150,tY)
		End
		tY += 32
		
		For Local i:Int = 0 to (AppState.TimesPerLevel - 1)
			If AppState.LevelTimes[currentLevel][i] = 0
				SetColor(128,128,128)
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				tY += 24
			ElseIf i = 0
				SetColor(255,255,255)
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				' TextImages.DrawNumber(AppState.LevelTimes[currentLevel][i],tX + 200, tY)
				tY += 32
			Else
				SetColor(220,220,220)
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				tY += 24
			End
		Next
		
	End
	
	Field PreviewOriginX:Int = NinjahApp.sx1 + ((55) * 11) + 100
	Field PreviewOriginY:Int = NinjahApp.sy1 + 72 + 200 + 20
	Method DrawPreview:Void()
		If AppState.LevelStates[currentLevel] <> AppState.L_CLOSED
			Local XScale:Float = (1280/4.0) / Float(NinjahApp.gfxButtonBack.Width())
			Local YScale:Float = (720/4.0) / Float(NinjahApp.gfxButtonBack.Height())
			SetColor(0,0,0)
			SetAlpha(0.5)
			DrawImage(NinjahApp.gfxButtonBack,PreviewOriginX,PreviewOriginY,0,XScale,YScale)
			SetAlpha(1)
			GameEditor.Levels[currentLevel].DrawPreview(PreviewOriginX,PreviewOriginY)
			
		End
	End
	
	Const UP:Int = 0
	Const DOWN:Int = 1
	Const LEFT:Int = 2
	Const RIGHT:Int = 3
	Method UpdateSelectedLevel:Void(direction:Int)
		Select direction
			Case UP
				currentLevel += 10
			Case DOWN
				currentLevel -= 10
			Case LEFT
				
				currentLevel -= 1
			
			Case RIGHT
				
				currentLevel+=1
		End
		If currentLevel < 0
			currentLevel += 50
		End
		if currentLevel >= 50
			currentLevel -= 50
		End
	End
	
	Global CanChangeOptions:Bool = False
	Global ChangeOptionsAlpha:Float = 1
	Global TrailIndex:Int = 0
	Global TilesetIndex:Int = 0
	Global SpriteIndex:Int = 0
	Global OptionTimer:Int = 0
	Global ActiveVisualOption:Int = 0
	
	Global GenerateChangeTimer:Int = 0
	
	Method UpdateVisualOptions:Void()
		If CanChangeOptions = True
		
			
			'If OldX <> MX or OldY <> MY
			
				Local DrawY:Int = VisualOriginY
				
				' VIS MAIN
				If PointWithinRect(MX, MY, VisualOriginX, DrawY, VisualOriginX + 330, DrawY + 29)
					If ActiveVisualOption <> 0
						ActiveVisualOption = 0
						MySoundSystem.Play("click")
					EndIf
				EndIf
				' VIS LEFT
				If PointWithinRect(MX, MY, VisualOriginX + 170, DrawY, VisualOriginX + 200, DrawY + 29)
					
					If MH
						TrailIndex -= 1
						If TrailIndex < 0
							TrailIndex = 2
						EndIf
						MySoundSystem.Play("click")
						LevelPlayer.UpdateTrailMode(TrailIndex)
						Game.gfxBack = Game.gfxBack2
					EndIf
					
				EndIf
				' VIS RIGHT
				If PointWithinRect(MX, MY, VisualOriginX + 300, DrawY, VisualOriginX + 330, DrawY + 29)
					If ActiveVisualOption <> 0
						ActiveVisualOption = 0
						MySoundSystem.Play("click")
					EndIf
				
					If MH
						MySoundSystem.Play("click")
						TrailIndex += 1
						If TrailIndex > 2
							TrailIndex = 0
						EndIf
						LevelPlayer.UpdateTrailMode(TrailIndex)
						Game.gfxBack = Game.gfxBack2
					EndIf
				EndIf
				DrawY += 30
				
				' SPRITE MAIN
				If PointWithinRect(MX, MY, VisualOriginX, DrawY, VisualOriginX + 330, DrawY + 29)
					If ActiveVisualOption <> 1
						ActiveVisualOption = 1
						MySoundSystem.Play("click")
					EndIf
				EndIf
				' SPRITE LEFT
				If PointWithinRect(MX, MY, VisualOriginX + 170, DrawY, VisualOriginX + 200, DrawY + 29)
					If MH
						SpriteIndex -= 1
						If SpriteIndex < 0
							SpriteIndex = 2
						EndIf
						MySoundSystem.Play("click")
						NinjahSprite.UpdateSpriteMode(SpriteIndex)
						Game.gfxBack = Game.gfxBack3
					EndIf
				EndIf
				' SPRITE RIGHT
				If PointWithinRect(MX, MY, VisualOriginX + 300, DrawY, VisualOriginX + 330, DrawY + 29)
					If MH
						SpriteIndex += 1
						If SpriteIndex > 2
							SpriteIndex = 0
						EndIf
						MySoundSystem.Play("click")
						NinjahSprite.UpdateSpriteMode(SpriteIndex)
						Game.gfxBack = Game.gfxBack3
					EndIf
				EndIf
				DrawY += 30
				
				' TILESET MAIN
				If PointWithinRect(MX, MY, VisualOriginX, DrawY, VisualOriginX + 330, DrawY + 29)
					If ActiveVisualOption <> 2
						ActiveVisualOption = 2
						MySoundSystem.Play("click")
					EndIf
				EndIf
				' TILESET LEFT
				If PointWithinRect(MX, MY, VisualOriginX + 170, DrawY, VisualOriginX + 200, DrawY + 29)
					If MH
						TilesetIndex -= 1
						If TilesetIndex < 0
							TilesetIndex = 5
						EndIf
						MySoundSystem.Play("click")
						LevelBlock.ChangeTileSet(TilesetIndex)
					EndIf
				EndIf
				' TILESET RIGHT
				If PointWithinRect(MX, MY, VisualOriginX + 300, DrawY, VisualOriginX + 330, DrawY + 29)
					If MH
						TilesetIndex += 1
						If TilesetIndex > 5
							TilesetIndex = 0
						EndIf
						
						MySoundSystem.Play("click")
						LevelBlock.ChangeTileSet(TilesetIndex)
					EndIf
				EndIf
				
				
			'EndIf
		
			If ChangeOptionsAlpha < 1
				ChangeOptionsAlpha += 0.02
				If GenerateChangeTimer = 0 
					GenerateCoinParticles(VisualOriginX+Rnd(0,300),VisualOriginY+Rnd(0,100))	
				End
				GenerateChangeTimer += 1
				If GenerateChangeTimer = 4
					GenerateChangeTimer = 0
				EndIf
			Else
				ChangeOptionsAlpha = 1
			EndIf
			
			If OptionTimer = 0
				
				If JoyY(1) > 0.5
					ActiveVisualOption -= 1
					MySoundSystem.Play("click")
					
					If ActiveVisualOption < 0
						ActiveVisualOption = 2
					EndIf
					
					OptionTimer = 10
					
				End
				
				If JoyY(1) < 0 - 0.5
					ActiveVisualOption += 1
					MySoundSystem.Play("click")
					
					If ActiveVisualOption > 2
						ActiveVisualOption = 0
					EndIf
					
					OptionTimer = 10
					
				EndIf
				
				
				
				If JoyX(1) > 0.5
				
					Select ActiveVisualOption
						Case 0
							TrailIndex += 1
							If TrailIndex > 2
								TrailIndex = 0
							EndIf
							
							LevelPlayer.UpdateTrailMode(TrailIndex)
							Game.gfxBack = Game.gfxBack2
							
						Case 1
							SpriteIndex += 1
							If SpriteIndex > 2
								SpriteIndex = 0
							EndIf
							
							NinjahSprite.UpdateSpriteMode(SpriteIndex)
							Game.gfxBack = Game.gfxBack3
							
						Case 2
							TilesetIndex += 1
							If TilesetIndex > 5
								TilesetIndex = 0
							EndIf
							
							
							LevelBlock.ChangeTileSet(TilesetIndex)
							Game.gfxBack = Game.gfxBack3
					End
					
					MySoundSystem.Play("click")	
					OptionTimer = 10
				EndIf
				
				If JoyX(1) < 0 - 0.5
				
					Select ActiveVisualOption
						Case 0
							TrailIndex -= 1
							If TrailIndex < 0
								TrailIndex = 2
							EndIf
							LevelPlayer.UpdateTrailMode(TrailIndex)
						Case 1
							SpriteIndex -= 1
							If SpriteIndex < 0
								SpriteIndex = 2
							EndIf
							NinjahSprite.UpdateSpriteMode(SpriteIndex)
						Case 2
							TilesetIndex -= 1
							If TilesetIndex < 0
								TilesetIndex = 5
							EndIf
							LevelBlock.ChangeTileSet(TilesetIndex)
					End
					
					MySoundSystem.Play("click")
					OptionTimer = 10
				EndIf
			
			Else
				OptionTimer -= 1
			EndIf
		
		EndIf
	End
	
	Field VisualOriginX:Int = NinjahApp.sx1 + 116
	Field VisualOriginY:Int = NinjahApp.sy1 + 72 + ( 60 * 6 )
	Method DrawVisualOptions:Void()
	
		Local DrawY:Int = VisualOriginY
		
		SetAlpha(ChangeOptionsAlpha)
	
		If ActiveVisualOption = 0
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		TextImages.Draw(TextImages.TRAIL_MODE,VisualOriginX,DrawY)
		DrawImage(gfxSelectLeft,VisualOriginX + 170, DrawY)
		DrawImage(gfxSelectRight,VisualOriginX + 300, DrawY)
		Select TrailIndex
			Case 0
				TextImages.Draw(TextImages.NONE,VisualOriginX + 190,DrawY)
			Case 1
				TextImages.Draw(TextImages.COLOUR,VisualOriginX + 190,DrawY)
			Case 2
				TextImages.Draw(TextImages.RAINBOW,VisualOriginX + 190,DrawY)
		End
		
		DrawY += 30
		
		If ActiveVisualOption = 1
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		TextImages.Draw(TextImages.SPRITE_MODE,VisualOriginX,DrawY)
		DrawImage(gfxSelectLeft,VisualOriginX + 170, DrawY)
		DrawImage(gfxSelectRight,VisualOriginX + 300, DrawY)
		Select SpriteIndex
			Case 0
				TextImages.Draw(TextImages.NORMAL,VisualOriginX + 190,DrawY)
			Case 1
				TextImages.Draw(TextImages.FALAFEL,VisualOriginX + 190,DrawY)
			Case 2
				TextImages.Draw(TextImages.NNNNNN,VisualOriginX + 190,DrawY)
		End
		
		DrawY += 30
		
		If ActiveVisualOption = 2
			SetColor(255,255,0)
		Else
			SetColor(255,255,255)
		EndIf
		
		TextImages.Draw(TextImages.TILESET,VisualOriginX,DrawY)
		DrawImage(gfxSelectLeft,VisualOriginX + 170, DrawY)
		DrawImage(gfxSelectRight,VisualOriginX + 300, DrawY)
		Select TilesetIndex
			Case 0
				TextImages.Draw(TextImages.NORMAL,VisualOriginX + 190,DrawY)
			Case 1
				TextImages.Draw(TextImages.THIN,VisualOriginX + 190,DrawY)
			Case 2
				TextImages.Draw(TextImages.SOLID,VisualOriginX + 190,DrawY)
			Case 3
				TextImages.Draw(TextImages.NEGATIVE,VisualOriginX + 190,DrawY)
			Case 4
				TextImages.Draw(TextImages.FALAFEL,VisualOriginX + 190,DrawY)
			Case 5
				TextImages.Draw(TextImages.NNNNNN,VisualOriginX + 190,DrawY)
		End
		
		DrawY += 30
		
		SetColor(255, 255, 255)
		' DrawText(MX + " : " + MY, 50, 50)
		'TextImages.Draw(TextImages.CHANGE,VisualOriginX + 20,DrawY)
		
	
	
	End
	
	

End