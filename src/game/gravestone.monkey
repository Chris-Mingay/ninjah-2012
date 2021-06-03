Import ninjah

Class GraveStone
	
	Global Stones:GraveStone[]
	Const COUNT:Int = 100
	Global NextGraveStone:Int
	
	Global gfxStone:Image
	Global gfxCount:Image
	
	Field Active:Bool = False
	Field X:Int
	Field Y:Int
	Field D:Int
	Field CountDisplay:Int = -1

	Function Init:Void()
		Stones = New GraveStone[COUNT]
		NextGraveStone = 0
		For Local i:Int = 0 Until COUNT
			
			Stones[i] = New GraveStone()
		
		Next
		
		gfxStone = LoadImage("graphics/gravestone.png", 16, 16, 4)
		gfxCount = LoadImage("graphics/count.png", 16, 16, 20)
		
	End
	
	Function Add:Void(tX:Int, tY:Int, tD:Int)
		
		Stones[NextGraveStone].X = tX
		Stones[NextGraveStone].Y = tY
		Stones[NextGraveStone].D = tD
		Stones[NextGraveStone].Active = True
		Stones[NextGraveStone].CountDisplay = -1
		
		'Print NextGraveStone
		
		If (NextGraveStone + 1) Mod 5 = 0
			Local tFrame:Int = (NextGraveStone + 1) / 5
			If tFrame > 0 And tFrame < 21
				Stones[NextGraveStone].CountDisplay = (tFrame - 1)
				'Print tFrame
				
			EndIf
		EndIf
		
	
		NextGraveStone += 1
		If NextGraveStone = COUNT
			NextGraveStone = 0
		EndIf
	
	End
	
	Function DrawAll:Void()
	
		SetAlpha(1.0)
		SetColor(255, 255, 255)
		
		For Local i:Int = 0 Until COUNT
			If Stones[i].Active = True
				
				DrawImage(gfxStone, Stones[i].X, Stones[i].Y, Stones[i].D)
				If Stones[i].CountDisplay > - 1
					DrawImage(gfxCount, Stones[i].X, Stones[i].Y, Stones[i].CountDisplay)
				EndIf
			
			Else
			
				Exit
			
			EndIf
		Next
		
		
	End
	
	Function ClearAll:Void()
		For Local i:Int = 0 Until COUNT
			Stones[i].Active = False
		Next
		
		NextGraveStone = 0
	End
	
End