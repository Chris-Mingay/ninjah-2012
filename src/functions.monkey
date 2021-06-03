Import ninjah

Function DrawButton:Void(tX:Int,tY:Int,tW:Int,tH:Int,tText:String,tSelected:Bool=False,tActive:Bool=True)

	Local XScale:Float = Float(tW) / Float(NinjahApp.gfxButtonBack.Width())
	Local YScale:Float = Float(tH) / Float(NinjahApp.gfxButtonBack.Height())
	
	

	If tSelected = True
		SetColor(32,32,32)
	Else
		SetColor(0,0,0)
	End

	
	If tActive = False
		SetAlpha(0.2)
	Else
		SetAlpha(0.6)
	End

	DrawImage(NinjahApp.gfxButtonBack,tX,tY,0,XScale,YScale)
	
	If tActive = False
		SetAlpha(0.2)
	Else
		SetAlpha(1)
	End

	If tSelected = True
		SetColor(255,255,0)
	Else
		SetColor(255,255,255)		
	End

	NinjahApp.fontLarge.DrawText(tText,tX + 10,tY + 10)

	DrawHollowRect(tX,tY,tW,tH)

End

Function DrawButton:Void(tX:Int,tY:Int,tW:Int,tH:Int,tSelected:Bool=False,tActive:Bool=True)

	Local XScale:Float = Float(tW) / Float(NinjahApp.gfxButtonBack.Width())
	Local YScale:Float = Float(tH) / Float(NinjahApp.gfxButtonBack.Height())
	
	

	If tSelected = True
		SetColor(32,32,32)
	Else
		SetColor(0,0,0)
	End

	
	If tActive = False
		SetAlpha(0.2)
	Else
		SetAlpha(0.6)
	End

	DrawImage(NinjahApp.gfxButtonBack,tX,tY,0,XScale,YScale)
	
	If tActive = False
		SetAlpha(0.2)
	Else
		SetAlpha(1)
	End

	If tSelected = True
		SetColor(255,255,0)
	Else
		SetColor(255,255,255)
	End

	DrawHollowRect(tX,tY,tW,tH)

End