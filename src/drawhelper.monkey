Import ninjah

Class DrawHelper

	Global RectTL:Image
	Global RectTR:Image
	Global RectBL:Image
	Global RectBR:Image
	
	Function Init:Void()
		RectTL = LoadImage("rect_tl.png",1,Image.DefaultFlags)
		RectTR = LoadImage("rect_tr.png",1,Image.DefaultFlags)
		RectBL = LoadImage("rect_bl.png",1,Image.DefaultFlags)
		RectBR = LoadImage("rect_br.png",1,Image.DefaultFlags)
	End
	
	Function RoundedRect( x:Float, y:Float, w:Float, h:Float )

		DrawLine(x+8,y,x+w-8,y)
		DrawLine(x+8,y+h,x+w-8,y+h)
		DrawLine(x,y+8,x,y+h-8)
		DrawLine(x+w,y+8,x+w,y+h-8)
		
		DrawImage(RectTL,x,y)
		DrawImage(RectTR,x+w-8,y)
		DrawImage(RectBL,x,y+h-8)
		DrawImage(RectBR,x+w-8,y+h-8)
		
	End
	
End