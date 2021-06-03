Import ninjah

Class EditorBlock

	Const SPACE:Int = 0
	Const NEUTRAL:Int = 1
	Const COIN:Int = 2
	Const NO_ROPE_ZONE:Int = 3
	Const START:Int = 4
	Const LEVELEXIT:Int = 5
	Const SOLID_MIN:Int = 10
	Const SOLID_MAX:Int = 29
	Const CHANGE_MIN:Int = 30
	Const CHANGE_MAX:Int = 49
	Const ZONE_MIN:Int = 50
	Const ZONE_MAX:Int = 69
	
	Field X:Int
	Field Y:Int
	Field T:Int
	Field F:Int
	Field ColourInt:Int
	Field Colour:Color
	
	
	Const W:Int = 16
	Const H:Int = 16
	
	Method New(tX:Int,tY:Int)
		Colour = New Color()
		Colour.SetHSB(0,100,50)
		X = tX
		Y = tY
		T = SPACE
	End
	
	Method Change(tT:Int,tC:Int)
	
		T = tT
		F = 0
		If tT = EditorBlock.NEUTRAL
			tC = 0
			Colour.SetRGB(255,255,255)
		Else
			ColourInt = tC
			Colour.SetHSB(0,100,50)
			Colour.ShiftHue(tC * 18)
		End
		
		
	End
	
	Method Change(tT:Int,tC:Int,tF:Int)
	
		T = tT
		F = tF
		If tT = EditorBlock.NEUTRAL
			tC = 0
			Colour.SetRGB(255,255,255)
		Else
			ColourInt = tC
			Colour.SetHSB(0,100,50)
			Colour.ShiftHue(tC * 18)
		End
	End
	
	Method Draw:Void()
		Select T
			Case GameEditor.SPACE
				' -- DRAW NUFFINK
			Case GameEditor.NEUTRAL
				SetColor(255,255,255)
				DrawImage(LevelBlock.TileSet,X,Y,F)
			Case GameEditor.COIN
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,X,Y,2)
			Case GameEditor.START
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,X,Y,0)
			Case GameEditor.LEVELEXIT
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,X,Y,1)
			Case GameEditor.SOLID
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,X,Y,F)
			Case GameEditor.CHANGE
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,X,Y,16 + F)
			Case GameEditor.ZONE
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,X,Y,32 + F)
			Case GameEditor.NOROPEZONE
				SetColor(0,0,0)
				DrawImage(LevelBlock.TileSet,X,Y,32 + F)
		End
	End
	
	Method DrawPreview:Void(OriginX:Int,OriginY:Int)
		Select T
			Case GameEditor.SPACE
				' -- DRAW NUFFINK
			Case GameEditor.NEUTRAL
				SetColor(255,255,255)
				DrawImage(LevelBlock.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,F)
			Case GameEditor.COIN
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,2)
			Case GameEditor.START
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,0)
			Case GameEditor.LEVELEXIT
				SetColor(255,255,255)
				DrawImage(EditorGui.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,1)
			Case GameEditor.SOLID
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,F)
			Case GameEditor.CHANGE
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,16 + F)
			Case GameEditor.ZONE
				SetColor(Colour.r,Colour.g,Colour.b)
				DrawImage(LevelBlock.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,32 + F)
			Case GameEditor.NOROPEZONE
				SetColor(0,0,0)
				DrawImage(LevelBlock.TileSet,OriginX + (X / 4),OriginY + (Y / 4),0,0.25,0.25,32 + F)
		End
	End

End
