Import ninjah

Class EditorLevel
	
	Field Move:Bool
	Field Rope:Bool
	Field Gun:Bool
	
	Field Width:Int
	Field Height:Int
	
	
	Field Blocks:EditorBlock[][]
	
	Method New()

		Blocks = AllocateArray(GameEditor.Height,GameEditor.Width)
		For local i:Int = 0 To GameEditor.Height - 1
			For local j:Int = 0 To GameEditor.Width - 1

				Blocks[i][j] = New EditorBlock(j * LevelBlock.W,i * LevelBlock.H)
			Next
		Next
		
	End
	
	Method Draw:Void()
		For local i:Int = 0 To GameEditor.Height - 1
			For local j:Int = 0 To GameEditor.Width - 1
				If Blocks[i][j].T <> EditorBlock.SPACE
					Blocks[i][j].Draw()
				End
			Next
		Next
	End
	
	Method DrawPreview:Void(OriginX:Int,OriginY:Int)
		For local i:Int = 0 To GameEditor.Height - 1
			For local j:Int = 0 To GameEditor.Width - 1
				If Blocks[i][j].T <> EditorBlock.SPACE
					Blocks[i][j].DrawPreview(OriginX,OriginY)
				End
			Next
		Next
	End
	
	Method UpdateBlock(tX:Int,tY:Int,tT:Int,tC:Int)
		If Blocks[tY][tX].T <> tT Or Blocks[tY][tX].ColourInt <> tC
			Blocks[tY][tX].Change(tT,tC)
			CalculateNeighbourBlockFrames(tY,tX)	
		End
	End
	
	Method CalculateBlockFrame(tY:Int,tX:Int)
		Local tT:Int = Blocks[tY][tX].T
		Local tC:Int = 0
		Local checkColour:Bool
		If tT = EditorBlock.NEUTRAL
			tC = 0
			checkColour = False
		Else
			tC = Blocks[tY][tX].ColourInt	
			checkColour = True
		End
		
		
		Local Above:Int = 0
		Local Below:Int = 0
		Local Left:Int = 0
		Local Right:Int = 0
		
		If tY > 0
			If (Blocks[tY-1][tX].ColourInt = tC Or checkColour = False) And Blocks[tY-1][tX].T = tT
				Above = 4
			Else
				Above = 0
			End
		Else
			Above = 4
		End
		
		If tY < (GameEditor.Height - 1)
			If (Blocks[tY+1][tX].ColourInt = tC Or checkColour = False) And Blocks[tY+1][tX].T = tT
				Below = 8
			Else
				Below = 0
			End
		Else
			Below = 8
		End
		
		If tX > 0
			If (Blocks[tY][tX-1].ColourInt = tC Or checkColour = False) And Blocks[tY][tX-1].T = tT
				Left = 1
			Else
				Left = 0
			End
		Else
			Left = 1
		End
		
		If tX < (GameEditor.Width - 1)
			If (Blocks[tY][tX+1].ColourInt = tC Or checkColour = False) And Blocks[tY][tX+1].T = tT
				Right = 2
			Else
				Right = 0
			End
		Else
			Right = 2
		End
		
		Local tF:Int = Above + Below + Left + Right
		Blocks[tY][tX].F = tF
	End
	
	Method CalculateNeighbourBlockFrames(tY:Int,tX:Int)
		For Local ttY:Int = (tY - 1) To (tY + 1)
			If ttY >= 0 And ttY <= (GameEditor.Height - 1)
				For Local ttX:Int = (tX - 1) To (tX + 1)
					If ttX >= 0 And ttX <= (GameEditor.Width - 1)	
						CalculateBlockFrame(ttY,ttX)
					End		
				Next
			End
		Next
	End
	
	Method LevelToString:String()
	
		Local sMove:String
		Local sRope:String
		Local sGun:String
		
		If Move = True
			sMove = "1"
		Else
			sMove = "0"
		End
		If Rope = True
			sRope = "1"
		Else
			sRope = "0"
		End
		
		If Gun = True
			sGun = "1"
		Else
			sGun = "0"
		End
		
	
		Local s:String = ""
		s += "name,"
		s += "00:00:00,"
		s += sMove+","
		s += sRope+","
		s += sGun+","
		s += GameEditor.Width+","
		s += GameEditor.Height+","
		s += " , , , , , , , ," ' SPARES
		
		For Local y:Int = 0 to (GameEditor.Height - 1)
			For Local x:Int = 0 to (GameEditor.Width - 1)
				s += Blocks[y][x].T+","
				s += Blocks[y][x].ColourInt+","
				s += Blocks[y][x].F+","
			Next
		Next
		
		s += "#"
		
		Return s
		
	End
	


End