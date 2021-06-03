Import ninjah

Class LevelBullet

	Global BulletCount:Int = 20
	Global NextBullet:Int = 0
	Global Bullets:LevelBullet[]

	Global TileSet:Image
	
	Field OldX2:Float
	Field OldY2:Float
	Field OldX:Float
	Field OldY:Float
	Field X:Float
	Field Y:Float
	Field D:Float
	Field Colour:Color
	Field A:Float
	Field AR:Float
	Field Active:Bool = False
	
	Const S:Float = 16
	
	Function Init:Void()
		Bullets = New LevelBullet[BulletCount]
		For Local i:Int = 0 To BulletCount - 1
			Bullets[i] = New LevelBullet()
		Next
	End
	
	Function UpdateAll:Void()
		For Local i:Int = 0 To BulletCount - 1
			If Bullets[i].Active = True
				Bullets[i].Update()
			End
		Next
	End
	
	Function DrawAll:Void()
		SetBlend(1)
		For Local i:Int = 0 To BulletCount - 1
			If Bullets[i].Active = True
				Bullets[i].Draw()
			End
		Next
		SetBlend(0)
	End
	
	Function Create:Void(tX:Float,tY:Float,tD:Float,tC:Color)
		Bullets[NextBullet].Activate(tX,tY,tD,tC)
		NextBullet+=1
		If NextBullet = BulletCount
			NextBullet = 0
		End
	End
	
	Method Activate(tX:Float,tY:Float,tD:Float,tC:Color)
		Active = True
		X = tX
		Y = tY
		OldX = X
		OldY = Y
		OldX2 = X
		OldY2 = Y
		D = tD
		Colour = tC
		A = 1
		AR = 0.03
	End
	
	Method Update:Void()
	
		OldX2 = OldX
		OldY2 = OldY
	
		OldX = X
		OldY = Y
	
		X += (Sin(D) * S)
		Y -= (Cos(D) * S)
		A -= AR
		Colour.ShiftHue(10)
		If A <= 0
			Active = False
		End
	End
	
	Method Draw:Void()
		'SetAlpha(A)
		SetColor(Colour.r,Colour.g,Colour.b)
		'DrawImage(TileSet,X,Y)
		'DrawBlur(TileSet,OldX,OldY,X,Y,0,A/3,5)
		DrawBlur(TileSet,OldX2,OldY2,X,Y,0-D,0,A/2,5)
	End
	
End

