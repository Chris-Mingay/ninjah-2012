Import ninjah

Class LevelSelectScreen Extends Screen

	Field selector:LevelSelector
	
	Method OnStart:Void()
		If LevelSelector.CanChangeOptions = False
			CheckAllComplete()
		End
		CheckAllBest()
	End
	
	Method New()
		selector = New LevelSelector
		GameTutorial.Init()
	End
	
	Method Update:Void()
		selector.Update()
		If PointWithinRect(VMouseX(), VMouseY(), NinjahApp.sx1 + NinjahApp.sw - 100, NinjahApp.sy1 + NinjahApp.sh - 40, NinjahApp.sx1 + NinjahApp.sw, NinjahApp.sy1 + NinjahApp.sh)
			If LevelSelector.MH
				MyScreenManager.InitiateChangeScreen("main")
			EndIf
		EndIf
	End
	
	Method Draw:Void()
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(Game.gfxBack,0,0)
		selector.Draw()
		
		SetAlpha(1)
		SetColor(255, 255, 255)
		DrawImage(NinjahApp.gfxBack,NinjahApp.sx1 + NinjahApp.sw - 100, NinjahApp.sy1 + NinjahApp.sh - 40)
	End
	
	Method CheckAllComplete:Void()
		If AppState.AllComplete = False
			Local AllComplete:Bool = True
			For Local i:Int = 0 To 49
				If AppState.LevelStates[i] < AppState.L_COMPLETED
					AllComplete = False
					Exit
				EndIf
			Next
			If AllComplete = True
				
				LevelSelector.CanChangeOptions = True
				LevelSelector.ChangeOptionsAlpha = 0
				MySoundSystem.Play("exitopen")
				AppState.AllComplete = True
			EndIf
		End
	End
	
	Method CheckAllBest:Void()
		If AppState.AllBest = False
			
			Local AllBest:Bool = True
			For Local i:Int = 0 To 49
				If AppState.LevelStates[i] < AppState.L_BEST_BEATEN
					
					AllBest = False
					Exit
				EndIf
			Next
			
			If AllBest = True
				
				For Local i:Int = 0 To 4
					GenerateChangeParticles(Rnd(100,200),Rnd(100,200),0)	
				Next
				AppState.AllBest = True
			End
		End
	End

End

