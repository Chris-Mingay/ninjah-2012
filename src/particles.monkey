Import ninjah

Class ParticleSprites

	Const STAR:Int = 0
	Const STANDARD:Int = 1
	
	Global Star:Image
	Global Standard:Image
	
	Function Init:Void()
	
		Star = LoadImage("graphics/particle_star.png",1,Image.MidHandle)
		Standard = LoadImage("graphics/particle_standard.png",1,Image.MidHandle)
	End
	

End

Function GenerateRopeShootParticles:Void(rX:Float, rY:Float, rD:Float, pC:Color)
	For Local i:Int = 0 To 1
		ParticleManager.Particles[ParticleManager.NextParticle].X = rX
		ParticleManager.Particles[ParticleManager.NextParticle].Y = rY
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.3
		
		Local speed:Float = 2.0
		Local angle:Float = 45
		
		If i = 0
			ParticleManager.Particles[ParticleManager.NextParticle].XS = Sin(rD - angle) * speed
			ParticleManager.Particles[ParticleManager.NextParticle].YS = Cos(rD - angle) * speed
		Else
			ParticleManager.Particles[ParticleManager.NextParticle].XS = Sin(rD + angle) * speed
			ParticleManager.Particles[ParticleManager.NextParticle].YS = Cos(rD + angle) * speed
		End
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle]. AS= -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = 0.95
		ParticleManager.Particles[ParticleManager.NextParticle].XSM = 0.95
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		
		ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(pC.r, pC.g, pC.b)
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.3
	
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	End
End

Function GenerateRainbowParticles:Void(oX:Float,oY:Float,oXS:Float,oYS:Float)
	If oXS > oX + 0.01 Or oXS < oX -0.01 Or oYS > oY + 0.01 Or oYS < oY -0.01
		' Local tempD:Float = DirectionBetweenPoints(0,0,oXS,oYS)
		Local tempD:Float = DirectionBetweenPoints(oXS,oYS,oX,oY)
		tempD -= 90
		Local XR:Float = Sin(tempD) * 1
		Local YR:Float = Cos(tempD) * 2
		
		Local tmpX:Float = oX - (XR * 4)
		Local tmpY:Float = oY  - (YR * 4)
		
		For Local i:Int = 0 To 9
			GenerateRainbowTrailParticles(tmpX,tmpY,(i*2))
			tmpX += XR
			tmpY += YR
		Next
	EndIf
	
End

Function GenerateColorParticles:Void(oX:Float,oY:Float,oXS:Float,oYS:Float,oC:Int)
	If oXS > oX + 0.02 Or oXS < oX -0.02 Or oYS > oY + 0.02 Or oYS < oY -0.02
		GenerateColorTrailParticles(oX,oY,oC,0)
		GenerateColorTrailParticles(oX,oY,oC,1)
	EndIf
	
End

Function GenerateExitParticles:Void(oX:Int,oY:Int)
	
	Local pW:Int = 4

	For Local tY:Int = -4 To 3
		For Local tX:Int = -4 To 3
			'Local tP:Particle = New Particle()
			ParticleManager.Particles[ParticleManager.NextParticle].X = oX - ((tX + 0.5) * pW)
			ParticleManager.Particles[ParticleManager.NextParticle].Y = oY - ((tY + 0.5) * pW)
			ParticleManager.Particles[ParticleManager.NextParticle].XS = 0 - ((tX + 0.5) * 0.1)
			ParticleManager.Particles[ParticleManager.NextParticle].YS = 0 - ((tY + 0.5) * 0.1)
			ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
			ParticleManager.Particles[ParticleManager.NextParticle].A = 1
			ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
			ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
			ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.None
			ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
			ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Normal
			ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
			ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.3
			'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
			If tY <= -1 And tX <= -1
				ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
			ElseIf tY >= 0  And tX >= 0
				ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
			Else
				ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(255,255,255)
			End
			
			ParticleManager.Particles[ParticleManager.NextParticle].Active = True
			ParticleManager.Add()
			
		Next
	Next


End

