Import ninjah

Class CreditsScreen Extends Screen

	
	
	Method Update:Void()
		If JoyHit(JOY_B) Or KeyDown(KEY_ESCAPE) Or (VMouseX() > 640 And VMouseY() > 600 And MouseHit())
			MyScreenManager.InitiateChangeScreen("main")
		End
		
	End
	
	Method Draw:Void()
	
		SetColor(255,255,255)
		SetAlpha(1)
		DrawImage(Game.gfxBack, 0, 0)
		
	
		Local drawY:Int = NinjahApp.sy1+ 16
		Local drawX:Int = NinjahApp.sx1 + 16
		'DrawTextWordWrap("Credits",drawX,drawY,NinjahApp.sw - 144,NinjahApp.fontLarge,40)
		TextImages.Draw(TextImages.TITLE_CREDITS,drawX,drawY)
		drawY += 60
		'drawY += 40	
		
		TextImages.Draw(TextImages.CREDITS, drawX, drawY)
		
		DrawImage(NinjahApp.gfxBack, NinjahApp.sx1 + NinjahApp.sw - 120, NinjahApp.sy1 + NinjahApp.sh - 20)
		
		SetColor(255, 255, 255)
		DrawImage(LevelRope.TileSet, VMouseX(), VMouseY())
		
	End


End