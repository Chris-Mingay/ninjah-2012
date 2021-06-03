Import ninjah

Class EditorCursor

	Field ColourInt:Int
	Field Colour:Color
	
	Field X:Int
	Field Y:Int
	Field ModX:Int
	Field ModY:Int

	Method Update:Void()
		'X = MouseX()
		X = VMouseX()
		Y = VMouseY()
		ModX = X - ( X Mod LevelBlock.W )
		ModY = (Y - ( Y Mod LevelBlock.H ))
		
	End
	
	Method Draw:Void()
		SetColor(255,255,255)
		SetAlpha(0.5)
		DrawHollowRect(ModX,ModY,LevelBlock.W,LevelBlock.H)
	End

End
