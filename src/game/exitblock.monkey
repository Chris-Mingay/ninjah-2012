Import ninjah

Class LevelExit

	Global TileSet:Image

	Field X:Int
	Field Y:Int
	Field X2:Int
	Field Y2:int
	Const W:Int = 16
	Const H:Int = 16
	
	Global ExitTimer:Int = 0
	
	Field Active:Bool = False
	Field Collected:Bool = False
	
	Method New(tX:Int,tY:Int)
		X = tX
		Y = tY
		X2 = tX+W
		Y2 = tY+H
		
		ExitTimer = 0
	End
	
	Method Collect:Void()
		If Collected = False
			Game.Status = Game.COMPLETED
			Collected = True
			
		End
	End
	
	Method Draw:Void()
		Local cY:Float = 0
		If Active = True
			cY = 0 - Abs(Cos(ExitTimer) * 4)
		EndIf
		DrawImage(TileSet, X, Y + cY)
	End
	
End