Function GenerateChangeParticles:Void(oX:Float,oY:Float,oC:Int)
	Local pW:Int = 16
	Local pC:Int = 25
	For Local i:Int = 0 to pC - 1
		'Local tP:Particle = New Particle()
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].XS = Rnd(-0.1,0.1)
		ParticleManager.Particles[ParticleManager.NextParticle].YS = Rnd(-0.2,-0.1)
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.005
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = 1 + Rnd(0.01,0.02)
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.5
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
		ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue(oC * 18)
		ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	Next
End

Function GenerateDeathParticles:Void(oX:Float,oY:Float,oC:Int)
	Local pW:Int = 16
	Local pC:Int = 50
	For Local i:Int = 0 to pC - 1
		'Local tP:Particle = New Particle()
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].XS = Rnd(-4,4)
		ParticleManager.Particles[ParticleManager.NextParticle].YS = Rnd(-4,4)
		ParticleManager.Particles[ParticleManager.NextParticle].A = 1
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].XSM = 0.96
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = 0.96
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.3
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
		ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue(oC * 18)
		ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	Next
End

Function GenerateCoinParticles:Void(oX:Float,oY:Float)
	Local pW:Float = 4
	Local pS:Float = 1
	Local pD:Float = 0
	Local pC:Float = 20
	Local pR:Float = 360 / pC

	Local Yellow:Bool = True

	While pD < 360
		'Local tP:Particle = New Particle()
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX + (Sin(pD) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY + (Cos(pD) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].XS = Sin(pD) * pS
		ParticleManager.Particles[ParticleManager.NextParticle].YS = Cos(pD) * pS
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		If Yellow = True
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(253,255,110)
		Else
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(255,255,255)
		End

		Yellow = Not Yellow
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
		
		pD += pR
	Wend
End

Function GenerateTrailParticles:Void(oX:Float,oY:Float,oC:Int)
	'Local tP:Particle = New Particle()
	ParticleManager.Particles[ParticleManager.NextParticle].dScale = 1
	ParticleManager.Particles[ParticleManager.NextParticle].X = oX
	ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
	ParticleManager.Particles[ParticleManager.NextParticle].XS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].YS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
	ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.02
	ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
	ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
	ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
	'ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
	ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
	ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue(oC * 18)	
	ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
	
	ParticleManager.Particles[ParticleManager.NextParticle].Active = True
	ParticleManager.Add()
End

Function GenerateRainbowTrailParticles:Void(oX:Float,oY:Float,oC:Int)
	'Local tP:Particle = New Particle()
	ParticleManager.Particles[ParticleManager.NextParticle].dScale = 1
	ParticleManager.Particles[ParticleManager.NextParticle].X = oX
	ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
	ParticleManager.Particles[ParticleManager.NextParticle].XS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].YS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
	ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.04
	ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
	ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
	ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
	'ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
	ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
	ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue(oC * 18)	
	ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Normal
	
	ParticleManager.Particles[ParticleManager.NextParticle].Active = True
	ParticleManager.Add()
End

Function GenerateColorTrailParticles:Void(oX:Float,oY:Float,oC:Int,oT:Int)
	'Local tP:Particle = New Particle()
	If oT = 0
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.25
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 1.5
	ElseIf oT = 1
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.02
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 1
	End
	
	ParticleManager.Particles[ParticleManager.NextParticle].X = oX
	ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
	ParticleManager.Particles[ParticleManager.NextParticle].XS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].YS = 0
	ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
	
	ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.None
	ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
	ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
	'ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
	ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
	ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue(oC * 18)	
	ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Normal
	
	ParticleManager.Particles[ParticleManager.NextParticle].Active = True
	ParticleManager.Add()
End

Function GenerateRopeParticles(oX:Float,oY:Float)

	For Local i:Int = 0 To 6
		'Local tP:Particle = New Particle()
		
		Local tD:Float = Rnd(0,360)
		
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
		ParticleManager.Particles[ParticleManager.NextParticle].A = 1
		ParticleManager.Particles[ParticleManager.NextParticle].XS = Sin(tD) * Rnd(1,2)
		ParticleManager.Particles[ParticleManager.NextParticle].YS = Cos(tD) * Rnd(1,2)
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle]. AS= -0.05
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.None
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		
		If i = 0 or i = 3
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(255, 128, 0)
			ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
			ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.2
		ElseIf i = 1 or i = 4
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(255,255,0)
			ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STAR
			ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.2
		Else
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(128,128,128)
			ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
			ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.2
		End
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	Next

