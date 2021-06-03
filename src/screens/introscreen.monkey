Import ninjah

Class IntroScreen Extends Screen

	Field ChangeTimer:Int = 0
	
	Field LogoX:Int = (NinjahApp.ScreenWidth / 2) - 20
	Field LogoY:Int = (NinjahApp.ScreenHeight / 2) - 5

	Method New()
		
	End
	
	Method Update:Void()
		If ChangeTimer = 120
			MyScreenManager.InitiateChangeScreen("main")
		ElseIf ChangeTimer > 30
			If JoyHit(JOY_A) Or GetChar() <> 0 Or MouseHit()
				MyScreenManager.InitiateChangeScreen("main")	
			EndIf
		End
		
		
		ChangeTimer += 1
	End
	
	Method Draw:Void()
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(Game.gfxBack,0,0)
		DrawImage(NinjahApp.gfxColourfy,LogoX,LogoY)
		'SetColor(255,0,0)
		'DrawLine((NinjahApp.ScreenWidth / 2),0,(NinjahApp.ScreenWidth / 2),NinjahApp.ScreenHeight)
		'DrawLine(0,NinjahApp.ScreenHeight / 2,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight / 2)
		
	End

End

