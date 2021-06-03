Import ninjah

Class GameScreen Extends Screen

	Field game:Game
	
	Method New()
		game = New Game()
		GameTutorial.Init()
	End
	
	Method Update:Void()
		game.Update()
		ParticleManager.UpdateAll()
	End
	
	Method Draw:Void()
		SetColor(255,2552,255)
		SetAlpha(1)
		game.Draw()
	End

End

