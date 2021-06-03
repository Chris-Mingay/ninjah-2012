Import ninjah

Class Game

	Global gfxReady:Image
	Global gfxSteady:Image
	Global gfxGo:Image
	Global gfxGuiBack:Image
	
	Global gfxBack:Image
	Global gfxBack1:Image
	Global gfxBack2:Image
	Global gfxBack3:Image
	
	Global gfxPixel:Image
	
	Global gfxIconBack:Image
	Global gfxIconMove:Image
	Global gfxIconRope:Image
	Global gfxIconGun:Image
	
	Global gfxGui:Image
	Global gfxGuiSolid:Image
	Global gfxGhost:Image
	
	Global MaxBlocks:Int = 3400
	Global BlocksInThisLevel:Int = 0
	Global Blocks:LevelBlock[]
	'Global Blocks:= New List<LevelBlock>
	' Global Coins:= New List<LevelCoin>
	' Global Coins:LevelCoin[]
	Global levelExit:LevelExit
	Global Player:LevelPlayer
	' Global Bullets:= New List<LevelBullet>
	Global Move:Bool = True
	Global Rope:Bool = True
	Global Gun:Bool = True
	
	Global StartX:Int
	Global StartY:Int
	Global StartC:Int
	
	Global BestGhost:Float[]
	Global ThisGhost:FloatList
	Global GhostLevel:Int = -1
	Global GhostTime:Int = 0
	Global GhostLength:Int = 0
	Global GhostPosition:Int = 0
	Global GhostVisible:Bool = False
	Global GhostX:Float
	Global GhostY:Float
	
	Global ShowGhost:Bool = True
	
	Const INTRO:Int = 0
	Const COUNTDOWN_READY:Int = 1
	Const COUNTDOWN_STEADY:Int = 2
	Const COUNTDOWN_GO:Int = 3
	Const PLAY:Int = 4
	Const DEAD_DELAY:Int = 4
	Const COMPLETED:Int = 5
	Global Status:Int
	
	Field CountDownTimer:Int = 0
	Const COUNTDOWN_TARGET:Int = 30
	
	Field backScroll:Int = 0
	
	Global ActiveCoins:Int = 0
	
	Const FADE_IN:Int = 0
	Const FADE_DONE:Int = 1
	Const FADE_OUT:Int = 2
	Field levelChangeFade:Float = 0
	Field levelChangeMode:Int = FADE_DONE
	Field levelChangeTarget:Int = 0
	Global currentLevel:Int = 0
	Field GameTimer:Float = 0
	Global moveIterations:Int = 3
	
	Global BadMove:Bool = False
	Global BadRope:Bool = False
	Global BadGun:Bool = False
	
	Global GravityFlipped:Bool = False
	
	Global MX:Int
	Global MY:Int
	Global MH:Int
	
	Global IsPaused:Bool = False
	
	
	Field RestartCountDown:Int = 30
	
	Function Init:Void()
		Blocks = New LevelBlock[MaxBlocks]
		For Local i:Int = 0 To MaxBlocks - 1
			Blocks[i] = New LevelBlock()
		Next
		
	End
	
	Method New()
	
	
	
		InitPrePlay()
		Player = New LevelPlayer()
		levelExit = New LevelExit()
		
		ThisGhost = New FloatList()
		
		
	End
	
	Method StartNewLevel:Void()
		Status = INTRO
		LastUpdatedTime = AppState.TimesPerLevel
		
		Firework.ActiveForLaunch = False
		Firework.Clear()
		ParticleManager.Clear()
		ParticleManager.ParticleCount = 0
		
		
	End
	
	Method LoadLevel:Void(levelNumber:Int)
		If levelNumber = -1
			LoadDebugLevel()
		Else
			' TODO - LOAD PROPER LEVEL
		End
	End
	
	Function LoadLevelFromEditor:Void(levelNumber:Int)
	
	
		Mine.Clear()
		ParticleManager.Clear()
		GraveStone.ClearAll()
	
		Status = INTRO
		currentLevel = levelNumber
		Local thisLevel:EditorLevel = GameEditor.Levels[levelNumber]
	
		For Local i:Int = 0 To MaxBlocks - 1
			Blocks[i].Reset()
		Next
		
		BlocksInThisLevel = 0
		
		' Coins.Clear()
		' Bullets.Clear()
		Firework.ActiveForLaunch = False
		ParticleManager.Clear()
		LevelCoin.ClearCoins()
		
		'Firework._list.Clear()
		Move = thisLevel.Move
		Rope = thisLevel.Rope
		Gun = thisLevel.Gun
		For Local tY:Int = 0 To GameEditor.Height - 1
			For Local tX:Int = 0 To GameEditor.Width - 1
				Local tB:EditorBlock = thisLevel.Blocks[tY][tX]
				
				Select tB.T
					Case GameEditor.SPACE
					
					Case GameEditor.COIN
						LevelCoin.Create(tB.X,tB.Y)
						'Coins.AddLast( New LevelCoin(tB.X,tB.Y))
					Case GameEditor.LEVELEXIT
						levelExit.X = tB.X
						levelExit.Y = tB.Y
						levelExit.X2 = tB.X + LevelExit.W
						levelExit.Y2 = tB.Y + LevelExit.H
					Case GameEditor.START
						StartX = tB.X
						StartY = tB.Y
						
					Default
						Local tCF:Int = 0
						Local frameShift:Int = 0
						Select tB.T
							Case GameEditor.NEUTRAL
								
								Local C_UL:Int = 0
								Local C_UR:Int = 0
								Local C_BL:Int = 0
								Local C_BR:Int = 0
								
								
								
								If tY > 0 And tX > 0
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T
										If thisLevel.Blocks[tY-1][tX-1].T <> tB.T
											C_UL = 1
										End
									End
								End
								
								If tY > 0 And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T
										If thisLevel.Blocks[tY-1][tX+1].T <> tB.T
											C_UR = 2
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX > 0
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T
										If thisLevel.Blocks[tY+1][tX-1].T <> tB.T
											C_BL = 4
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T
										If thisLevel.Blocks[tY+1][tX+1].T <> tB.T
											C_BR = 8
										End
									End
								End
								
								tCF = C_UL + C_UR + C_BL + C_BR
							
							
							Case GameEditor.SOLID
								frameShift = 0
								
								Local C_UL:Int = 0
								Local C_UR:Int = 0
								Local C_BL:Int = 0
								Local C_BR:Int = 0
								
								If tY > 0 And tX > 0
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T And thisLevel.Blocks[tY-1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX-1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY-1][tX-1].T <> tB.T Or thisLevel.Blocks[tY-1][tX-1].ColourInt <> tB.ColourInt
											C_UL = 1
										End
									End
								End
								
								If tY > 0 And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T  And thisLevel.Blocks[tY-1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX+1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY-1][tX+1].T <> tB.T Or thisLevel.Blocks[tY-1][tX+1].ColourInt <> tB.ColourInt
											C_UR = 2
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX > 0
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T  And thisLevel.Blocks[tY+1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX-1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY+1][tX-1].T <> tB.T Or thisLevel.Blocks[tY+1][tX-1].ColourInt <> tB.ColourInt
											C_BL = 4
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T  And thisLevel.Blocks[tY+1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX+1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY+1][tX+1].T <> tB.T Or thisLevel.Blocks[tY+1][tX+1].ColourInt <> tB.ColourInt
											C_BR = 8
										End
									End
								End
								
								tCF = C_UL + C_UR + C_BL + C_BR

								
							Case GameEditor.CHANGE
								frameShift = 16
								
								Local C_UL:Int = 0
								Local C_UR:Int = 0
								Local C_BL:Int = 0
								Local C_BR:Int = 0
								
								If tY > 0 And tX > 0
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T And thisLevel.Blocks[tY-1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX-1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY-1][tX-1].T <> tB.T Or thisLevel.Blocks[tY-1][tX-1].ColourInt <> tB.ColourInt
											C_UL = 1
										End
									End
								End
								
								If tY > 0 And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY-1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T  And thisLevel.Blocks[tY-1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX-1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY-1][tX+1].T <> tB.T Or thisLevel.Blocks[tY-1][tX+1].ColourInt <> tB.ColourInt
											C_UR = 2
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX > 0
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX-1].T = tB.T  And thisLevel.Blocks[tY+1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX-1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY+1][tX-1].T <> tB.T Or thisLevel.Blocks[tY+1][tX-1].ColourInt <> tB.ColourInt
											C_BL = 4
										End
									End
								End
								
								If tY < (GameEditor.Height - 1) And tX < (GameEditor.Width - 1)
									If thisLevel.Blocks[tY+1][tX].T = tB.T And thisLevel.Blocks[tY][tX+1].T = tB.T  And thisLevel.Blocks[tY+1][tX].ColourInt = tB.ColourInt And thisLevel.Blocks[tY][tX+1].ColourInt = tB.ColourInt
										If thisLevel.Blocks[tY+1][tX+1].T <> tB.T Or thisLevel.Blocks[tY+1][tX+1].ColourInt <> tB.ColourInt
											C_BR = 8
										End
									End
								End
								
								tCF = C_UL + C_UR + C_BL + C_BR
								
							Case GameEditor.ZONE
								frameShift = 32
							Case GameEditor.NOROPEZONE
								frameShift = 32
						End
						
						
						Blocks[BlocksInThisLevel].Create(tB.X,tB.Y,tB.T,tB.ColourInt,tB.F + frameShift, tCF)
						BlocksInThisLevel += 1
						
						'Blocks.AddLast( New LevelBlock(tB.X,tB.Y,tB.T,tB.ColourInt,tB.F + frameShift, tCF))
				End
			Next
		Next
	End
	
	Method LoadDebugLevel:Void()
		
		
	End
	
	Method RestartLevel:Void()
		InitPrePlay()
		Firework.Clear()
		Firework.ActiveForLaunch = False
		Player.X = StartX
		Player.Y = StartY
		Player.ColourInt = StartC
		Player.Restart()
		Player.Rope.Status = LevelRope.IN
		IsPaused = False
		NinjahSprite.Update()
		'For Local tC:LevelCoin = Eachin Coins
		'	tC.Active = True
		'Next
		ActiveCoins = LevelCoin.ReturnActiveCount()
		LevelCoin.ResetCoins()
		levelExit.Active = False
		levelExit.Collected = False
		Status = COUNTDOWN_READY
		GameTimer = 0
		ThisGhost = New FloatList()
		GhostPosition = 0
	End
	
	Method UpdateLevelChange:Void()
		Select levelChangeMode
			Case FADE_IN
				levelChangeFade -= 0.1
				If levelChangeFade <= 0
					levelChangeFade = 0
					levelChangeMode = FADE_DONE
				End
			Case FADE_OUT
				levelChangeFade += 0.1
				If levelChangeFade >= 1
					GraveStone.ClearAll()
					ParticleManager.Clear()
					Mine.Clear()
					AppState.Save()
					LoadLevelFromEditor(levelChangeTarget)
					LastUpdatedTime = AppState.TimesPerLevel
					levelChangeFade = 1
					levelChangeMode = FADE_IN
				End
		End
	End
	
	Method DrawLevelChange:Void()
		If levelChangeMode <> FADE_DONE
			SetColor(0,0,0)
			SetAlpha(levelChangeFade)
			DrawRect(0,0,NinjahApp.ScreenWidth, NinjahApp.ScreenHeight)
		End
	End
	
	Method Update:Void()
	
		MH = MouseHit()
		MX = VMouseX()
		MY = VMouseY()
	
		'If JoyHit(JOY_B)
			'Game.LoadLevelFromEditor(currentLevel)
		'	AppState.Save()
		'	MyScreenManager.InitiateChangeScreen("levelselector")
		'End
		
		Firework.UpdateAll()
		FireWorkParticle.UpdateAll()
		
		UpdateLevelChange()
	
		Select Status
		Case INTRO,COUNTDOWN_READY,COUNTDOWN_STEADY,COUNTDOWN_GO
			UpdatePrePlay()
		Case PLAY
			If IsPaused = True
				UpdatePaused()
			Else
				UpdatePlay()
			EndIf
			
		Case DEAD_DELAY,COMPLETED
			UpdatePostPlay()
		End
	End
	
	Method UpdatePlay:Void()
	
		If KeyHit(KEY_ESCAPE)
			IsPaused = True
		End
	
		Local WaitingRestart:Bool = False
		
		If JoyHit(JOY_X) Or KeyHit(KEY_R)
			Player.X = StartX
			Player.Y = StartY
			Player.Rope.X = Player.X
			Player.Rope.Y = Player.Y
			Player.Rope.Status = LevelRope.IN
			NinjahSprite.Update()
			MySoundSystem.Play("ready")
			WaitingRestart = True
			RestartLevel()
		End
		
		LevelCoin.CoinTimer += 4
		LevelExit.ExitTimer += 6
		
		If Move = False
			If BadMove = False
				If NinjahApp.Keyboard = True
					If KeyDown(KEY_A) Or KeyDown(KEY_D) Or KeyDown(KEY_W) Or KeyDown(KEY_S) Or KeyDown(KEY_LEFT) Or KeyDown(KEY_RIGHT) Or KeyDown(KEY_UP) Or KeyDown(KEY_DOWN)
						If BadMove = False
							BadMove = True
							MySoundSystem.Play("bad_move")	
						EndIf
					EndIf
				Else
					If JoyX(0) <> 0 Or JoyY(0) <> 0
						If BadMove = False
							BadMove = True
							MySoundSystem.Play("bad_move")	
						EndIf
					EndIf	
				End
			Else
				If NinjahApp.Keyboard = True
					If Not KeyDown(KEY_A) And Not KeyDown(KEY_D) And Not KeyDown(KEY_W) And Not KeyDown(KEY_S) And Not KeyDown(KEY_LEFT) And Not KeyDown(KEY_RIGHT) And Not KeyDown(KEY_UP) And Not KeyDown(KEY_DOWN)
						BadMove = False
					End
				Else
					If JoyX(0) = 0 And JoyY(0) = 0
						BadMove = False
					EndIf	
				End
			End
		EndIf
		
		If Rope = False
			If BadRope = False
				If NinjahApp.Keyboard = True
					If MouseDown(MOUSE_LEFT)
						If BadRope = False
							BadRope = True
							MySoundSystem.Play("bad_move")
						EndIf
					EndIf	
				Else
					If JoyZ(0) > 0
						If BadRope = False
							BadRope = True
							MySoundSystem.Play("bad_move")	
						EndIf
					EndIf	
				End
			Else
				If NinjahApp.Keyboard = True
					If Not MouseDown(MOUSE_LEFT)
						BadRope = False
					EndIf
				Else
					If JoyZ(0) = 0
						BadRope = False
					EndIf	
				End
			End
		EndIf
		
		If Gun = False
			If BadGun = False
				If NinjahApp.Keyboard = True
					If MouseDown(MOUSE_RIGHT)
						If BadGun = False
							BadGun = True
							MySoundSystem.Play("bad_move")	
						EndIf
					EndIf	
				Else
					If JoyZ(1) > 0
						If BadGun = False
							BadGun = True
							MySoundSystem.Play("bad_move")	
						EndIf
					EndIf	
				End
			Else
				If NinjahApp.Keyboard = True
					If Not MouseDown(MOUSE_RIGHT)
						BadGun = False
					EndIf
				Else
					If JoyZ(1) = 0
						BadGun = False
					EndIf	
				End
			End
		EndIf
		
		' GameTutorial.Update()
	
		' -- BULLETS --
		LevelBullet.UpdateAll()
		Mine.UpdateAll()
		
		Player.OverNoRopeZone = False
		
		' -- UPDATE PLAYER MOVEMENT
		If Player.Alive = True And WaitingRestart = False
		
			If JoyHit(JOY_Y) Or KeyHit(KEY_E) Or KeyHit(KEY_CONTROL)
				If NinjahSprite.Mode = 2
					GravityFlipped = Not GravityFlipped
					' TODO PLAY SOUND!
				EndIf
				
				If NinjahSprite.Mode = 1
					Mine.Add(Player.X + 8,Player.Y + 8)
				EndIf
				
			EndIf
		
			If GhostLevel = currentLevel
				If GhostPosition < GhostLength - 1
					
					GhostX = BestGhost[GhostPosition]
					GhostPosition += 1
					GhostY = BestGhost[GhostPosition]
					GhostPosition += 1
					GhostVisible = True
				Else
					GhostVisible = False
				End
			Else
				GhostVisible = False
			EndIf
		
			ThisGhost.AddLast((Player.X + 8))
			ThisGhost.AddLast((Player.Y + 8))
		
			For Local tI:Int = 0 To LevelPlayer.DivideRate
			
				If Player.Alive = True
			
					GameTimer += ( (1000 / 60) / LevelPlayer.DivideRate )
		
					Player.Update()
					
					Local TouchingSafety:Bool = False
					Local TouchingDeath:Bool = False
					Local DeathColour:Int = 0
					Local ZoneDeath:Bool = False
					
					Local TouchingDeathHorizontal:Bool = False
					
					Local TouchingCurrentColorChanger:Bool = False
					Local ColourToChangeTo:Int = -1
					
					
					Local HitLeft:Bool = False
					Local HitRight:Bool = False
					Local HitAbove:Bool =  False
					Local HitBelow:Bool = False
					
					
					
					' -- CHECK AGAINST EXIT
					If levelExit.Active = True
						If RectOverRect(Player.X,Player.Y,Player.X+Player.W,Player.Y+Player.H,levelExit.X,levelExit.Y,levelExit.X2,levelExit.Y2)
						
							If levelExit.Collected = False
							
								BeatBestTime = False
							
								MySoundSystem.Play("finish")
								LastUpdatedTime = AppState.UpdateBestTimes(currentLevel,Abs(GameTimer))
								
								YourTimeTimer = 0
								YourTimeAlpha = 0
								
								Select AppState.LevelStates[currentLevel]
									Case AppState.L_CLOSED,AppState.L_OPEN
										AppState.LevelStates[currentLevel] = AppState.L_COMPLETED
										AppState.OpenNextLevel()
								End
								
								
								
								If AppState.LevelStates[currentLevel] < AppState.L_BEST_BEATEN
									If Abs(GameTimer) < AppState.BestTimes[currentLevel]
										AppState.LevelStates[currentLevel] = AppState.L_BEST_BEATEN
										BeatBestTime = True
										
										ShowBeatBestTime = False
									EndIf
								EndIf
								
								If GhostLevel <> currentLevel
									GhostTime = Abs(GameTimer)
									BestGhost = ThisGhost.ToArray()
									GhostLength = BestGhost.Length()
									GhostLevel = currentLevel
								ElseIf GhostTime = 0 Or Abs(GameTimer) < GhostTime
									GhostTime = Abs(GameTimer)
									BestGhost = ThisGhost.ToArray()
									GhostLength = BestGhost.Length()
									GhostLevel = currentLevel
								EndIf
								
								
							End
							levelExit.Collect()
							If BeatBestTime = True
								Firework.ActiveForLaunch = True
								Firework.QuickCounter = 120
								
							End
							If LastUpdatedTime <> AppState.TimesPerLevel
								MySoundSystem.Play("applause")
							End
						End
					Else
						If ActiveCoins = 0 And Game.Status = PLAY
							If levelExit.Active = False
								MySoundSystem.Play("exitopen")
							End
							levelExit.Active = True
							
							GenerateExitParticles(levelExit.X + (LevelExit.W * 0.5),levelExit.Y + (LevelExit.H * 0.5))
							' TODO -SPARKLIES
						End
					End
					
					' -- CHECK AGAINST COINS
					For Local i:Int = 0 To LevelCoin.CoinCount - 1
						If LevelCoin.Coins[i].Active = True And LevelCoin.Coins[i].Collected = False 
							If RectOverRect(Player.X,Player.Y,Player.X+Player.W,Player.Y+Player.H,LevelCoin.Coins[i].X,LevelCoin.Coins[i].Y,LevelCoin.Coins[i].X2,LevelCoin.Coins[i].Y2)
								LevelCoin.Coins[i].Collect()
							End
						End
					Next
					
					If Player.X < 0
						Player.X = 0
						Player.XS = 0 - (Player.XS * 0.5)
					End
					
					If GravityFlipped = True
							If Player.Y < 0
							Player.Y = 0
							Player.YS = 0
						End	
					Else
						If Player.Y < 0
							Player.Y = 0
							Player.YS = 0 - (Player.YS * 0.5)
						End
					EndIf
					
					
					If Player.X + Player.W > NinjahApp.ScreenWidth
						Player.X = NinjahApp.ScreenWidth - Player.W
						Player.XS = 0 - (Player.XS * 0.5)
					End
					
					If GravityFlipped = True
						If Player.Y + Player.H > NinjahApp.ScreenHeight
							Player.Y = NinjahApp.ScreenHeight - Player.H
							If Player.Rope.Status = LevelRope.CONNECTED
								Player.YS = 0 - (Player.YS * 0.75)
							Else
								If Player.YS >= 0
									Player.YS = 0 - (Player.YS * 0.5)
								End
							End
						End	
					Else
						If Player.Y + Player.H > NinjahApp.ScreenHeight
							Player.Y = NinjahApp.ScreenHeight - Player.H
							If Player.Rope.Status = LevelRope.CONNECTED
								Player.YS = 0 - (Player.YS * 0.75)
							Else
								If Player.YS >= 0
									Player.YS = 0
								End
							End
						End
					EndIf
					
					
					If Player.Rope.Status = LevelRope.OUT
						If Not PointWithinRect(Player.Rope.X,Player.Rope.Y,0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
							Player.Rope.Status = LevelRope.RETURNING
						End
					End
					
					
					' -- CHECK AGAINST BLOCKS
					Player.OnFloor = False
					For Local i:Int = 0 To BlocksInThisLevel - 1
						' -- PLAYER CHECKS
						If RectOverRect(Player.X,Player.Y,Player.X+Player.W,Player.Y+Player.H,Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
							' -- MOVEMENT CHECKS
							If Blocks[i].IsNeutral Or Blocks[i].IsChange Or Blocks[i].IsColour
								
								' -- LEFT AND RIGHT
								If HitLeft = False And HitRight = False
									If RectOverRect(Player.X,Player.Y + (Player.H * 0.25),Player.X + 1,Player.Y + (Player.H * 0.75),Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
										HitLeft= True
										Player.X = Blocks[i].X2
										Player.XS = 0 - (Player.XS * 0.5)
									End
									If RectOverRect(Player.X+(Player.W-1),Player.Y + (Player.H * 0.25),Player.X + Player.W,Player.Y + (Player.H * 0.75),Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
										HitRight = True
										Player.X = Blocks[i].X - Player.W
										Player.XS = 0 - (Player.XS * 0.5)
									End
								End
								
								' -- ABOVE AND BELOW
								If HitAbove = False And HitBelow = False
									If RectOverRect(Player.X + (Player.W * 0.25),Player.Y,Player.X + (Player.W * 0.75),Player.Y + 1,Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
										If GravityFlipped = True
											Player.OnFloor = True
											If Player.Rope.Status = LevelRope.CONNECTED
												If Player.YS < 0
													Player.YS = 0 - (Player.YS * 0.75)
												End
													
											Else
												Player.YS = 0
											End
										Else
											Player.YS = 0 - (Player.YS * 0.5)
										End
										HitAbove = True
										Player.Y = Blocks[i].Y2
										
									End
									If RectOverRect(Player.X + (Player.W * 0.25),Player.Y + (Player.H - 1),Player.X + (Player.W * 0.75),Player.Y + Player.H,Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
										HitBelow = True
										If GravityFlipped = True
											Player.YS = 0 - (Player.YS * 0.5)
											
										Else
											Player.OnFloor = True
											If Player.Rope.Status = LevelRope.CONNECTED
												If Player.YS > 0
													Player.YS = 0 - (Player.YS * 0.75)
												End
													
											Else
												Player.YS = 0
											End
										EndIf
										
										Player.Y = Blocks[i].Y - Player.H
										
										
									End
								End
							End
							
							' -- COLOUR CHECKS
							If Blocks[i].IsNeutral
								TouchingSafety = True
							End
							
							If Blocks[i].IsColour
								If Blocks[i].ColourInt <> Player.ColourInt
									TouchingDeath = True
									DeathColour = Blocks[i].ColourInt
									If HitLeft = True Or HitRight = True Or HitAbove = True
										TouchingDeathHorizontal = True
									End
								Else
									TouchingSafety = True
								End
							End
							
							If Blocks[i].IsZone
								If Blocks[i].ColourInt <> Player.ColourInt
									TouchingDeath = True
									ZoneDeath = True
									DeathColour = Blocks[i].ColourInt
								End
							End
							
							If Blocks[i].IsNoRopeZone
								Player.OverNoRopeZone = True
							End
							
							If Blocks[i].IsChange And Game.Status = PLAY
								TouchingSafety = True
								If Blocks[i].ColourInt <> Player.ColourInt
									ColourToChangeTo = Blocks[i].ColourInt
								Else
									TouchingCurrentColorChanger = True
								End
							End
						End
						
						' -- ROPE CHECKS
						If Player.Rope.Status = LevelRope.OUT
							If RectOverRect(Player.Rope.X,Player.Rope.Y,Player.Rope.X+Player.Rope.W,Player.Rope.Y+Player.Rope.H,Blocks[i].X,Blocks[i].Y,Blocks[i].X2,Blocks[i].Y2)
								' -- MOVEMENT CHECKS
								If Blocks[i].IsNeutral Or Blocks[i].IsChange Or Blocks[i].IsColour
									Player.Rope.Status = LevelRope.CONNECTED
									SoundSystem.Play("rope_connect")
									GenerateRopeParticles(Player.Rope.X,Player.Rope.Y)
								End
								
								' -- NO ROPE ZONE CHECKS
								If Blocks[i].IsNoRopeZone
									Player.Rope.Status = LevelRope.RETURNING
								End
							End
						End
						
					Next
					
					Local ConfirmDeath:Bool = False
					
					If TouchingCurrentColorChanger = False
						If ColourToChangeTo <> -1
							MySoundSystem.Play("change")
							Player.ChangeColour(ColourToChangeTo)
							GenerateChangeParticles(Player.X,Player.Y,ColourToChangeTo)
						End
					End
					
					' -- IF TOUCHING A SAFE BLOCK YOU CANNOT DIE
					If ZoneDeath = True
						ConfirmDeath = True
						
					End
					
					If TouchingDeathHorizontal = True
						ConfirmDeath = True
						
					End
					
					If (TouchingDeath = True And TouchingSafety = False)
						ConfirmDeath = True
						
					End
					
					If ConfirmDeath = True
						Local gDir:Int = 0
						If HitLeft = True
							gDir = 1
						ElseIf HitRight = True
							gDir = 3
						ElseIf HitBelow = True
							gDir = 0
						ElseIf HitAbove = True
							gDir = 2
						Else
							gDir = -1
						End
						If gDir >= 0
							GraveStone.Add(Player.X, Player.Y, gDir)
						End
						GenerateDeathParticles(Player.X, Player.Y, DeathColour)
						Player.Die(DeathColour)
					End
					
				End
			Next
		Else
			RestartCountDown -= 1
			If RestartCountDown = 0
				RestartCountDown = 30
				RestartLevel()
			End
		End
		
		
	End
	
	Method UpdatePrePlay:Void()
		Select Status
		Case INTRO
			If JoyHit(JOY_A) Or KeyHit(KEY_SPACE)
				RestartLevel()
				MySoundSystem.Play("ready")
			End
			
			Local ButtonYText:Int = TimesOriginY + 300 - 32
			If PointWithinRect(MX, MY, TimesOriginX + 6, ButtonYText, TimesOriginX + 6 + 100, ButtonYText + 30)
				If MH
				
					MyScreenManager.InitiateChangeScreen("levelselector")
					AppState.Save()
				
					
				EndIf
			EndIf
			
			If PointWithinRect(MX, MY, TimesOriginX + 468, ButtonYText, TimesOriginX + 468 + 100, ButtonYText + 30)
				If MH
					RestartLevel()
					MySoundSystem.Play("ready")
				EndIf
			EndIf
			' TODO - ACTIVATE COUNTDOWN
			' TODO - PLAY SOUND
		Case COUNTDOWN_READY
			UpdatePrePlay2()
			CountDownTimer += 1
			If CountDownTimer = COUNTDOWN_TARGET
				Status = COUNTDOWN_STEADY
				CountDownTimer = 0
				MySoundSystem.Play("ready")
				Mine.Clear()
				
			End
		Case COUNTDOWN_STEADY
			UpdatePrePlay2()
			CountDownTimer += 1
			If CountDownTimer = COUNTDOWN_TARGET
				Status = COUNTDOWN_GO
				CountDownTimer = 0
				MySoundSystem.Play("go")
				
				GravityFlipped = False
			End
		Case COUNTDOWN_GO
			UpdatePrePlay2()
			CountDownTimer += 1
			If CountDownTimer = COUNTDOWN_TARGET
				Status = PLAY
				CountDownTimer = 0
				' TODO - PLAY SOUND
			End
			LevelExit.ExitTimer = 0
		End
	End
	
	Method UpdatePostPlay:Void()
		Select Status
		Case DEAD_DELAY
			CountDownTimer += 1
			If CountDownTimer = COUNTDOWN_TARGET
				Status = COUNTDOWN_READY
				' TODO - PLAY SOUND
			End
		Case COMPLETED
		
			If LastUpdatedTime < AppState.TimesPerLevel
				YourTimeTimer += 1
				
				If BeatBestTime = True
					If YourTimeTimer = 180
						Local tXX:Int = TimesOriginX + 550 + (NinjahApp.gfxMedal.Width() / 2)
						Local tYY:Int = TimesOriginY + 30 + (NinjahApp.gfxMedal.Height() / 2)
						For Local i:Int = 0 To 360 Step 72
							GenerateCoinParticles(tXX + (Sin(i) * 12),tYY + (Cos(i) * 12))	
						Next
						MySoundSystem.Play("new_best_time")
						ShowBeatBestTime = True
						
					EndIf
				End
				
				If YourTimeTimer = 120
					Local generateY:Int = TimesOriginY + 64 + (LastUpdatedTime * 24)
					For Local tX:Int = TimesOriginX + 48 To TimesOriginX + 48 + 140 Step 16
						GenerateChangeParticles(tX,generateY,3)	
					Next
					MySoundSystem.Play("new_time")
				EndIf
					
				If YourTimeTimer >= 120
					If YourTimeAlpha < 1
						YourTimeAlpha += 0.1
					Else
						YourTimeAlpha = 1
					EndIf
				EndIf
			End
		
			' TODO - CHECK PLAYER INTERACTION
			If JoyHit(JOY_A) Or KeyHit(KEY_SPACE)
				If currentLevel < 49
					levelChangeTarget = currentLevel + 1
					levelChangeMode = FADE_OUT
				Else
					AppState.Save()
					MyScreenManager.InitiateChangeScreen("levelselector")
				End
			End
			
			Local ButtonYText:Int = TimesOriginY + 300 - 32
			
			If PointWithinRect(MX, MY, TimesOriginX + 6, ButtonYText, TimesOriginX + 6 + 100, ButtonYText + 30)
				If MH
					MyScreenManager.InitiateChangeScreen("levelselector")
					AppState.Save()
				EndIf
			EndIf
			
			If PointWithinRect(MX, MY, TimesOriginX + 250, ButtonYText, TimesOriginX + 250 + 100, ButtonYText + 30)
				If MH
					RestartLevel()
					MySoundSystem.Play("ready")
				EndIf
			EndIf
			
			If PointWithinRect(MX, MY, TimesOriginX + 468, ButtonYText, TimesOriginX + 468 + 100, ButtonYText + 30)
				If MH
					If currentLevel < 49
						levelChangeTarget = currentLevel + 1
						levelChangeMode = FADE_OUT
					Else
						AppState.Save()
						MyScreenManager.InitiateChangeScreen("levelselector")
					End
					
				EndIf
			EndIf
			
			If JoyHit(JOY_X) Or KeyHit(KEY_R)
				Player.X = StartX
				Player.Y = StartY
				Player.Rope.X = Player.X
				Player.Rope.Y = Player.Y
				MySoundSystem.Play("ready")
				RestartLevel()
			End
		End
	End
	
	Method UpdateBullets:Void()
		For Local tB:LevelBullet = Eachin Bullets
			tB.Update()
		Next
	End
	
	Method UpdatePaused:Void()
		If KeyHit(KEY_ESCAPE)
			IsPaused = False
			'MyScreenManager.InitiateChangeScreen("levelselector")
			'AppState.Save()
		End
		
		Local ButtonYText:Int = TimesOriginY + 300 - 32
		
		If PointWithinRect(MX, MY, TimesOriginX + 250, ButtonYText, TimesOriginX + 250 + 100, ButtonYText + 30)
			If MH
				RestartLevel()
				MySoundSystem.Play("ready")
			EndIf
		EndIf
		
		If PointWithinRect(MX, MY, TimesOriginX + 6, ButtonYText, TimesOriginX + 6 + 100, ButtonYText + 30)
			If MH
				MyScreenManager.InitiateChangeScreen("levelselector")
				AppState.Save()
				
			EndIf
		EndIf
		
	End
	
	Method Draw:Void()
		Select Status
			Case INTRO,COUNTDOWN_READY,COUNTDOWN_STEADY,COUNTDOWN_GO
				DrawPrePlay()
				ParticleManager.DrawAll()
			Case PLAY
				If IsPaused = True
					DrawPaused()
				Else
					DrawPlay()
				EndIf
				
			Case COMPLETED,DEAD_DELAY
				DrawPostPlay()
				ParticleManager.DrawAll()
		End
		FireWorkParticle.DrawAll()
		Firework.DrawAll()
		
		SetAlpha(1)
		SetColor(255, 255, 255)
		If NinjahApp.Keyboard = True
			DrawImage(LevelRope.TileSet, VMouseX(), VMouseY())
		End
		
		DrawLevelChange()
		
		
	End
	
	Method DrawCoins:Void()
		SetColor(255,255,255)
		SetAlpha(1)
		LevelCoin.DrawAll()
		'For Local tC:LevelCoin = Eachin Coins
	'		tC.Draw()
		'Next
	End
	
	Field ReadyY:Float
	Field SteadyY:Float
	Field GoY:Float
	Field ReadyA:Float
	Field SteadyA:Float
	Field GoA:Float
	
	Field PrePlayCounter:Int
	
	Field PreSlowYS:Float
	Field PreFastYS:Float
	Field PreARSlow:Float
	Field PreARFast:Float
	
	Method InitPrePlay:Void()
		PrePlayCounter = 0
		ReadyY = NinjahApp.ScreenHeight * 0.25
		SteadyY = ReadyY
		GoY = ReadyY
		ReadyA = 0
		SteadyA = 0
		GoA = 0
		PreSlowYS = ReadyY / 15.0
		PreFastYS = PreSlowYS * 2
		PreARSlow = 1.0 / 15.0
		PreARFast = PreARSlow * 2
		
		StartScale = 8.0
		StartScaleTarget = 2.0
		StartAlpha = 0.0
		StartAlphaTarget = 0.1
		
		
	End
	
	
	Field StartScale:Float
	Field StartScaleTarget:Float
	Field StartAlpha:Float
	Field StartAlphaTarget:Float
	
	Global gfxStartMarker:Image
	
	Method UpdatePrePlay2:Void()
	
		StartScale = StartScale + ( (StartScaleTarget - StartScale) * 0.15)
		StartAlpha = StartAlpha + ( (StartAlphaTarget - StartAlpha) * 0.15)
	
		If PrePlayCounter <= 15
			ReadyY += PreSlowYS
			ReadyA += PreARSlow
		ElseIf PrePlayCounter <= 30
			ReadyA = 1
			
		ElseIf PrePlayCounter <= 45
			ReadyA -= PreARFast
			SteadyA += PreARSlow
			ReadyY += PreFastYS
			SteadyY += PreSlowYS
			
			
			StartScaleTarget = 0.66
			StartAlphaTarget = 0.5
			
		ElseIf PrePlayCounter <= 60
	
		ElseIf PrePlayCounter <= 75
		
			StartScaleTarget = 0.1
			StartAlphaTarget = 1
		
			SteadyA -= PreARFast
			GoA += PreARSlow
			GoY += PreSlowYS
			SteadyY += PreFastYS
		ElseIf PrePlayCounter <= 90
	
		End
	
		PrePlayCounter += 1
	End
	
	Method DrawPrePlay:Void()
		DrawLevel()
		LevelBullet.DrawAll()
		GraveStone.DrawAll()
		'DrawBullets()
		DrawGui()
		Select Status
		Case INTRO
			SetColor(0,0,0)
			SetAlpha(0.6)
			DrawRect(0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
			
			DrawBestTimes()
			
			SetColor(255,255,255)
			SetAlpha(1)
		Default
			DrawPrePlay2()
'		Case COUNTDOWN_READY
'			SetColor(0,0,0)
'			SetAlpha(0.6)
'			DrawRect(0,0,DeviceWidth(),DeviceHeight())
'			SetColor(255,255,255)
'			SetAlpha(1)
'			DrawImage(gfxReady,DeviceWidth()/2,DeviceHeight()/2)
'			
'		Case COUNTDOWN_STEADY
'			SetColor(0,0,0)
'			SetAlpha(0.6)
'			DrawRect(0,0,DeviceWidth(),DeviceHeight())
'			SetColor(255,255,255)
'			SetAlpha(1)
'			DrawImage(gfxSteady,DeviceWidth()/2,DeviceHeight()/2)
'		
'		Case COUNTDOWN_GO
'			SetColor(0,0,0)
'			SetAlpha(0.6)
'			DrawRect(0,0,DeviceWidth(),DeviceHeight())
'			SetColor(255,255,255)
'			SetAlpha(1)
'			DrawImage(gfxGo,DeviceWidth()/2,DeviceHeight()/2)
			
		End
	End
	
	Method DrawPrePlay2:Void()

		SetColor(0,0,0)
		SetAlpha(0.5)
		DrawRect(0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
	
		SetColor(255,255,255)
		
		If ReadyA > 0
			SetAlpha(ReadyA)
			DrawImage(gfxReady,NinjahApp.ScreenWidth * 0.5,ReadyY)
		End
		If SteadyA > 0
			SetAlpha(SteadyA)
			DrawImage(gfxSteady,NinjahApp.ScreenWidth * 0.5,SteadyY)
		End
		If GoA > 0
			SetAlpha(GoA)
			DrawImage(gfxGo,NinjahApp.ScreenWidth * 0.5,GoY)
		End
		
		SetAlpha(StartAlpha)
		DrawImage(gfxStartMarker, StartX + 8, StartY + 8, 0, StartScale, StartScale, 0)
	
	End
	
	Method DrawPaused:Void()
		DrawPlay()
		
		SetColor(0,0,0)
		SetAlpha(0.6)
		DrawRect(0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
		SetColor(255,255,255)
		SetAlpha(1)
		DrawBestTimes()
		
		DrawGui()
		
		
	End
	
	Method DrawPlay:Void()
		DrawLevel()
		GraveStone.DrawAll()
		LevelBullet.DrawAll()
		Mine.DrawAll()
		
		DrawCoins()
		
		SetColor(255,255,255)
		If levelExit.Active
			SetAlpha(1)	
		Else
			SetAlpha(0.3)	
		End
		levelExit.Draw()
		
		If ShowGhost = True
			If GhostVisible = True
				
				SetColor(255,255,255)
				Local Distance:Float = DistanceBetweenPoints(Player.X + 8,Player.Y + 8,GhostX,GhostY)
				If Distance < 100
					SetAlpha(Distance / 200.0)
				Else
					SetAlpha(0.5)
				EndIf
				DrawImage(gfxGhost,GhostX,GhostY)
			EndIf
		End
		
		If Player.Alive
			If(JoyX(1) <> 0 Or JoyY(1) <> 0) Or NinjahApp.Keyboard = True
			
				SetColor(255,0,0)
				SetBlend(1)
				If NinjahApp.Keyboard = True
					DrawGuideLine(Game.gfxPixel, Player.X + (Player.W * 0.5), Player.Y + (Player.H * 0.5), DirectionBetweenPoints(Player.X + 8, Player.Y + 8, VMouseX(), VMouseY(), 180), 2, 0.5, 0.005, 0.5)
				Else
					DrawGuideLine(Game.gfxPixel,Player.X + (Player.W * 0.5),Player.Y + (Player.H * 0.5),DirectionBetweenPoints(0,0,JoyX(1),JoyY(1)),2,0.5,0.005,0.5)
				End
				SetBlend(0)
				SetAlpha(1)
				SetColor(255,255,255)
				' DrawImage(LevelRope.TileSet,(Player.X + (Player.W * 0.5)) + (JoyX(1) * 32),(Player.Y + (Player.H * 0.5)) - (JoyY(1) * 32))
				
				'DrawCircle((Player.X + (Player.W * 0.5)) + (JoyX(1) * 32),(Player.Y + (Player.H * 0.5)) - (JoyY(1) * 32),3)
				' DrawText(DirectionBetweenPoints(Player.X,Player.Y,MouseX(),MouseY()),200,200)
			End
		End
		
		GameTutorial.Draw(currentLevel)
		ParticleManager.DrawAll()
		Player.Draw()
		DrawGui()
		
		
		
	End
	
	Method DrawPostPlay:Void()
		DrawLevel()
		GraveStone.DrawAll()
		LevelBullet.DrawAll()
		SetColor(0,0,0)
		SetAlpha(0.6)
		DrawRect(0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
		SetColor(255,255,255)
		SetAlpha(1)
		DrawBestTimes()
		DrawGui()
		If Status = COMPLETED
			' TODO - DRAW OUTCOME SCREEN
		End
	End
	
	Method DrawLevel:Void()
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(gfxBack,0,0)
		SetColor(0,0,0)
		SetAlpha(0.25)
		For Local i:Int = 0 To BlocksInThisLevel - 1
			If Blocks[i].IsZone = False And Blocks[i].IsNoRopeZone = False
				Blocks[i].DrawShadow()
			End
		Next
		SetAlpha(1)
		For Local i:Int = 0 To BlocksInThisLevel - 1
			Blocks[i].Draw()
		Next
	End
	
	Const GUI_HEIGHT:Int = 100
	Method DrawGui:Void()
		SetAlpha(1)
		SetColor(255,255,255)
		SetBlend(0)
		If Status = PLAY
			SetColor(Player.Colour.r,Player.Colour.g,Player.Colour.b)
			DrawRect(0,NinjahApp.sy1 + NinjahApp.sh - 32,NinjahApp.ScreenWidth,GUI_HEIGHT)
			
			Local TimeX:Int = NinjahApp.sx1 + 32
			Local TimeY:Int = NinjahApp.sy1 + NinjahApp.sh - 28
			SetColor(0,0,0)
			SetAlpha(1)
			For Local tY:Int = TimeY - 1 To TimeY + 1 Step 1
				For Local tX:Int = TimeX - 1 To TimeX + 1 Step 1
					' NinjahApp.fontLarge.DrawText(MillisecondsToTime(GameTimer),tX,tY)	
					TextImages.MillisecondsToTime(GameTimer,tX,tY)
				Next
			Next
			
			SetColor(255,255,255)
			TextImages.MillisecondsToTime(GameTimer,TimeX,TimeY)
			
		ElseIf Status = COMPLETED
			SetColor(128,128,128)
			DrawRect(0,NinjahApp.sy1 + NinjahApp.sh - 32,NinjahApp.ScreenWidth,GUI_HEIGHT)
			Local TimeX:Int = NinjahApp.sx1 + 32
			Local TimeY:Int = NinjahApp.sy1 + NinjahApp.sh - 28
			SetColor(0,0,0)
			SetAlpha(1)
			For Local tY:Int = TimeY - 1 To TimeY + 1 Step 1
				For Local tX:Int = TimeX - 1 To TimeX + 1 Step 1
					' NinjahApp.fontLarge.DrawText(MillisecondsToTime(GameTimer),tX,tY)	
					TextImages.MillisecondsToTime(GameTimer,tX,tY)
				Next
			Next
			
			SetColor(255,255,255)
			TextImages.MillisecondsToTime(GameTimer,TimeX,TimeY)
		Else
			SetColor(128,128,128)
			DrawRect(0,NinjahApp.sy1 + NinjahApp.sh - 32,NinjahApp.ScreenWidth,GUI_HEIGHT)
		End
		
		
		'#SetAlpha(0.5)
		'DrawRect(0,NinjahApp.sy1 + NinjahApp.sh - 32,DeviceWidth(),GUI_HEIGHT)
		
		SetAlpha(1)
		SetColor(255,255,255)
		DrawImage(gfxGuiSolid,0,NinjahApp.sy1 + NinjahApp.sh - 35)
		
		SetColor(0,0,0)
		DrawImage(gfxGui,0,NinjahApp.sy1 + NinjahApp.sh - 32)
		DrawLine(0,NinjahApp.sy1 + NinjahApp.sh - 35,NinjahApp.ScreenWidth,NinjahApp.sy1 + NinjahApp.sh - 35)
		
		If Move = True
			SetColor(0,255,0)
		Else
			If BadMove = True
				SetColor(255,255,255)
			Else
				SetColor(255,0,0)
			End
			
		End
		DrawImage(gfxIconBack,NinjahApp.sx1 + NinjahApp.sw - 104, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
		If Rope = True
			SetColor(0,255,0)
		Else
			If BadRope = True
				SetColor(255,255,255)
			Else
				SetColor(255,0,0)
			End
		End
		DrawImage(gfxIconBack,NinjahApp.sx1 + NinjahApp.sw - 80, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
		If Gun = True
			SetColor(0,255,0)
		Else
			If BadGun = True
				SetColor(255,255,255)
			Else
				SetColor(255,0,0)
			End
		End
		DrawImage(gfxIconBack,NinjahApp.sx1 + NinjahApp.sw - 58, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
		
		SetColor(255,255,255)
		DrawImage(gfxIconMove,NinjahApp.sx1 + NinjahApp.sw - 104, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
		DrawImage(gfxIconRope,NinjahApp.sx1 + NinjahApp.sw - 80, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
		DrawImage(gfxIconGun,NinjahApp.sx1 + NinjahApp.sw - 58, NinjahApp.sy1 + NinjahApp.sh - 18,0,0.5,0.5,0)
	End
	
	Field TimesOriginX:Int = (NinjahApp.ScreenWidth / 2) - 300
	Field TimesOriginY:Int = (NinjahApp.ScreenHeight / 2) - 150
	Field LastUpdatedTime:Int = AppState.TimesPerLevel
	Field YourTimeAlpha:Float = 0
	Field YourTimeTimer:Int = 0
	Field BeatBestTime:Bool = False
	Field ShowBeatBestTime:Bool = True
	Method DrawBestTimes:Void()
		Local tY:Int = TimesOriginY + 32
		Local tX:Int = TimesOriginX + 32
		
		SetColor(0,0,0)
		SetAlpha(1)
		DrawImage(gfxGuiBack,TimesOriginX,TimesOriginY,0)
		'DrawRect(TimesOriginX,TimesOriginY,600,300)
		
		SetColor(255,255,255)
		SetAlpha(1)
		DrawHollowRect(TimesOriginX,TimesOriginY,600,300)
		'NinjahApp.fontNormal.DrawText("Best Times for "+GameTutorial.LevelNames[currentLevel],tX,tY)
		TextImages.Draw(TextImages.BEST_TIMES,tX,tY)
		TextImages.DrawName(currentLevel,tX + 150,tY)
		tY += 32
		tX += 16
		For Local i:Int = 0 To (AppState.TimesPerLevel - 1)
			If AppState.LevelTimes[currentLevel][i] = 0
				SetAlpha(1)
				SetColor(128,128,128)
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				tY += 24
			ElseIf i = 0
				If i = LastUpdatedTime
					SetAlpha(YourTimeAlpha)
					SetColor(255,255,0)
				Else
					SetAlpha(1)
					SetColor(255,255,255)
				End
				
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				tY += 24
			Else
				If i = LastUpdatedTime
					SetAlpha(YourTimeAlpha)
					SetColor(255,255,0)
				Else
					SetAlpha(1)
					SetColor(220,220,220)
				End
				TextImages.MillisecondsToTime(AppState.LevelTimes[currentLevel][i],tX,tY)
				tY += 24
			End
		Next
		
		SetAlpha(1)
		
		Local ButtonYText:Int = TimesOriginY + 300 - 32
		SetColor(255,255,255)
		If Status = INTRO
			'DrawImage(NinjahApp.gfxAButton,TimesOriginX + 4,ButtonYText,0,0.3,0.3,0)
			'NinjahApp.fontNormal.DrawText("Play level",TimesOriginX + 36,ButtonYText)
			TextImages.Draw(TextImages.GAME_PLAY, TimesOriginX + 468, ButtonYText + 4)
		End
		
		If Status = COMPLETED
			'DrawImage(NinjahApp.gfxAButton,TimesOriginX + 8,ButtonYText,0,0.3,0.3,0)
			'NinjahApp.fontNormal.DrawText("Next level",TimesOriginX + 40,ButtonYText)
			TextImages.Draw(TextImages.GAME_NEXT, TimesOriginX + 468, ButtonYText + 4)
		End
			
			
			'DrawImage(NinjahApp.gfxXButton,TimesOriginX + 218,ButtonYText,0,0.3,0.3,0)
			'NinjahApp.fontNormal.DrawText("Restart level",TimesOriginX + 250,ButtonYText)
			TextImages.Draw(TextImages.GAME_RESTART,TimesOriginX + 250,ButtonYText + 4)
		'End
		
	'	DrawImage(NinjahApp.gfxBButton,TimesOriginX + 436,ButtonYText,0,0.3,0.3,0)
		'NinjahApp.fontNormal.DrawText("Back to level select",TimesOriginX + 418,ButtonYText)
		TextImages.Draw(TextImages.GAME_SELECT, TimesOriginX + 6, ButtonYText + 4)
		
		If AppState.LevelStates[currentLevel] = AppState.L_BEST_BEATEN
			If ShowBeatBestTime = True
			' DrawImage(NinjahApp.gfxMedal,10,10)
				DrawImage(NinjahApp.gfxMedal,TimesOriginX + 550,TimesOriginY + 30)
			End
		EndIf
		
	End
	
	
End



