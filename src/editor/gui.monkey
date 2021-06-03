Import ninjah

Class EditorGui

	Field Visible:Bool
	Field X:Int
	Field Y:Int
	Field W:Int
	Field H:Int
	
	Global TileSet:Image
	
	Global Colours:Color[]
	
	Method New()
		Visible = True
		W = VDeviceWidth()
		H = 20
		X = 0
		Y = VDeviceHeight() - H
		Colours = New Color[20]
		For Local i:Int = 0 To 19
			Colours[i] = New Color()
			Colours[i].SetHSB(0,100,50)
			Colours[i].ShiftHue(i*18)
		Next
		TileSet = LoadImage("graphics/editor_tiles.png",16,16,6,Image.DefaultFlags)
		
	End
	
	Method Update:Void()
		
	End
	
	Method Draw:Void()
		SetAlpha(1)
		SetColor(80,80,80)
		DrawRect(X,Y,W,H)
		SetColor(120,120,120)
		DrawLine(X,Y,X+W,Y)
		
		' Draw the colour blocks
		Local xp:Int = 0
		Local yp:Int = 0
		For Local i:Int = 0 To 19
			xp = 2 + (i * (LevelBlock.W + 2))
			yp = Y + 2
			SetColor(Colours[i].r,Colours[i].g,Colours[i].b)
			DrawRect(xp,yp,LevelBlock.W,LevelBlock.H)
			If i = GameEditor.ActiveColour
				SetColor(255,255,255)
				DrawHollowRect(xp,yp,LevelBlock.W,LevelBlock.H)
			Else
				SetColor(0,0,0)
				DrawHollowRect(xp,yp,LevelBlock.W,LevelBlock.H)
			End
		Next
		
		SetColor(255,255,255)
		'Local xp:Int = 400
		'Local yp:Int = Y+2
		
		DrawRect(380+(((GameEditor.ActiveType - 1) * 18) - 1),yp - 1,18,18)
		
		xp = 2 + (21 * (LevelBlock.W + 2))
		DrawImage(LevelBlock.TileSet,xp + (0 * 18),Y+2,0)
		SetColor(Colours[GameEditor.ActiveColour].r,Colours[GameEditor.ActiveColour].g,Colours[GameEditor.ActiveColour].b)
		DrawImage(LevelBlock.TileSet,xp + (1 * 18),Y+2,0)
		DrawImage(LevelBlock.TileSet,xp + (2 * 18),Y+2,16)
		DrawImage(LevelBlock.TileSet,xp + (3 * 18),Y+2,32)
		SetColor(0,0,0)
		DrawImage(LevelBlock.TileSet,xp + (4 * 18),Y+2,32)
		
		'Local xp:Int = 500
		xp = xp + (5 * 18)
		SetColor(255,255,255)
		DrawImage(EditorGui.TileSet,xp + (0 * 18),Y+2,0) ' Start
		DrawImage(EditorGui.TileSet,xp + (1 * 18),Y+2,1) ' End
		DrawImage(EditorGui.TileSet,xp + (2 * 18),Y+2,2) ' Coin
		
		If GameEditor.Levels[GameEditor.ActiveLevel].Move = True
			SetColor(0,255,0)
		Else
			SetColor(255,0,0)
		End
		DrawImage(EditorGui.TileSet,xp + (4 * 18),Y+2,3) ' Move
		If GameEditor.Levels[GameEditor.ActiveLevel].Rope = True
			SetColor(0,255,0)
		Else
			SetColor(255,0,0)
		End
		DrawImage(EditorGui.TileSet,xp + (5 * 18),Y+2,4) ' Rope
		If GameEditor.Levels[GameEditor.ActiveLevel].Gun = True
			SetColor(0,255,0)
		Else
			SetColor(255,0,0)
		End
		DrawImage(EditorGui.TileSet,xp + (6 * 18),Y+2,5) ' Gun
	End

End
