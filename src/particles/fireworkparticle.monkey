Import ninjah


Class FireWorkParticle Extends Particle

	Global FireworkParticleCount:Int = 500
	Global NextFireworkParticle:Int = 0
	Global FireworkParticles:FireWorkParticle[]
	
	
	Field OldX1:Float
	Field OldY1:Float
	Field OldX2:Float
	Field OldY2:Float
	Field OldX3:Float
	Field OldY3:Float
	Field OldX4:Float
	Field OldY4:Float
	
	Field TrailCounter:Int = 0
	
	Field colourInt:Int
	
	'Field Active:Bool = False
	
	Function Init:Void()
		FireworkParticles = New FireWorkParticle[FireworkParticleCount]
		For Local i:Int = 0 To FireworkParticleCount - 1
			FireworkParticles[i] = New FireWorkParticle()
		Next
	End
	
	Function Add:Void()
		NextFireworkParticle += 1
		If NextFireworkParticle = FireworkParticleCount
			NextFireworkParticle = 0
		End
	End
	
	Function UpdateAll:Void()
		For Local i:Int = 0 To FireworkParticleCount - 1
			If FireworkParticles[i].Active = True
				FireworkParticles[i].Update()
			End
		Next
	End
	
	Function DrawAll:Void()
		For Local i:Int = 0 To FireworkParticleCount - 1
			If FireworkParticles[i].Active = True
				FireworkParticles[i].Draw()
			End
		Next
	End
	
	
	Method Update:Void()
		OldX4 = OldX3
		OldY4 = OldY3
		OldX3 = OldX2
		OldY3 = OldY2
		OldX2 = OldX1
		OldY2 = OldY1
		OldX1 = X
		OldY1 = Y
		Local tmp:Float = Rnd(0,1)
		Local shift:Float = 1
		If tmp > 0.5
			shift = 0
		End
		C.ShiftHue(shift)
		
		If TrailCounter < 15
			TrailCounter += 1
		Else
			GenerateTrailParticles(X,Y,colourInt)
			TrailCounter = 0
		End
		
		Super.Update()
		
		If Active = False
			
		End
	End
	

	Method Draw:Void()
		SetColor(C.r,C.g,C.b)
		SetBlend(1)
		SetAlpha(A)
		DrawImage(ParticleSprites.Star,X, Y)
	End	

End