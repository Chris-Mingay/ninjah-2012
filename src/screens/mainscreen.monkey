Import ninjah

Class MainScreen Extends Screen

	Const BUT_LEVELSELECT:Int = 0
	Const BUT_OPTIONS:Int = 1
	Const BUT_CREDITS:Int = 2
	Const BUT_EXIT:Int = 3
	Field ActiveButton:Int
	
	Field delayTicker:Int = 0
	Const delayTickerTime:Int = 10
	
	Field OldX:Int
	Field OldY:Int
	Field MX:Int
	Field MY:Int
	

	Method New()
		ActiveButton = BUT_LEVELSELECT
		ButtonsX = NinjahApp.sx1 + 72
		ButtonsY = NinjahApp.sy1 + 216
	End
	
	Method Update:Void()
	
		OldX = MX
		OldY = MY
		MX = VMouseX()
		MY = VMouseY()
	
		If delayTicker > 0
			delayTicker -= 1
		Else
			If JoyY(0) > (0.1) Or KeyHit(KEY_S) Or KeyHit(KEY_DOWN)
				UpdateSelectedButton(UP)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
			
			If JoyY(0) < (0 - 0.1) Or KeyHit(KEY_W) Or KeyHit(KEY_UP)
				UpdateSelectedButton(DOWN)
				delayTicker = delayTickerTime
				MySoundSystem.Play("click")
			End
		End
		
		If JoyHit(JOY_A) Or KeyHit(KEY_SPACE) Or KeyHit(KEY_ENTER)
			MySoundSystem.Play("click")
			ProcessButtonPress(ActiveButton)
		End
		
		If KeyDown(KEY_ESCAPE)
			Error ""
		EndIf
		
		If MX <> OldX or MY <> OldY
		
			Local tY:Int = ButtonsY
			Local tX:Int = ButtonsX
			
			Local withinButton:Bool = False
			
			
			If PointWithinRect(MX, MY, tX, tY, tX + ButtonWidth, tY + ButtonHeight) = True
			
				withinButton = True
			
				If ActiveButton <> 0
					ActiveButton = 0
					
					MySoundSystem.Play("click")
				End
				
			EndIf
			
			tY += ButtonHeight + ButtonPadding
			
			If PointWithinRect(MX, MY, tX, tY, tX + ButtonWidth, tY + ButtonHeight) = True
			
				withinButton = True
			
				If ActiveButton <> 1
					ActiveButton = 1
					
					MySoundSystem.Play("click")
				End
				
			EndIf
			
			tY += ButtonHeight + ButtonPadding
			
			If PointWithinRect(MX, MY, tX, tY, tX + ButtonWidth, tY + ButtonHeight) = True
			
				withinButton = True
			
				If ActiveButton <> 2
					ActiveButton = 2
					
					MySoundSystem.Play("click")
				End
				
			EndIf
			
			tY += ButtonHeight + ButtonPadding
			
			If PointWithinRect(MX, MY, tX, tY, tX + ButtonWidth, tY + ButtonHeight) = True
			
				withinButton = True
			
				If ActiveButton <> 3
					ActiveButton = 3
					
					MySoundSystem.Play("click")
				End
				
			EndIf
			
			
			
			
		EndIf
		
		If MouseHit() = True
			MySoundSystem.Play("click")
			ProcessButtonPress(ActiveButton)
		EndIf
		
		'If JoyHit(JOY_Y)
		'	If AppState.AllComplete = False
		'		ActivateAllLevels()
		'	End
		'EndIf
		
	End
	
	Const UP:Int = 0
	Const DOWN:Int = 1
	Const LEFT:Int = 2
	Const RIGHT:Int = 3
	Method UpdateSelectedButton:Void(direction:Int)
		Select direction
			Case UP
				ActiveButton += 1
			Case DOWN
				ActiveButton -= 1
		End
		If ActiveButton < 0
			ActiveButton = 3
		End
		if ActiveButton > 3
			ActiveButton = 0
		End
	End
	
	Method ProcessButtonPress:Void(button:Int)
		Select button
			Case BUT_CREDITS
				MyScreenManager.InitiateChangeScreen("credits")
			Case BUT_OPTIONS
				MyScreenManager.InitiateChangeScreen("options")
			Case BUT_EXIT
				' MyScreenManager.InitiateChangeScreen("exit")
				Error ""
			Case BUT_LEVELSELECT
				MyScreenManager.InitiateChangeScreen("levelselector")
		End
	End
	
	Field ButtonsX:Int
	Field ButtonsY:Int
	Field ButtonWidth:Int = 200
	Field ButtonHeight:Int = 50
	Field ButtonPadding:Int = 10
	Method Draw:Void()
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(Game.gfxBack,0,0)
		DrawImage(NinjahApp.Title, NinjahApp.sx1, NinjahApp.sy1)
		
		
		Local tY:Int = ButtonsY
		Local tX:Int = ButtonsX
		For Local i:Int = 0 To 3
		
			Local Selected:Bool = false
		
			If i = ActiveButton
				SetColor(255,255,0)
				Selected = true
			Else
				SetColor(220,220,220)
				Selected = false
			End
			
			' DrawHollowRect(tX,tY,ButtonWidth,ButtonHeight)
		
			Select i
			Case BUT_CREDITS
				DrawButton(tX,tY,ButtonWidth,ButtonHeight,Selected,True)
				TextImages.Draw(TextImages.BUT_CREDITS,tX + ButtonPadding, tY + ButtonPadding)
			Case BUT_OPTIONS
				DrawButton(tX,tY,ButtonWidth,ButtonHeight,Selected,True)
				TextImages.Draw(TextImages.BUT_OPTIONS,tX + ButtonPadding, tY + ButtonPadding)
				
			Case BUT_EXIT
				DrawButton(tX,tY,ButtonWidth,ButtonHeight,Selected,True)
				TextImages.Draw(TextImages.BUT_EXIT,tX + ButtonPadding, tY + ButtonPadding)
				
			Case BUT_LEVELSELECT
				DrawButton(tX,tY,ButtonWidth,ButtonHeight,Selected,True)
				TextImages.Draw(TextImages.BUT_PLAY,tX + ButtonPadding, tY + ButtonPadding)
				
			End
			
			
			
			tY += ButtonHeight + ButtonPadding
			
		Next
		
		SetColor(255, 255, 255)
		DrawImage(LevelRope.TileSet, VMouseX(), VMouseY())
		
	End
	
	Function ActivateAllLevels:Void()
		For Local i:Int = 0 To 49
			AppState.LevelStates[i] = AppState.L_COMPLETED
		Next
	End

End

