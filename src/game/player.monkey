Import ninjah

Class LevelPlayer

	Global TileSet:Image

	Field Rope:LevelRope
	
	Field OldX:Float
	Field OldY:Float

	Field X:Float
	Field Y:Float
	Field XS:Float
	Field YS:Float
	
	Global DivideRate:Int = 4
	
	Field MAX_XS:Float = 12 / LevelPlayer.DivideRate
	Field MAX_YS:Float = 12 / LevelPlayer.DivideRate
	Field FLOOR_MAX_XS:Float = 4 / LevelPlayer.DivideRate
	
	Const W:Float = 16
	Const H:Float = 16
	
	Field ColourInt:Int
	Field Colour:Color
	
	Field OnFloor:Bool = False
	Field ReadyToShoot:Int = 0
	Field Alive:Bool = True
	
	Field MoveXS:Float = 0.0315
	Field MoveYS:Float = 0.0315
	Field MoveRopeXS:Float = 0.0205
	Field MoveRopeYS:Float = 0.0505
	Field G:Float = 0.023
	Field JumpRate:Float = 3.55
	Field FloorResistance:Float = 0.965
	Field RopeLength:Float = 25
	Field ShootXRate:Float = 0.245
	Field ShootYRate:Float = 0.775
	
	Field CurrentEngineControl:Int = 0
	Method DisplayEngineValues:Void()
		If CurrentEngineControl = 0
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Move XS: " + MoveXS, 16, 16)
		If CurrentEngineControl = 1
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Move YS: " + MoveYS, 16, 32)
		If CurrentEngineControl = 2
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Move Rope XS: " + MoveRopeXS, 16, 48)
		If CurrentEngineControl = 3
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Move Rope YS: " + MoveRopeYS, 16, 64)
		If CurrentEngineControl = 4
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Gravity: " + G, 16, 80)
		If CurrentEngineControl = 5
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Jump Rate: " + JumpRate, 16, 96)
		If CurrentEngineControl = 6
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Floor Resistance: " + FloorResistance, 16, 112)
		If CurrentEngineControl = 7
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Rope Length: " + RopeLength, 16, 128)
		If CurrentEngineControl = 8
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Shoot X Rate: " + ShootXRate, 16, 144)
		If CurrentEngineControl = 9
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Shoot Y Rate: " + ShootYRate, 16, 160)
		If CurrentEngineControl = 10
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Max XS: " + MAX_XS, 16, 176)
		If CurrentEngineControl = 11
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Max YS: " + MAX_YS, 16, 192)
		If CurrentEngineControl = 12
			SetColor(255, 255, 0)
		Else
			SetColor(255, 255, 255)
		EndIf
		DrawText("Max Floor XS: " + FLOOR_MAX_XS, 16, 208)
	End
	
	Method UpdateEngineValues:Void()
	
		Local Reduce:Int = KeyDown(KEY_Z)
		Local Increase:Int = KeyDown(KEY_X)
		Local CR:Float
		
		If KeyHit(KEY_PAGEUP)
			CurrentEngineControl -= 1
		EndIf
		
		If KeyHit(KEY_PAGEDOWN)
			CurrentEngineControl += 1
		EndIf
		
		If CurrentEngineControl = -1
			CurrentEngineControl = 12
		EndIf
		
		If CurrentEngineControl = 13
			CurrentEngineControl = 0
		EndIf
	
		Select CurrentEngineControl
			Case 0
				CR = 0.001
				If Reduce = 1
					MoveXS -= CR
				EndIf
				
				If Increase = 1
					MoveXS += CR
				EndIf
			Case 1
				CR = 0.001
				If Reduce = 1
					MoveYS -= CR
				EndIf
				
				If Increase = 1
					MoveYS += CR
				EndIf
			Case 2
				CR = 0.001
				If Reduce = 1
					MoveRopeXS -= CR
				EndIf
				
				If Increase = 1
					MoveRopeXS += CR
				EndIf
			Case 3
				CR = 0.001
				If Reduce = 1
					MoveRopeYS -= CR
				EndIf
				
				If Increase = 1
					MoveRopeYS += CR
				EndIf
			Case 4
				CR = 0.001
				If Reduce = 1
					G -= CR
				EndIf
				
				If Increase = 1
					G += CR
				EndIf
			Case 5
				CR = 0.01
				If Reduce = 1
					JumpRate -= CR
				EndIf
				
				If Increase = 1
					JumpRate += CR
				EndIf
			Case 6
				CR = 0.01
				If Reduce = 1
					FloorResistance -= CR
				EndIf
				
				If Increase = 1
					FloorResistance += CR
				EndIf
			Case 7
				CR = 0.01
				If Reduce = 1
					RopeLength -= CR
				EndIf
				
				If Increase = 1
					RopeLength += CR
				EndIf
			Case 8
				CR = 0.001
				If Reduce = 1
					ShootXRate -= CR
				EndIf
				
				If Increase = 1
					ShootXRate += CR
				EndIf
			Case 9
				CR = 0.001
				If Reduce = 1
					ShootYRate -= CR
				EndIf
				
				If Increase = 1
					ShootYRate += CR
				EndIf
			Case 10
				CR = 0.001
				If Reduce = 1
					MAX_XS -= CR
				EndIf
				
				If Increase = 1
					MAX_XS += CR
				EndIf
			Case 11
				CR = 0.001
				If Reduce = 1
					MAX_YS -= CR
				EndIf
				
				If Increase = 1
					MAX_YS += CR
				EndIf
			Case 12
				CR = 0.001
				If Reduce = 1
					FLOOR_MAX_XS -= CR
				EndIf
				
				If Increase = 1
					FLOOR_MAX_XS += CR
				EndIf
		End
	End
	
	Field SkidCounter:Int = 0
	
	Field DistanceToStep:Float = 32
	
	Field ShowDebug:Bool = False
	
	Field OverNoRopeZone:Bool = False
	
	Field ReadyToPlay:Bool = False
	
	Global GenerateRainbowTrail:Bool = False
	Global GenerateRainbowTrailTimer:Int = 0
	Global GenerateColorTrail:Bool = False
	Global GenerateColorTrailTimer:Int = 0
	
	Function UpdateTrailMode:Void(oM:Int)
		Select oM
			Case 0
				GenerateRainbowTrail = False
				GenerateColorTrail = False
			Case 1
				GenerateRainbowTrail = False
				GenerateColorTrail = True
			Case 2
				GenerateRainbowTrail = True
				GenerateColorTrail = False
		End
	End
	
	Method New()
		Colour = New Color(255,0,0)
		Rope = New LevelRope()
		Restart()
	End
	
	
	
	Method Restart:Void()
	
		ReadyToPlay = False
		XS = 0
		YS = 0
		Rope.X = X
		Rope.Y = Y
		Rope.OldX = X
		Rope.OldY = Y
		OldX = X
		OldY = Y
		Rope.Restart()
		Alive = True
		ColourInt = 0
		Colour.SetHSB(0,100,50)
		
	End
	
	Method Update:Void()
	
		If Alive = True
		
			OldX = X
			OldY = Y
		
			NinjahSprite.Update()
			
			If ReadyToPlay = True
			
				
		
				If ReadyToShoot > 0
					ReadyToShoot -= 1
				Else
					If Game.Gun
						Local GunPressed:Bool = False
						If NinjahApp.Keyboard = True
							If MouseDown(MOUSE_RIGHT)
								GunPressed = True
							EndIf
						Else
							If JoyZ(1) > 0
								GunPressed = True
							EndIf
						EndIf
						
						Local bD:Float
						
						If GunPressed = True
							If NinjahApp.Keyboard
								bD = DirectionBetweenPoints(X + 8, Y + 8, VMouseX(), VMouseY(), 180)
							Else
								bD = DirectionBetweenPoints(0,0,JoyX(1),JoyY(1))	
							EndIf
						
							
							Local tColour:Color = New Color()
							tColour.SetHSB(0.0,100.0,50.0)
							tColour.ShiftHue(ColourInt * 18)
							
							MySoundSystem.Play("shot", 0.1)
							
							LevelBullet.Create(X+(W*0.5),Y+(H*0.5),bD,tColour)
							XS -= (Sin(bD) * ShootXRate) / DivideRate
							YS += (Cos(bD) * ShootYRate) / DivideRate
							ReadyToShoot = 8 * DivideRate
						End
					End
				End
			
				If Game.Move = True
					If JoyX(0) > 0 Or KeyDown(KEY_D) Or KeyDown(KEY_RIGHT)
					
						If XS < 0
							XS += ( MoveXS )  / DivideRate
							If OnFloor = True
								If SkidCounter = 0
									If Game.GravityFlipped = True
										GenerateSkidParticles(X,Y,XS)
									Else
										GenerateSkidParticles(X,Y+H,XS)
									EndIf
									SkidCounter = 6
								Else
									SkidCounter -= 1
								End
							End
						End
						
						If XS < FLOOR_MAX_XS
							XS += ( MoveXS )  / DivideRate
						End
					End
					
					If JoyX(0) < 0 Or KeyDown(KEY_A) Or KeyDown(KEY_LEFT)
					
						If XS > 0
							XS -= ( MoveXS )  / DivideRate
							If OnFloor = True
								If SkidCounter = 0
									If Game.GravityFlipped = True
										GenerateSkidParticles(X,Y,XS)
									Else
										GenerateSkidParticles(X,Y+H,XS)
									EndIf
									
									SkidCounter = 6
								Else
									SkidCounter -= 1
								End
							End
						End
					
						If XS > 0 - FLOOR_MAX_XS
							XS -= ( MoveXS )  / DivideRate
						End
					End
				End
				
				If OnFloor = True
				
					If XS < 0
						DistanceToStep += XS
					Else
						DistanceToStep -= XS
					End
					
					If DistanceToStep <= 0
						Local stepVol:Float = (XS / (4 / DivideRate))
						stepVol = (stepVol + 1.0) / 2.0
						If stepVol < 0
							stepVol = 0 - stepVol
						End
						MySoundSystem.Play("step",stepVol)
						DistanceToStep = 30
					End
				
					Local MovingLeftOrRight:Bool = False
					
					If Game.Move = True
						If NinjahApp.Keyboard = True
							 If KeyDown(KEY_A) Or KeyDown(KEY_D) Or KeyDown(KEY_RIGHT)
							 	MovingLeftOrRight = True
							 EndIf
						Else
							If JoyX(0) <> 0
								MovingLeftOrRight = True
							EndIf
						EndIf
					End
					
					
					If MovingLeftOrRight = True
						If XS < 0 - FLOOR_MAX_XS Or XS > FLOOR_MAX_XS
							XS *= FloorResistance
						End
					Else
						XS *= FloorResistance
					End
					
					If Game.Move = True
						If Game.GravityFlipped = True
							If JoyY(0) > 0.25 OR KeyDown(KEY_W) Or KeyDown(KEY_UP)
								YS = (JumpRate / DivideRate)
								MySoundSystem.Play("jump")
								GenerateJumpParticles(X,Y)
							End
						Else
							If JoyY(0) > 0.25 OR KeyDown(KEY_W) Or KeyDown(KEY_UP)
								YS = 0 - (JumpRate / DivideRate)
								MySoundSystem.Play("jump")
								GenerateJumpParticles(X,Y+H)
							End
						EndIf
						
					End
				End
			Else
				ReadyToPlay = True
			End
			
			If Game.GravityFlipped = True
				YS -= (G / DivideRate)
			Else
				YS += (G / DivideRate)
			EndIf
			
			
			XS = Clamp(XS,0-MAX_XS,MAX_XS)
			YS = Clamp(YS,0-MAX_YS,MAX_YS)
		
			X += XS
			Y += YS
			
			If GenerateRainbowTrail = True
				GenerateRainbowTrailTimer += 1
				If GenerateRainbowTrailTimer = 4
					GenerateRainbowParticles(X + 8,Y + 8,OldX + 8,OldY + 8)
					GenerateRainbowTrailTimer = 0
				End
			EndIf
			
			If GenerateColorTrail = True
				GenerateColorTrailTimer += 1
				If GenerateColorTrailTimer = 4
					GenerateColorParticles(X + 8,Y + 8,OldX + 8,OldY + 8, ColourInt)
					GenerateColorTrailTimer = 0
				End
			EndIf
			
			If Rope.Status = LevelRope.CONNECTED
				UpdateFromRope()
			End
			Rope.Update()
			
			
		End
	End
	
	Method UpdateFromRope:Void()
		
		Local y_factor:float = (Y - Rope.Y) / (X - Rope.X)
		if y_factor < 0
			y_factor = 0 - y_factor
		End
		Local x_factor:float = (X - Rope.X) / (Y - Rope.Y)
		if x_factor < 0
			x_factor = 0 - x_factor
		End
		
		
		
		if y_factor > 1
			y_factor = 1
		End
		if x_factor > 1
			x_factor = 1
		End
		
		
		if X + (LevelPlayer.W / 2) < Rope.X - 20
			XS += (MoveRopeXS * 2 * x_factor)  / DivideRate
		else if X + (LevelPlayer.W / 2) > Rope.X + 20
			XS -= (MoveRopeXS * 2 * x_factor)  / DivideRate
		Else
			If OldX < Rope.X And X > Rope.X
				XS *= 0.995
			End
			
			If OldX > Rope.X And X < Rope.X
				XS *= 0.995
			End
		End
		
		if Y < Rope.Y - RopeLength
			YS += (MoveRopeYS * y_factor) / DivideRate
		elseif Y > Rope.Y + RopeLength
			YS -= (MoveRopeYS * y_factor) / DivideRate
		Else
			If OldY < (Rope.Y - RopeLength) And Y > (Rope.Y - RopeLength)
				YS *= 0.995
			End
			
			If OldY > (Rope.Y + RopeLength) And Y < (Rope.Y + RopeLength)
				YS *= 0.995
			End
		End
		
		
		if XS > 12
			XS = 12 / DivideRate
		End
		if XS < 0 - 12 / DivideRate
			XS = 0 - 12 / DivideRate
		End
		if YS > 12 / DivideRate
			YS = 12 / DivideRate
		End
		if YS < 0 - 12 / DivideRate
			YS = 0 - 12 / DivideRate
		End
	End
	
	Method Draw:Void()
		If Alive = True
		
			NinjahSprite.Draw()
		
			'DisplayEngineValues()
			
		End
	End
	
	Method ChangeColour(NewColour:Int)
		ColourInt = NewColour
		Colour.SetHSB(0,100,50)
		Colour.ShiftHue(18 * NewColour)
		
		' TODO - SPARKLIES AND SOUND
	End
	
	Method Die:Void(DeathColour:Int)
		' TODO - SPARKLIES AND SOUND
		MySoundSystem.Play("die")
		Alive = False
		X = Game.StartX
		Y = Game.StartY
		Rope.Status = LevelRope.IN
		NinjahSprite.Update()
		
	End
	
End


