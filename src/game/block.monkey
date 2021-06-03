Import ninjah

Class LevelBlock

	Global TileSet1:Image
	Global TileSet2:Image
	Global TileSet3:Image
	Global TileSet4:Image
	Global TileSet5:Image
	Global TileSet6:Image
	Global Corners1:Image
	Global Corners2:Image
	Global Corners3:Image
	Global Corners4:Image
	Global Corners5:Image
	Global Corners6:Image
	
	Global TileSetNumber:Int = 1
	Function ChangeTileSet:Void(oC:Int)
		
		TileSetNumber = oC
		
		
		Select oC
			Case 1 ' NORMAL
				TileSet = TileSet1
				Corners = Corners1
			Case 0 ' THIN
				TileSet = TileSet2
				Corners = Corners2
			Case 3 ' SOLID
				TileSet = TileSet3
				Corners = Corners3
			Case 2 ' NEGATIVE
				TileSet = TileSet4
				Corners = Corners4
			Case 5 ' FALAFE
				TileSet = TileSet5
				Corners = Corners5
			Case 4 ' VVVVVV
				TileSet = TileSet6
				Corners = Corners6
		End
		
	End
	

	Global TileSet:Image
	Global Corners:Image
	Global LastColour:Int = -1
	Global LastT:Int = -1
	
	Field X:Float
	Field Y:Float
	Field X2:Float
	Field Y2:Float
	Field T:int
	Field F:Int
	Field CornerF:Int

	Field IsNeutral:Bool = False
	Field IsNoRopeZone:Bool = False
	Field IsZone:Bool = False
	Field IsChange:Bool = False
	Field IsColour:Bool = False
	Field IsSpace:Bool = False
	
	Const ShadowOffsetX:Int = 2
	Const ShadowOffsetY:Int = 2
	
	Field ColourInt:Int
	Field Colour:Color
	
	Field Active:Bool = False
	
	Const W:Int = 16
	Const H:Int = 16
	
	Const SPACE:Int = 0
	Const NEUTRAL:Int = 1
	Const SOLID:Int = 2
	Const CHANGE:Int = 3
	Const ZONE:Int = 4
	Const NOROPEZONE:Int = 5
	Const START:Int = 6
	Const LEVELEXIT:Int = 7
	Const COIN:Int = 8
	
	Method Reset:Void()
		Active = False
		X = 0
		Y = 0
		X2 = 16
		Y2 = 16
		T = SPACE
		F = 0
		CornerF = 0
		IsChange = False
		IsColour = False
		IsNeutral = False
		IsNoRopeZone = False
		IsSpace = True
		IsZone = False
		' Colour.SetRGB(0,0,0)
		ColourInt = 0
		
		
	End
	
	Method Create(tX#,tY#,tT:Int,tC:Int,tF:Int,tCF:Int)
		X = tX
		Y = tY
		X2 = tX+W
		Y2 = tY+H
		T = tT
		F = tF
		CornerF = tCF
		ColourInt = tC
		Active = True
		
		Colour = New Color()
		Colour.SetHSB(0,100,50)
		Colour.ShiftHue(ColourInt * 18)
		
		Select T
			Case NEUTRAL
				Colour.SetRGB(255,255,255)
				IsNeutral = True
			Case SOLID
				IsColour = True
			Case CHANGE
				IsChange = True
			Case ZONE
				IsZone = True
			Case NOROPEZONE
				Colour.SetRGB(0,0,0)
				IsNoRopeZone = True
		End
	End
	
	Method DrawShadow:Void()
		DrawImage(TileSet,X+ShadowOffsetX,Y+ShadowOffsetY,F)
	End
	
	Method Draw:Void()
	
		'If IsNeutral = True
		'	SetColor(255,255,255)
		'	LastColour = -1
		'ElseIf IsNoRopeZone = True
		'	SetColor(0,0,0)
		'	LastColour = -1
		'ElseIf ColourInt <> LastColour
			SetColor(Colour.r,Colour.g,Colour.b)
		'	LastColour = ColourInt
		'End
		DrawImage(TileSet,X,Y,F)
		If CornerF <> 0
			DrawImage(Corners,X,Y,CornerF)
		End
	End
	
End