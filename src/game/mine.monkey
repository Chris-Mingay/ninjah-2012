Import ninjah

Class Mine

	Global NextMine:Int = 0
	Global Mines:Mine[]
	Global MineCount:Int = 10
	
	Global ActiveMines:Int = 0
	
	
	Function Init:Void()
		Mines = New Mine[MineCount]
		For Local i:Int = 0 To MineCount - 1
			Mines[i] = New Mine()
		Next
	End
	
	Function Clear:Void()
		For Local i:Int = 0 To MineCount - 1
			If Mines[i].Active
				Mines[i].Destroy()
			End
		Next
	End
	
	Function UpdateAll:Void()
		For Local i:Int = 0 To MineCount - 1
			If Mines[i].Active = True
				Mines[i].Update()
			End
		Next
	End
	
	Function DrawAll:Void()
		SetAlpha(1)
		SetColor(128,128,128)
		For Local i:Int = 0 To MineCount - 1
			If Mines[i].Active = True
				Mines[i].Draw()
			End
		Next
	End
	
	Function Add:Void(oX:Float,oY:Float)
	

		If ActiveMines < MineCount
			ActiveMines += 1
			Mines[NextMine].Create(oX,oY)
			NextMine += 1
			
			If NextMine = MineCount
				NextMine = 0
			EndIf
		End
		
	End


	Field Active:Bool = False
	
	Field X:Float
	Field Y:Float
	Field YS:Float
	
	Field Timer:Int
	
	Const DROPPED:Int = 0
	Const LANDED:Int = 1
	Const ARMED:Int = 2
	Field Mode:Int
	
	Method New()
		
	End
	
	Method Create:Void(oX:Float,oY:Float)
		X = oX
		Y = oY
		YS = 0
		Timer = 0
		Mode = DROPPED
		MySoundSystem.Play("falafel_drop")
		Active = True
	End
	
	Method Destroy:Void()
		Active = False
		ActiveMines -= 1
	End
	
	Method Update:Void()
		Select Mode
			Case DROPPED
			
				If YS < 6
					YS += 0.1
				EndIf
				
				Y += YS
			
				For Local i:Int = 0 To Game.BlocksInThisLevel - 1
					If RectOverRect(X-4,Y-2,X+4,Y+2,Game.Blocks[i].X,Game.Blocks[i].Y,Game.Blocks[i].X2,Game.Blocks[i].Y2)
						If Game.Blocks[i].IsNeutral Or Game.Blocks[i].IsChange Or Game.Blocks[i].IsColour
							Y = Game.Blocks[i].Y - 2
							Mode = LANDED
							Timer = 0
						End
					End
				Next
				
			Case LANDED
				If Timer < 60
					Timer +=1
				Else
					Mode = ARMED
					Timer = 0
					GenerateFalafelPsst(X,Y)
					MySoundSystem.Play("falafel_psst")
					If RectOverRect(X-4,Y-2,X+4,Y+2,Game.Player.X,Game.Player.Y,Game.Player.X + 16,Game.Player.Y + 16)
						Game.Player.YS = -2
					End
				End
			Case ARMED
				If Timer < 60
					Timer +=1
				Else
					Timer = 0
					GenerateFalafelExplosion(X,Y)
					MySoundSystem.Play("falafel_bang")
					Destroy()
					If RectOverRect(X-4,Y-40,X+4,Y+2,Game.Player.X,Game.Player.Y,Game.Player.X + 16,Game.Player.Y + 16)
						GenerateDeathParticles(Game.Player.X,Game.Player.Y,Game.Player.ColourInt)
						Game.Player.Die(Game.Player.ColourInt)
						
					End
				End
		End
	End
	
	Method Draw:Void()
		DrawOval(X-4,Y-2,8,4)
		DrawRect(X-4,Y,8,2)
	End

End