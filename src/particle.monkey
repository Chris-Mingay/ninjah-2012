Import ninjah

Class Particle

	Field X#,Y#,XS#,YS#				' Xpos, Ypos, Xspeed, Yspeed
	Field XSM#, YSM#				' Xspeed modifier, Yspeed modifier
	Field XSMT:Int,YSMT:Int			' Xspeed modifier type, Yspeed modifier type || Add|Multiply
	Field R#, RS#, RSM#, RSMT:Int	' Rotation, Rotation Speed, Rotation Speed Modifier, Rotation Speed Modifier Type
	Field A#,AS#,AMT:Int			' Alpha, Alpha Speed, Alpha modifier type
	Field L:Int						' Life
	Field C:Color					' ColorObject
	Field B:Int = 1						' Blend type
	Field I:Int = ParticleSprites.STANDARD		' Particle Image
	Field dScale:Float = 1
	Field DT:Int = 0				' Die Type
	Field Active:Bool = False		' Whether the particle is active or not
	
	Method New()
		C = New Color()
	End
	
	Method Create:Void()
		
	End
	
	Method Update:Void()
	
		' -- MOVEMENT -- '
		If XSMT = ParticleSpeedModifier.Add
			XS += XSM
		Else If XSMT = ParticleSpeedModifier.Multiply
			XS *= XSM
		End
		
		If YSMT = ParticleSpeedModifier.Add
			YS += YSM
		Else If YSMT = ParticleSpeedModifier.Multiply
			YS *= YSM
		End
		
		X += XS
		Y += YS
		
		' -- ROTATION -- '
		If RSMT = ParticleSpeedModifier.Add
			RS += RSM
		Else If RSMT = ParticleSpeedModifier.Multiply
			RS *= RSM
		End
		
		R += RS
		
		If R > 360
			R -= 360
		End
		
		If R < 0
			R += 360
		End
		
		' -- ALPHA -- '
		If AMT = ParticleAlphaModifier.Add
			A += AS
		Else If AMT = ParticleAlphaModifier.Multiply
			A += AS
		End
		
		A = Clamp(A,0.0,1.0)
		
		' -- LIFE -- '
		If DT = ParticleDieType.Life
			L -= 1
			
			' -- DEATH -- ' (must be last thing performed on particle)
			If L = 0 Or A = 0
				Active = False
			End
		ElseIf DT = ParticleDieType.Alpha
			If A = 0
				Active = False
			End
		End
		
	End
	
	Method Draw:Void()
		SetColor(C.r,C.g,C.b)
		SetAlpha(A)
		SetBlend(B)
		Select I
			Case ParticleSprites.STAR
				DrawImage(ParticleSprites.Star,X,Y,R,dScale,dScale,0)	
			Case ParticleSprites.STANDARD
				DrawImage(ParticleSprites.Standard,X,Y,R,dScale,dScale,0)	
		End
		
		'DrawImage(ParticleSprites.Draw(I),X,Y,0)
	End

End

Class ParticleSpeedModifier
	Const Add:Int = 0
	Const Multiply:Int = 1
	Const None:Int = 3
End

Class ParticleAlphaModifier
	Const Add:Int = 0
	Const Multiply:Int = 1
	Const None:Int = 3
End

Class ParticleBlendType
	Const Normal:Int = 0
	Const Lighten:Int = 1
End

Class ParticleDieType
	Const Life:Int = 0
	Const Alpha:Int = 1
End
