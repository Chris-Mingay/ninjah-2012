Import ninjah
'Import src.leveldata

' -- MuddyShoes
Function AllocateArray:EditorBlock[][]( i:Int, j:Int)
    Local arr:EditorBlock[][] = New EditorBlock[i][]
    For Local ind = 0 Until i
        arr[ind] = New EditorBlock[j]
    Next
    Return arr		
End

Class GameEditor

	Field Cursor:EditorCursor
	Field Gui:EditorGui
	
	Global Width:Int = 80
	Global Height:Int = 45
	Global LevelCount:Int = 50
	Global Levels:EditorLevel[]
	
	Const SPACE:Int = 0
	Const NEUTRAL:Int = 1
	Const SOLID:Int = 2
	Const CHANGE:Int = 3
	Const ZONE:Int = 4
	Const NOROPEZONE:Int = 5
	Const START:Int = 6
	Const LEVELEXIT:Int = 7
	Const COIN:Int = 8
	
	' -- BETWEEN 0 and 19
	Global ActiveColour:Int
	Global ActiveType:int
	Global ActiveLevel:Int = 0
	
	Const RECT_FIRST:Int = 0
	Const RECT_SECOND:Int = 1
	Field RectMode:Int = RECT_FIRST
	
	Const AREA_FIRST:Int = 0
	Const AREA_SECOND:Int = 1
	Const AREA_MOVING:Int = 2
	Field AreaMode:introscreen = AREA_FIRST
	Field AreaX1:Int = 0
	Field AreaY1:Int = 0
	Field AreaX2:Int = 0
	Field AreaY2:Int = 0
	
	Field RectX1:Int = 0
	Field RectY1:Int = 0
	Field RectX2:Int = 0
	Field RectY2:Int = 0
	

	Method New()

		Levels = New EditorLevel[LevelCount]
		For Local l:Int = 0 to LevelCount - 1
				Levels[l] = New EditorLevel()
		Next
		
		' WHEN EDITING THE LEVELS
		' LoadAllLevels(LoadState())
		
		' WHEN PLAYING ON XBOX
		' LoadAllLevels(LoadString("levels/Levels.txt"))
		LoadAllLevelsFromFiles()
	
		Cursor = New EditorCursor()
		Gui = New EditorGui()
		ActiveType = NEUTRAL
		ActiveColour = 0
		ActiveLevel = 0
	End

	Method Update:Void()
		Cursor.Update()
		'Gui.Update()
		
		If KeyHit(KEY_P)
			Game.LoadLevelFromEditor(ActiveLevel)
			MyScreenManager.InitiateChangeScreen("game")
		End
		
		If JoyHit(JOY_B)
			Game.LoadLevelFromEditor(ActiveLevel)
			MyScreenManager.InitiateChangeScreen("main")
		End
		
		If KeyHit(KEY_ENTER)
			'SaveAllLevels()
			SaveLevel(ActiveLevel)
			
		End
		
		If KeyHit(KEY_Q)
			ActiveLevel -= 1
			If ActiveLevel = -1
				ActiveLevel = 49
			End
		End
		
		If KeyHit(KEY_W)
			ActiveLevel += 1
			If ActiveLevel = 50
				ActiveLevel = 0
			End
		End
		
		If KeyHit(KEY_A)
			ActiveType = NEUTRAL
		End
		
		If KeyHit(KEY_S)
			ActiveType = SOLID
		End
		
		If KeyHit(KEY_D)
			ActiveType = CHANGE
		End
		
		If KeyHit(KEY_F)
			ActiveType = ZONE
		End
		
		If KeyHit(KEY_G)
			ActiveType = NOROPEZONE
		End
		
		If KeyHit(KEY_H)
			ActiveType = START
		End
		
		If KeyHit(KEY_J)
			ActiveType = LEVELEXIT
		End
		
		If KeyHit(KEY_K)
			ActiveType = COIN
		End
		
		If KeyHit(KEY_Z)
			ActiveColour -= 1
			If ActiveColour = -1
				ActiveColour = 19
			End
		End
		
		If KeyHit(KEY_X)
			ActiveColour += 1
			If ActiveColour = 20
				ActiveColour = 0
			End
		End
		
		If KeyHit(KEY_UP)
			MoveLevel(UP)
		End
		
		If KeyHit(KEY_DOWN)
			MoveLevel(DOWN)
		End
		
		If KeyHit(KEY_LEFT)
			MoveLevel(LEFT)
		End
		
		If KeyHit(KEY_RIGHT)
			MoveLevel(RIGHT)
		End
		
		If KeyHit(KEY_C)
			ClearLevel()
		End	
		
		If PointWithinRect(VMouseX(), VMouseY(), 0, 0, VDeviceWidth(), VDeviceHeight())
			
			If MouseDown()
				If Not PointWithinRect(VMouseX(), VMouseY(), Gui.X, Gui.Y, Gui.X + Gui.W, Gui.Y + Gui.H)
					Levels[ActiveLevel].UpdateBlock(Cursor.ModX / LevelBlock.W,Cursor.ModY / LevelBlock.H,ActiveType,ActiveColour)
				End
			End
			
			If MouseDown(MOUSE_RIGHT)
				If Not PointWithinRect(VMouseX(), VMouseY(), Gui.X, Gui.Y, Gui.X + Gui.W, Gui.Y + Gui.H)
					Levels[ActiveLevel].UpdateBlock(Cursor.ModX / LevelBlock.W,Cursor.ModY / LevelBlock.H,SPACE,0)
				End
			End
			
			If MouseHit()
			
				If PointWithinRect(VMouseX(), VMouseY(), Gui.X, Gui.Y, Gui.X + Gui.W, Gui.Y + Gui.H)
					If VMouseX() < 360
						ActiveColour = (VMouseX() - (VMouseX() Mod 18)) / 18
					End
					
					If VMouseX() > 380 And VMouseX() < 524
						ActiveType = ( ( (VMouseX() -380) - ( (VMouseX() -380) Mod 18)) / 18) + 1
					End
					
					If VMouseX() > 542 And VMouseX() < 596
						Local toggle:Int = ( ( (VMouseX() -542) - ( (VMouseX() -542) Mod 18)) / 18)
						Select toggle
							Case 0
								Levels[ActiveLevel].Move = Not Levels[ActiveLevel].Move
							Case 1
								Levels[ActiveLevel].Rope = Not Levels[ActiveLevel].Rope
							Case 2	
								Levels[ActiveLevel].Gun = Not Levels[ActiveLevel].Gun
						End
					End
					
				Else
				
					If KeyDown(KEY_CONTROL)
						If RectMode = RECT_FIRST
							RectX1 = Cursor.ModX / LevelBlock.W
							RectY1 = Cursor.ModY / LevelBlock.H
							RectMode = RECT_SECOND
						Else
							RectX2 = Cursor.ModX / LevelBlock.W
							RectY2 = Cursor.ModY / LevelBlock.H
							
							For Local tY:Int = RectY1 to RectY2
								For Local tX:Int = RectX1 to RectX2
									Levels[ActiveLevel].UpdateBlock(tX,tY,ActiveType,ActiveColour)
								Next
							Next
							
							RectMode = RECT_FIRST
							
						End
						
						
					End
					
				End
			End
			
			If RectMode = RECT_SECOND
				If Not KeyDown(KEY_CONTROL)
					RectMode = RECT_FIRST
				End
			End
			
			
		End
		
	End
	
	Method Draw:Void()
		DrawBackground()
		
		Levels[ActiveLevel].Draw()
		
		If RectMode = RECT_SECOND
			SetAlpha(0.5)
			SetColor(EditorGui.Colours[ActiveColour].r,EditorGui.Colours[ActiveColour].g,EditorGui.Colours[ActiveColour].b)
			For Local tY:Int = (RectY1 * 16) To Cursor.ModY Step 16
				For Local tX:Int = (RectX1 * 16) To Cursor.ModX Step 16
					Select ActiveType
						Case GameEditor.SPACE
							' -- DRAW NUFFINK
						Case GameEditor.NEUTRAL
							SetColor(255,255,255)
							DrawImage(LevelBlock.TileSet,tX,tY,0)
						Case GameEditor.COIN
							SetColor(255,255,255)
							DrawImage(EditorGui.TileSet,tX,tY,2)
						Case GameEditor.START
							SetColor(255,255,255)
							DrawImage(EditorGui.TileSet,tX,tY,0)
						Case GameEditor.LEVELEXIT
							SetColor(255,255,255)
							DrawImage(EditorGui.TileSet,tX,tY,1)
						Case GameEditor.SOLID
							DrawImage(LevelBlock.TileSet,tX,tY,0)
						Case GameEditor.CHANGE
							DrawImage(LevelBlock.TileSet,tX,tY,16)
						Case GameEditor.ZONE
							DrawImage(LevelBlock.TileSet,tX,tY,32)
						Case GameEditor.NOROPEZONE
							SetColor(0,0,0)
							DrawImage(LevelBlock.TileSet,tX,tY,32)
					End
				Next
			Next
		End
		
		
		
		If PointWithinRect(VMouseX(), VMouseY(), 0, 0, (Width * LevelBlock.W), (Height * LevelBlock.H))
			Cursor.Draw()	
		End
		Gui.Draw()
		
	End
		
	Method DrawBackground:Void()
		SetColor(40,40,40)
		SetAlpha(1)
		DrawRect(0, 0, VDeviceWidth(), VDeviceHeight())
		SetColor(80,80,80)
		For Local y:Int = 0 To (Height - 1)
			For Local x:Int = 0 To (Width - 1)
				SetColor(80,80,80)
				DrawHollowRect((x * LevelBlock.W) + 2,(y * LevelBlock.H) + 2,LevelBlock.W - 4,LevelBlock.H - 4)
				If x Mod 4 = 0
					SetColor(160,160,160)
					DrawLine((x * LevelBlock.W),0,(x * LevelBlock.W),VDeviceHeight())
				End
			Next
			If y Mod 4 = 0
				SetColor(120,120,120)
				DrawLine(0, (y * LevelBlock.H), VDeviceWidth(), (y * LevelBlock.H))
			End
		Next
	End
	
	Method LoadAllLevelsFromFiles:Void()
		For Local i:Int = 0 to 49
			LoadLevel(i, mojo.LoadString("level/level_" + String(i) + ".txt"))
		Next
	End
	
	Method LoadLevel:Void(levelNumber:Int,loadString:String)
		Local tmp:String[] = loadString.Split(",")
		Local i:Int = 15
		Local tmpName:String = tmp[0]
		Local tmpMytime:String = tmp[1]
		Local tmpMove:String = tmp[2]
		Local tmpRope:String = tmp[3]
		Local tmpGun:String = tmp[4]
		Local tmpWidth:String = tmp[5]
		Local tmpHeight:String = tmp[6]
		
		If tmpMove = "1"
			Levels[levelNumber].Move = True
		Else
			Levels[levelNumber].Move = False
		End
		
		If tmpRope = "1"
			Levels[levelNumber].Rope = True
		Else
			Levels[levelNumber].Rope = False
		End
		
		If tmpGun = "1"
			Levels[levelNumber].Gun = True
		Else
			Levels[levelNumber].Gun = False
		End
		
		Levels[levelNumber].Width = Int(tmpWidth)
		Levels[levelNumber].Height = Int(tmpHeight)
		
		For Local tY:Int = 0 to (Height - 1)
			For Local tX:Int = 0 to (Width - 1)	
				Local tT:Int = Int(tmp[i])
				i += 1
				Local tC:Int = Int(tmp[i])
				i += 1
				Local tF:Int = Int(tmp[i])
				i += 1
				Levels[levelNumber].Blocks[tY][tX].Change(tT,tC,tF)
			Next
		Next
		
	End

	Method SaveLevel:Void(tLev:Int)
		Local s:String = Levels[tLev].LevelToString()
		#If TARGET="glfw"
		SaveString(s, "level_" + tLev + ".txt")
		#EndIf
	End
	
	Method ClearLevel:Void()
		For Local tY:Int = 0 To Height - 1
			For Local tX:Int = 0 To Width - 1
				Levels[ActiveLevel].Blocks[tY][tX] = New EditorBlock(tX * EditorBlock.W,tY * EditorBlock.H)			
			Next
		Next
		
	End

	Const UP:Int = 0
	Const DOWN:Int = 1
	Const LEFT:Int = 2
	Const RIGHT:Int = 3
	Method MoveLevel:Void(dir:Int)
	
		
	
		Select dir
			Case UP
				For Local ty:Int = 0 To Height - 1
					For Local tx:Int = 0 to Width - 1
						If ty = (Height - 1	)
							Levels[ActiveLevel].UpdateBlock(tx,ty,SPACE,0)
						Else
							Levels[ActiveLevel].Blocks[ty][tx] = Levels[ActiveLevel].Blocks[ty + 1][tx]
							Levels[ActiveLevel].Blocks[ty][tx].X = tx * LevelBlock.W
							Levels[ActiveLevel].Blocks[ty][tx].Y = ty * LevelBlock.H
						End
					Next
				Next
			Case DOWN
				For Local ty:Int = Height - 1 To 0 Step -1
					For Local tx:Int = 0 to Width - 1
						If ty = 0
							Levels[ActiveLevel].Blocks[ty][tx].T = SPACE
							Levels[ActiveLevel].Blocks[ty][tx].ColourInt = 0
						Else
							Levels[ActiveLevel].Blocks[ty][tx] = Levels[ActiveLevel].Blocks[ty - 1][tx]
							Levels[ActiveLevel].Blocks[ty][tx].X = tx * LevelBlock.W
							Levels[ActiveLevel].Blocks[ty][tx].Y = ty * LevelBlock.H
						End
					Next
				Next
			Case LEFT
				For Local ty:Int = 0 To Height - 1
					For Local tx:Int = 0 To Width - 1
						If tx = (Width - 1	)
							Levels[ActiveLevel].Blocks[ty][tx].T = SPACE
							Levels[ActiveLevel].Blocks[ty][tx].ColourInt = 0
						Else
							Levels[ActiveLevel].Blocks[ty][tx] = Levels[ActiveLevel].Blocks[ty][tx + 1]
							Levels[ActiveLevel].Blocks[ty][tx].X = tx * LevelBlock.W
							Levels[ActiveLevel].Blocks[ty][tx].Y = ty * LevelBlock.H
						End
					Next
				Next
			Case RIGHT
				For Local ty:Int = 0 To Height - 1
					For Local tx:Int = Width - 1 To 0 Step -1
						If tx = 0
							Levels[ActiveLevel].Blocks[ty][tx].T = SPACE
							Levels[ActiveLevel].Blocks[ty][tx].ColourInt = 0
						Else
							Levels[ActiveLevel].Blocks[ty][tx] = Levels[ActiveLevel].Blocks[ty][tx - 1]
							Levels[ActiveLevel].Blocks[ty][tx].X = tx * LevelBlock.W
							Levels[ActiveLevel].Blocks[ty][tx].Y = ty * LevelBlock.H
						End
					Next
				Next
		End
		
	End

End
