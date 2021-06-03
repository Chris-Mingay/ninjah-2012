Import ninjah

Class LevelRope

	Global TileSet:Image

	Field OldX:Float
	Field OldY:Float
	Field X:Float
	Field Y:Float
	
	Const W:Float = 5
	Const H:Float = 5
	
	Field D:Float = 0
	Field S:Float = 16
	
	Field Status:Int
	Const IN:Int = 0
	Const OUT:Int = 1
	Const CONNECTED:Int = 2
	Const RETURNING:Int = 3
	
	Field ShootCounter:Int = 0
	
	
	Method New()
		Restart()
	End
	
	Method Restart:Void()
		
		Status = IN
	End
	
	Method Update:Void()
	
		If ShootCounter > 0
			ShootCounter -= 1
		End
	
		Select Status
		Case IN
			X = Game.Player.X + (Game.Player.W * 0.5)
			Y = Game.Player.Y + (Game.Player.H * 0.5)
			If Game.Rope = True
				If ShootCounter = 0
				
					Local IsRoping:Bool = False
					
					If NinjahApp.Keyboard = True
						If MouseDown(MOUSE_LEFT)
							IsRoping = True
						EndIf
					Else
						If JoyZ(0) > 0
							IsRoping = True
						EndIf
					EndIf
				
					
					If IsRoping = True
						If Game.Player.OverNoRopeZone = False
							Status = OUT
							
							SoundSystem.Play("rope_out")
							If NinjahApp.Keyboard = True
								D = DirectionBetweenPoints(Game.Player.X + 8 ,Game.Player.Y + 8,VMouseX(),VMouseY(),180)
							Else
								D = DirectionBetweenPoints(0,0,JoyX(1),JoyY(1))
							EndIf
							
							ShootCounter = 15 * LevelPlayer.DivideRate
						End
					End
				End
			End
			' TODO - PLAYER INTERACTION TO CAUSE LAUNCH
			' TODO - PLAY LAUNCH SOUND
		Case OUT
			X += (Sin(D) * S)
			Y -= (Cos(D) * S)
			
			GenerateRopeShootParticles(X, Y, D, Game.Player.Colour)
			
			If NinjahApp.Keyboard = True
				If Not MouseDown(MOUSE_LEFT)
					Status = RETURNING
					SoundSystem.Play("rope_in")
				EndIf
			Else
				If JoyZ(0) = 0
					Status = RETURNING
					SoundSystem.Play("rope_in")
				End	
			EndIf
			
			
			' TODO - PLAY RETURN SOUND
		Case CONNECTED
			If NinjahApp.Keyboard = True
				If Not MouseDown(MOUSE_LEFT)
					Status = RETURNING
					SoundSystem.Play("rope_in")
				EndIf
			Else
				If JoyZ(0) = 0
					Status = RETURNING
					SoundSystem.Play("rope_in")
				End	
			EndIf
			' TODO - PLAY RETURN SOUND
		Case RETURNING
			X = (Game.Player.X + (LevelPlayer.W / 2)) + ((X - (Game.Player.X + (LevelPlayer.W / 2))) * 0.9)
			Y = (Game.Player.Y + (LevelPlayer.H / 2)) + ((Y - (Game.Player.Y + (LevelPlayer.H / 2))) * 0.9)
			
			If DistanceBetweenPoints(X,Y,(Game.Player.X + (LevelPlayer.W / 2)),(Game.Player.Y + (LevelPlayer.H / 2))) < 32
				Status = IN
				
				' TODO = PLAY IN SOUND
			End
		End
	End
	
	Method Draw:Void()

	End
End


