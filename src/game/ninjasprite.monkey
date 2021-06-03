Import ninjah


Class NinjahSprite

	Const Width:Int = 16
	Const Height:Int = 16
	
	Global Mode:Int = 0
	' 0 = Normal
	' 1 = Falafel
	' 2 = VVVVVV
	
	Global Sprite2:Image
	Global Sprite3:Image

	Global Skidding:Bool
	Global OnFloor:Bool
	Global Shooting:Bool
	Global Roping:Bool
	
	Const LEFT:Int = 0
	Const RIGHT:Int = 1
	Global Direction:Int = LEFT
	
	Global X:Float
	Global Y:Float
	
	Function UpdateSpriteMode:Void(oM:Int)
		Mode = oM
		
	End
	
	Global ShootArmX:Float
	Global RopeArmX:Float
	Global ShootArmY:Float
	Global RopeArmY:Float
	Global HeadX:Float
	Global HeadY:Float
	Global BodyX:Float
	Global BodyY:Float
	Global EyeX:Float
	Global EyeY:Float
	Global EyeR:Float = 4
	Global LeftFootX:Float
	Global RightFootX:Float
	Global LeftFootY:Float
	Global RightFootY:Float
	
	
	Global gfxBody:Image
	Global gfxArm:Image
	Global gfxFoot:Image
	Global gfxHeadLeft:Image
	Global gfxHeadRight:Image
	Global gfxHeadFront:Image
	Global gfxEye:Image
	
	Global GunArmDirection:Float
	Global RopeArmDirection:Float
	
	Function Init:Void()
		gfxBody = LoadImage("graphics/ninjah_body.png",1,Image.MidHandle)			' 12x12
		
		gfxArm = LoadImage("graphics/ninjah_arm.png") ' FACING UP					' 6x12
		gfxArm.SetHandle( gfxArm.Width * 0.5, gfxArm.Height * 0.75)
		
		gfxFoot = LoadImage("graphics/ninjah_foot.png",1,Image.MidHandle)			' 3x3
		gfxHeadLeft = LoadImage("graphics/ninjah_headleft.png",1,Image.MidHandle) 		' 8x8
		gfxHeadRight = LoadImage("graphics/ninjah_headright.png",1,Image.MidHandle) 		' 8x8
		gfxHeadFront = LoadImage("graphics/ninjah_head.png",1,Image.MidHandle) 		' 8x8
		gfxEye = LoadImage("graphics/ninjah_eye.png",1,Image.MidHandle)				' 2x2
		
		Sprite2 = LoadImage("graphics/vvvvvv_sprite.png",16,16,8,Image.DefaultFlags)
		Sprite3 = LoadImage("graphics/falafel2_sprite.png",16,16,4,Image.DefaultFlags)
	End
	
	Function Update:Void()
		Select Mode
			Case 0
				Update1()
			Case 1,2
				Update2()
		End
	End
	
	Global Sprite2Timer:Int = 0
	Global Sprite2Frame:Int = 0
	Global FrameOffset:Int = 0
	Function Update2:Void()
	
		X = Game.Player.X
		Y = Game.Player.Y
		
		If Game.Rope = True And Game.Player.Rope.Status <> LevelRope.IN
			Roping = True
		Else
			Roping = False
		End
	
		If Game.Player.YS < 0
			Sprite2Frame = 0
			Sprite2Timer = 0
		Else
			If Game.Player.XS < -0.1 OR Game.Player.XS > 0.1
				Sprite2Timer += 1
				
				If Sprite2Timer >= 15
					Sprite2Timer = 0
					Sprite2Frame += 1
				EndIf
				
				If Sprite2Frame = 2
					Sprite2Frame = 0
				EndIf
				
			Else
				Sprite2Frame = 0
				Sprite2Timer = 0
			End
			
		EndIf
		
		If Game.Player.XS < 0
			FrameOffset = 2
		Else
			FrameOffset = 0			
		EndIf
		
	End
	
	Function Update1:Void()
	
		
	
		If NinjahApp.Keyboard = True
			GunArmDirection = DirectionBetweenPoints(Game.Player.X + 8,Game.Player.Y + 8, VMouseX(), VMouseY(), 180)
		Else
			GunArmDirection =  DirectionBetweenPoints(0,0,JoyX(1),JoyY(1))
		End
		
		RopeArmDirection = DirectionBetweenPoints(Game.Player.X + 8,Game.Player.Y+ 8,Game.Player.Rope.X,Game.Player.Rope.Y)
	
		X = Game.Player.X
		Y = Game.Player.Y
		
		If NinjahApp.Keyboard = True
			If Game.Gun = True And MouseDown(MOUSE_RIGHT)
				Shooting = True
			Else
				Shooting = False
			End
		Else
			If Game.Gun = True And JoyZ(1) > 0
				Shooting = True
			Else
				Shooting = False
			End
		EndIf
		
		
		If Game.Rope = True And Game.Player.Rope.Status <> LevelRope.IN
			Roping = True
		Else
			Roping = False
		End
		
		OnFloor = Game.Player.OnFloor
		
		If NinjahApp.Keyboard = True
			If Game.Player.XS < 0 And KeyDown(KEY_D)
				Skidding = True
			ElseIf Game.Player.XS > 0 And KeyDown(KEY_A)
				Skidding = True
			Else
				Skidding = False
			End
			
			If KeyDown(KEY_A)
				Direction = LEFT
			ElseIf KeyDown(KEY_D)
				Direction = RIGHT
			Else
				If Game.Player.XS < 0
					Direction = LEFT
				Else
					Direction = RIGHT
				End
			End
		Else
			If Game.Player.XS < 0 And JoyX(0) > 0
				Skidding = True
			ElseIf Game.Player.XS > 0 And JoyX(0) < 0
				Skidding = True
			Else
				Skidding = False
			End
			
			If JoyX(1) < 0
				Direction = LEFT
			ElseIf JoyX(1) > 0
				Direction = RIGHT
			Else
				If Game.Player.XS < 0
					Direction = LEFT
				Else
					Direction = RIGHT
				End
			End
		EndIf
		
		' SET UP DRAWING LOCATIONS
		HeadX = X + (Width * 0.5)
		HeadY = Y + (Height * 0.1)
		
		EyeX = X + (Width * 0.5)
		EyeY = Y + (Height * 0.125)
		
		ShootArmY = Y + (Height * 0.5)
		RopeArmY = Y + (Height * 0.5)
		
		BodyX = X + (Width * 0.5)
		BodyY = Y + (Height * 0.5)
		
		If OnFloor = True
			
			If Skidding = True
				If Direction = LEFT
					LeftFootX = X + (Width * 0.25)
					LeftFootY = Y + (Height * 1)
					RightFootX = X + (Width * 0.5)
					RightFootY = Y + (Height * 1)
				Else
					LeftFootX = X + (Width * 0.75)
					LeftFootY = Y + (Height * 1)
					RightFootX = X + (Width * 0.5)
					RightFootY = Y + (Height * 1)
				End
			Else
				If Game.Player.XS <> 0
					LeftFootX = X + (Width * 0.35)
					RightFootX = X + (Width * 0.65)
					LeftFootY = Y + (Height * 0.9) + ( Sin(Game.Player.X * 8) * 1 )
					RightFootY = Y + (Height * 0.9) - ( Sin(Game.Player.X * 8) * 1 )
				Else
					LeftFootX = X + (Width * 0.4)
					RightFootX = X + (Width * 0.6)
					LeftFootY = Y + (Height * 1)
					RightFootY = Y + (Height * 1)
				End
			End
		Else
			If Game.Player.YS < 0
				LeftFootX = X + (Width * 0.2)
				LeftFootY = Y + (Height * 0.8)
				RightFootX = X + (Width * 0.8)
				RightFootY = Y + (Height * 0.8)
			Else
				LeftFootX = X + (Width * 0.3)
				LeftFootY = Y + (Height * 0.9)
				RightFootX = X + (Width * 0.7)
				RightFootY = Y + (Height * 0.9)
			End
		End
		
		If Direction = LEFT
		
			ShootArmX = X + (Width * 0.5)
			RopeArmX = X + (Width * 0.6)
			
		Else
			ShootArmX = X + (Width * 0.5)
			RopeArmX = X + (Width * 0.5)
			
		End
		
	End
	
	Function Draw:Void()
		Select Mode
			Case 0
				DrawSprite1()
			Case 1,2
				DrawSprite2()
		End
	End
	
	Function DrawSprite2:Void()
		If Roping = True
			' TODO DRAW ROPE CODE
			SetBlend(1)
			SetAlpha(0.3)
			SetColor(Game.Player.Colour.r,Game.Player.Colour.g,Game.Player.Colour.b)
			DrawNewLine(Game.gfxPixel,Game.Player.X+(LevelPlayer.W*0.5),Y+(LevelPlayer.H*0.5),Game.Player.Rope.X,Game.Player.Rope.Y,1,0.75)
			SetBlend(0)
			SetAlpha(1)
			SetColor(255,255,255)
			DrawImage(LevelRope.TileSet,Game.Player.Rope.X,Game.Player.Rope.Y)
		End
		
		SetBlend(0)
		SetAlpha(1)
		
		Select Mode
			Case 2
				Local FlipOffset:Int = 0
				If Game.GravityFlipped = True
					FlipOffset = 4
				EndIf
				SetColor(Game.Player.Colour.r,Game.Player.Colour.g,Game.Player.Colour.b)
				DrawImage(Sprite2,X,Y,FlipOffset + FrameOffset + Sprite2Frame)
				SetAlpha(0.5)
				SetColor(255,255,255)
				DrawImage(Sprite2,X,Y,FlipOffset + FrameOffset + Sprite2Frame)
			Case 1
				SetAlpha(1)
				SetColor(255,255,255)
				Local tmpX:Int = Int(X)
				Local tmpY:Int = Int(Y)
				DrawImage(Sprite3,tmpX,tmpY,FrameOffset + Sprite2Frame)
		End
		
	End
	
	Function DrawSprite1:Void()
	
		SetAlpha(1)
		SetColor(255,255,255)
		SetBlend(0)
	
		
		DrawImage(gfxFoot,LeftFootX,LeftFootY)
		DrawImage(gfxFoot,RightFootX,RightFootY)
		
		' BODY AND ARMS - SHOOT = LEFT ARM, ROPE = RIGHT ARM
		If Direction = LEFT
		
			' SHOOTING ARM 
			If Shooting = True
				'DrawImage(gfxArm, ShootArmX, ShootArmY,ArmDirection,1,1,0)
			Else
				'DrawImage(gfxArm, ShootArmX, ShootArmY,170,1,1,0)
			End
			
			' BODY
			DrawImage(gfxBody,BodyX,BodyY)
			
			DrawHead()
			
			
			' ROPE ARM
			
			If Roping = True
			
				' TODO DRAW ROPE CODE
				SetBlend(1)
				SetAlpha(0.3)
				SetColor(Game.Player.Colour.r,Game.Player.Colour.g,Game.Player.Colour.b)
				DrawNewLine(Game.gfxPixel,Game.Player.X+(LevelPlayer.W*0.5),Y+(LevelPlayer.H*0.5),Game.Player.Rope.X,Game.Player.Rope.Y,1,0.75)
				SetBlend(0)
				SetAlpha(1)
				SetColor(255,255,255)
				DrawImage(LevelRope.TileSet,Game.Player.Rope.X,Game.Player.Rope.Y)
			
				DrawImage(gfxArm, RopeArmX, RopeArmY,RopeArmDirection,1,1,0)
			Else
				SetColor(255,255,255)
				DrawImage(gfxArm, RopeArmX, RopeArmY,190,1,1,0)
			End
		Else
		
		
			' ROPE ARM
			If Roping = True
			
				' TODO DRAW ROPE CODE
				SetBlend(1)
				SetAlpha(0.3)
				SetColor(Game.Player.Colour.r,Game.Player.Colour.g,Game.Player.Colour.b)
				DrawNewLine(Game.gfxPixel,Game.Player.X+(LevelPlayer.W*0.5),Game.Player.Y+(LevelPlayer.H*0.5),Game.Player.Rope.X,Game.Player.Rope.Y,1,0.75)
				SetBlend(0)
				SetAlpha(1)
				SetColor(255,255,255)
				DrawImage(LevelRope.TileSet,Game.Player.Rope.X,Game.Player.Rope.Y)
			
				DrawImage(gfxArm, RopeArmX, RopeArmY,RopeArmDirection + 180,1,1,0)
			Else
				SetColor(255,255,255)
				DrawImage(gfxArm, RopeArmX, RopeArmY,190,1,1,0)
			End
			
			' BODY
			'DrawImage(gfxBody,BodyX,BodyY)
			
			SetColor(255,255,255)
			DrawHead()
			
			' SHOOTING ARM 
			If Shooting = True
				SetColor(255,255,255)
				DrawImage(gfxArm, ShootArmX, ShootArmY,0-GunArmDirection,1,1,0)
			Else
				SetColor(255,255,255)
				DrawImage(gfxArm, ShootArmX, ShootArmY,170,1,1,0)
			End
			
		End
		
	End
	
	Function DrawHead:Void()
		If JoyX(1) <> 0 Or JoyY(1) <> 0
			
			If GunArmDirection < 45
				' TODO DRAW HEAD LOOKING UP
				DrawImage(gfxHeadFront,HeadX,HeadY)
			ElseIf GunArmDirection < 135
				' TODO DRAW HEAD LOOKING RIGHT
				DrawImage(gfxHeadRight,HeadX,HeadY)
			ElseIf GunArmDirection < 225
				' TODO DRAW HEAD LOOKING DOWN
				DrawImage(gfxHeadFront,HeadX,HeadY)
			ElseIf GunArmDirection < 315
				' TODO DRAW HEAD LOOKING LEFT
				DrawImage(gfxHeadLeft,HeadX,HeadY)
			Else
				' TODO DRAW HEAD LOOKING UP
				DrawImage(gfxHeadFront,HeadX,HeadY)
			End
			
			If GunArmDirection >= 100 And GunArmDirection <= 260
				' TODO DRAW EYES
				DrawImage(gfxEye,EyeX - ( Sin(GunArmDirection + 180) * EyeR ),EyeY + ( Cos(GunArmDirection + 180) * (EyeR * 0.5) ))
			End
			
			
		Else
			If Direction = LEFT
				' TODO DRAW HEAD LOOKING LEFT
				DrawImage(gfxHeadLeft,HeadX,HeadY)
				If Skidding = True
					DrawImage(gfxEye,EyeX + ( Sin(135) * EyeR ),EyeY - ( Cos(260) * (EyeR * 0.5) ))
				Else
					DrawImage(gfxEye,EyeX + ( Sin(225) * EyeR ),EyeY - ( Cos(260) * (EyeR * 0.5) ))
				End
			Else
				' TODO DRAW HEAD LOOKING RIGHT
				DrawImage(gfxHeadRight,HeadX,HeadY)
				If Skidding = True
					DrawImage(gfxEye,EyeX + ( Sin(225) * EyeR ),EyeY - ( Cos(260) * (EyeR * 0.5) ))
				Else
					DrawImage(gfxEye,EyeX + ( Sin(135) * EyeR ),EyeY - ( Cos(260) * (EyeR * 0.5) ))
				End
			End
		End
	End

End
