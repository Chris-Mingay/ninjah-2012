Import ninjah

Class ParticleManager

	Global Tileset:Image

	' Global ParticleCount:Int = 30
	Global ParticleCount:Int = 3000
	Global NextParticle:Int = 0
	Global Particles:Particle[]
	'Global Particles:= New List<Particle>
	
	Function Init:Void()
		Particles = New Particle[ParticleCount]
		For Local i:Int = 0 To ParticleCount - 1
			Particles[i] = New Particle()
		Next
		' Tileset = LoadImage("tileset.png")
	End
	
	Function Add:Void()
		NextParticle += 1
		If NextParticle = ParticleCount
			NextParticle = 0
		End
	End
	
	Function UpdateAll:Void()
		For Local i:Int = 0 To ParticleCount - 1
			If Particles[i].Active = True
				Particles[i].Update()
			End
		Next
	End
	
	Function DrawAll:Void()
		For Local i:Int = 0 To ParticleCount - 1
			If Particles[i].Active = True
				Particles[i].Draw()
			End
		Next
	End
	
	Function Clear:Void()
		For Local i:Int = 0 To ParticleCount - 1
			Particles[i].Active = False
		Next
	End
		
End
