Import ninjah

Class Firework

	Global ActiveForLaunch:Bool = False

	Global NextFirework:Int = 0
	Global FireworkCount:Int = 30
	Global Fireworks:Firework[]
	
	Global QuickCounter:Int = 0
	'Global _list:List<Firework>
	Function Init:Void()
		Fireworks = New Firework[FireworkCount]
		For Local i:Int = 0 To FireworkCount - 1
			Fireworks[i] = New Firework()
		Next
		FireWorkParticle.Init()
		'_list = New List<Firework>
	End
	Function UpdateAll:Void()
	
		If ActiveForLaunch
		
			If QuickCounter = -120
				Local i:Int = Abs(Rnd(0,300))
				if i = 1
					Firework.Add()
					'Firework._list.AddLast( New Firework() )
					MySoundSystem.Play("firework_launch")
				End
			Else
				QuickCounter -= 1
				If QuickCounter < 30 And QuickCounter >= 0
					If QuickCounter Mod 10 = 0	
						MySoundSystem.Play("firework_launch")
						Firework.AddUniform(640 + (QuickCounter * 14))
						Firework.AddUniform(640 - (QuickCounter * 14))
					EndIf
				EndIf
			End
		End
	
		'If JoyDown(JOY_Y)
			'Firework.Add()
			'Firework._list.AddLast( New Firework() )
		'End
		
		For Local i:Int = 0 To FireworkCount - 1
			If Fireworks[i].Active = True
				Fireworks[i].Update()
			End
		Next
		
		'For Local tF:Firework = EachIn Firework._list
		'	tF.Update()
		'Next
	End
	Function DrawAll:Void()
		'For Local tF:Firework = EachIn Firework._list
		'	tF.Draw()
		'Next
		For Local i:Int = 0 To FireworkCount - 1
			If Fireworks[i].Active = True
				Fireworks[i].Draw()
			End
		Next
	End
	
	Function Add:Void()
		Fireworks[NextFirework].Create()
		NextFirework += 1
		If NextFirework = FireworkCount
			NextFirework = 0
		End
	End
	
	Function AddUniform:Void(oX:Int)
		Fireworks[NextFirework].CreateUniform(oX)
		NextFirework += 1
		If NextFirework = FireworkCount
			NextFirework = 0
		End
	End
	
	Function Clear:Void()
		For Local i:Int = 0 To FireworkCount - 1
			Fireworks[i].Active = False
		Next
	End

	Field X:Float
	Field Y:Float
	Field XS:Float
	Field YS:Float
	
	Field TargetYS:Float
	
	Field OldX1:Float
	Field OldY1:Float
	Field OldX2:Float
	Field OldY2:Float
	
	Field colour:Color
	Field colourInt:Int
	
	Field ExplosionSize:Int = 0
	
	Field TrailCounter:Int = 0
	
	Field Active:Bool = False
	
	Method New()
		colour = New Color()
	End
	
	Method Create:Void()
		X = (NinjahApp.ScreenWidth / 4) + Rnd(0,NinjahApp.ScreenWidth /2)
		Y = NinjahApp.ScreenHeight + 10
		YS = 0 - Rnd(5,9)
		XS = Rnd(-4,4)
		OldX1 = X
		OldX2 = X
		OldY1 = Y
		OldY2 = Y
		TargetYS = 0 - (YS/2)
		ExplosionSize = Abs(Rnd(15,40))
		colourInt = Abs(Rnd(0,20))
		'colour = New Color()
		colour.SetHSB(0,100,50)
		colour.ShiftHue((colourInt * 18))
		Active = True
	End
	
	Method CreateUniform:Void(oX:Int)
		X = oX
		Y = NinjahApp.ScreenHeight + 10
		Select oX
			Case 360,920
				YS = 0 - 7
			Case 780,500
				YS = 0 - 7.5
			Case 640
				YS = 0 - 8
		End
		XS = 0
		OldX1 = X
		OldX2 = X
		OldY1 = Y
		OldY2 = Y
		TargetYS = 0
		ExplosionSize = Abs(Rnd(15,40))
		colourInt = Abs(Rnd(0,20))
		
		colour.SetHSB(0,100,50)
		colour.ShiftHue((colourInt * 18))
		Active = True
		
	End
	
	Method Update:Void()
		OldX2 = OldX1
		OldX1 = X
		OldY2 = OldY1
		OldY1 = Y
		
		X += XS
		Y += YS
		YS += 0.05
		
		If TrailCounter < 5
			TrailCounter += 1
		Else
			GenerateTrailParticles(X,Y,colourInt)
			TrailCounter = 0
		End
		
		If YS >= TargetYS
			CreateExplosion()
			Local v:Float = (ExplosionSize/40.0)
			Local p:Float = ((X / NinjahApp.ScreenWidth) - 0.5) * 2
			MySoundSystem.Play("firework_pop",v,p)
		End
	End
	
	Method CreateExplosion:Void()
		Local tD:Float = 0
		Local tDS:Float = 360.0 / ExplosionSize
		While tD < 355
			
			Local tXS:Float = (ExplosionSize / 2) * (Sin(tD)) * 0.5
			Local tYS:Float = (ExplosionSize / 2) * (Cos(tD)) * 0.5
			
			'Local tFB:FireWorkParticle = New FireWorkParticle()
			
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].X = X
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].Y = Y
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldX1 = X
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldY1 = Y
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldX2 = X
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldY2 = Y
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldX3 = X
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldY3 = Y
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldX4 = X
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].OldY4 = Y
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].XS = tXS
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].YS = tYS
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].XSMT = ParticleSpeedModifier.Multiply
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].YSMT = ParticleSpeedModifier.Multiply
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].XSM = 0.97
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].YSM = 0.97
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].A = 1
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].AMT = ParticleAlphaModifier.Add
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].AS = -0.01
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].L = 120
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].colourInt = colourInt
			'FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].C = New Color()
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].C.SetHSB(0,100,50)
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].C.ShiftHue(colourInt * 18)
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].I = ParticleSprites.STAR
			FireWorkParticle.FireworkParticles[FireWorkParticle.NextFireworkParticle].Active = True
			
			'ParticleManager.Particles.AddLast(tFB)
			FireWorkParticle.Add()
		
			tD += tDS
		Wend
		Active = False
	End
	
	Method Draw:Void()
		SetColor(colour.r,colour.g,colour.b)
		SetAlpha(1)
		'DrawImageBlur(TileSet,)
		'DrawImage(Pa
		DrawImage(ParticleSprites.Standard,X,Y)
	End
		
End