End

Function GenerateSkidParticles(oX:Float,oY:Float,oXS:Float)
	Local pW:Int = 16
	Local pC:Int = 1
	For Local i:Int = 0 to pC - 1
		'Local tP:Particle = New Particle()
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
		ParticleManager.Particles[ParticleManager.NextParticle].XS = oXS * 2
		ParticleManager.Particles[ParticleManager.NextParticle].YS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = 1 + Rnd(0.01,0.02)
		ParticleManager.Particles[ParticleManager.NextParticle].XSM = 0.999
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.5
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
		Local TCR:Float = Rnd(155,255)
		ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(TCR,TCR,TCR)
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	Next
End

Function GenerateJumpParticles(oX:Float,oY:Float)
	Local pW:Int = 16
	Local pC:Int = 10
	For Local i:Int = 0 to pC - 1
		'Local tP:Particle = New Particle()
		ParticleManager.Particles[ParticleManager.NextParticle].X = oX + (Rnd(0,1) * pW)
		ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
		ParticleManager.Particles[ParticleManager.NextParticle].XS = Rnd(-0.2,0.2)
		ParticleManager.Particles[ParticleManager.NextParticle].YS = 0.01
		ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
		ParticleManager.Particles[ParticleManager.NextParticle].A = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.01
		ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.None
		ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
		ParticleManager.Particles[ParticleManager.NextParticle].YSM = 1 + Rnd(0.01,0.02)
		ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
		ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
		ParticleManager.Particles[ParticleManager.NextParticle].dScale = 0.5
		ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
		'ParticleManager.Particles[ParticleManager.NextParticle].C = New Color()
		Local TCR:Float = Rnd(155,255)
		ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(TCR,TCR,TCR)
		
		ParticleManager.Particles[ParticleManager.NextParticle].Active = True
		ParticleManager.Add()
	Next
End

Function GenerateFalafelPsst:Void(oX:Float,oY:Float)
	GenerateRopeParticles(oX,oY)
End

Function GenerateFalafelExplosion:Void(oX:Float,oY:Float)
	For Local i:Int = 0 To 4
		For Local j:Int = 0 To (i*2)
			ParticleManager.Particles[ParticleManager.NextParticle].A = 1
			ParticleManager.Particles[ParticleManager.NextParticle].AS = -0.02
			ParticleManager.Particles[ParticleManager.NextParticle].dScale = 1
			
			ParticleManager.Particles[ParticleManager.NextParticle].X = oX - (i*2) + Rnd(0,(i*4))
			ParticleManager.Particles[ParticleManager.NextParticle].Y = oY
			ParticleManager.Particles[ParticleManager.NextParticle].XS = Rnd(-0.5,0.5)
			ParticleManager.Particles[ParticleManager.NextParticle].YS = 0 - (Rnd(0,i))
			ParticleManager.Particles[ParticleManager.NextParticle].AMT = ParticleAlphaModifier.Add
			
			ParticleManager.Particles[ParticleManager.NextParticle].YSM = 0.96
			ParticleManager.Particles[ParticleManager.NextParticle].XSM = 0.95
			
			ParticleManager.Particles[ParticleManager.NextParticle].XSMT = ParticleSpeedModifier.Multiply
			ParticleManager.Particles[ParticleManager.NextParticle].YSMT = ParticleSpeedModifier.Multiply
			ParticleManager.Particles[ParticleManager.NextParticle].DT = ParticleDieType.Alpha
			ParticleManager.Particles[ParticleManager.NextParticle].I = ParticleSprites.STANDARD
			'ParticleManager.Particles[ParticleManager.NextParticle].C.SetRGB(0,0,0)
			ParticleManager.Particles[ParticleManager.NextParticle].C.SetHSB(0,100,50)
			ParticleManager.Particles[ParticleManager.NextParticle].C.ShiftHue((4-i) * 18)	
			ParticleManager.Particles[ParticleManager.NextParticle].B = ParticleBlendType.Lighten
			
			ParticleManager.Particles[ParticleManager.NextParticle].Active = True
			ParticleManager.Add()
		Next
	Next
End
