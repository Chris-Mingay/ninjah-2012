Import ninjah

Class TextImages
	
	Global _list:IntMap<Image>
	Global _numbers:Image[]
	Global SemiColon:Image
	Global Hyphen:Image
	Global Space:Image
	Global _names:Image[]
	
	Const GAME_PLAY:Int = 0
	Const GAME_RESTART:Int = 1
	Const GAME_SELECT:Int = 2
	Const GAME_NEXT:Int = 3
	
	Const BUT_PLAY:Int = 4
	Const BUT_EXIT:Int = 5
	Const BUT_CREDITS:Int = 6
	Const BUT_OPTIONS:Int = 12
	
	Const TUTORIALS:Int = 7
	Const TITLE_SELECT:Int = 8
	Const TITLE_CREDITS:Int = 9
	
	Const BEST_TIMES:Int = 10
	Const CREDITS:Int = 11
	
	Const MUS_VOLUME:Int = 13
	Const SFX_VOLUME:Int = 14
	Const SHOW_GHOST:Int = 15
	
	Const RESET_DATA:Int = 16
	Const ARE_YOU_SURE:Int = 17
	
	Const TRAIL_MODE:Int = 18
	Const SPRITE_MODE:Int = 19
	Const TILESET:Int = 20
	
	Const NNNNNN:Int = 21
	Const FALAFEL:Int = 22
	Const NONE:Int = 23
	Const COLOUR:Int = 24
	Const RAINBOW:Int = 25
	Const NEGATIVE:Int = 26
	Const SOLID:Int = 27
	Const THIN:Int = 28
	Const NORMAL:Int = 29
	
	Const CHANGE:Int = 30
	
	
	
	
	Function Init:Void()
	
	
		_list = New IntMap<Image>
		_numbers = New Image[10]
		_names = New Image[52]
		
		
	
		_list.Set(0,LoadImage("text/game_play.png",1,Image.DefaultFlags))
		_list.Set(1,LoadImage("text/game_restart.png",1,Image.DefaultFlags))
		_list.Set(2,LoadImage("text/game_select.png",1,Image.DefaultFlags))
		_list.Set(3,LoadImage("text/game_next.png",1,Image.DefaultFlags))
		
		_list.Set(4,LoadImage("text/but_play.png",1,Image.DefaultFlags))
		_list.Set(5,LoadImage("text/but_exit.png",1,Image.DefaultFlags))
		_list.Set(6,LoadImage("text/but_credits.png",1,Image.DefaultFlags))
		_list.Set(12,LoadImage("text/but_options.png",1,Image.DefaultFlags))
		
		_list.Set(7,LoadImage("text/tutorials.png",1,Image.DefaultFlags))
		_list.Set(8,LoadImage("text/title_select.png",1,Image.DefaultFlags))
		_list.Set(9,LoadImage("text/title_credits.png",1,Image.DefaultFlags))
		
		_list.Set(10,LoadImage("text/best_times.png",1,Image.DefaultFlags))
		_list.Set(11,LoadImage("text/credits.png",1,Image.DefaultFlags))
		
		_list.Set(13,LoadImage("text/music_volume.png",1,Image.DefaultFlags))
		_list.Set(14,LoadImage("text/sound_volume.png",1,Image.DefaultFlags))
		_list.Set(15,LoadImage("text/show_ghost.png",1,Image.DefaultFlags))
		_list.Set(16,LoadImage("text/reset_data.png",1,Image.DefaultFlags))
		_list.Set(17,LoadImage("text/are_you_sure.png",1,Image.DefaultFlags))
		
		_list.Set(18,LoadImage("text/trail_mode.png",1,Image.DefaultFlags))
		_list.Set(19,LoadImage("text/sprite_mode.png",1,Image.DefaultFlags))
		_list.Set(20,LoadImage("text/tileset.png",1,Image.DefaultFlags))
		_list.Set(21,LoadImage("text/nnnnnn.png",1,Image.DefaultFlags))
		_list.Set(22,LoadImage("text/falafel.png",1,Image.DefaultFlags))
		_list.Set(23,LoadImage("text/none.png",1,Image.DefaultFlags))
		_list.Set(24,LoadImage("text/colour.png",1,Image.DefaultFlags))
		_list.Set(25,LoadImage("text/rainbow.png",1,Image.DefaultFlags))
		_list.Set(26,LoadImage("text/negative.png",1,Image.DefaultFlags))
		_list.Set(27,LoadImage("text/solid.png",1,Image.DefaultFlags))
		_list.Set(28,LoadImage("text/thin.png",1,Image.DefaultFlags))
		_list.Set(29,LoadImage("text/normal.png",1,Image.DefaultFlags))
		
		_list.Set(CHANGE,LoadImage("text/change.png",1,Image.DefaultFlags))
		
		SemiColon = LoadImage("text/semi_colon.png",1,Image.DefaultFlags)
		Hyphen = LoadImage("text/hyphen.png",1,Image.DefaultFlags)
		Space = LoadImage("text/space.png",1,Image.DefaultFlags)
		
		For Local i:Int = 0 To 9
			_numbers[i] = LoadImage("text/"+String(i)+".png",1,Image.DefaultFlags)
		Next
		
		For Local i:Int = 0 To 49
			'If i < 10
				_names[i] = LoadImage("text/level_"+String(i)+".png",1,Image.DefaultFlags)	
			'EndIf
		Next
		_names[50] = LoadImage("text/level_changeme.png",1,Image.DefaultFlags)
		_names[51] = LoadImage("text/locked.png",1,Image.DefaultFlags)
		
	End
	
	Function Draw:Void(tImage:Int,X:Float,Y:Float)
		DrawImage(_list.Get(tImage),X,Y)
	End
	
	Function DrawName:Void(tNumber:Int,tX:Int,tY:Int)
		DrawImage(_names[tNumber],tX,tY)
	End
	
	Function DrawNumber:Void(tNumber:Int,tX:Int,tY:Int)
	
		Local pX:Int = tX
		Local l:Int = 0
	
		If tNumber >= 0 And tNumber < 10
			l = 1
		ElseIf tNumber < 100	
			l = 2
		ElseIf tNumber < 1000
			l = 3
		ElseIf tNumber < 10000
			l = 4
		ElseIf tNumber < 100000
			l = 5
		End
		
		If l > 0
			For Local i:Int = l To 1 Step -1
				DrawImage(_numbers[GetDigit(tNumber,i)],pX,tY)
				pX += 15
			Next
		End
		
	End
	
'	Function DrawTime:Void(tTime:Int,tX:Int,tY:Int)
'		
'		Local pX:Int = tX
'		Local l:Int = 0
'		
'		If tTime = 0
'			DrawImage(_list.Get("dash"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("dash"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("semi_colon"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("dash"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("dash"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("semi_colon"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("dash"),pX,tY)
'			pX += 15
'			DrawImage(_list.Get("dash"),pX,tY)
'		Else
'			
'		End
'	
'	End
	
	Function MillisecondsToTime:Void(milliseconds:Int,tX:Int,tY:Int)
	
		Local pX:Int = tX
		Local l:Int = 0
		
		If milliseconds = 0
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(SemiColon,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(SemiColon,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
			DrawImage(Hyphen,pX,tY)
			pX += 15
		Else
		
			Local mils:Int
			Local secs:Int
			Local mins:Int
			
			mils = milliseconds Mod 1000
			secs = ((milliseconds - mils) / 1000) Mod 60
			mins = (milliseconds - (mils + (secs * 1000) Mod 60000 ) ) / 60000
			
			If mins < 10
				DrawImage(_numbers[0],pX,tY)
				pX += 15
				DrawImage(_numbers[mins],pX,tY)
				pX += 15
			else
				For Local i:Int = 2 To 1 Step -1
					DrawImage(_numbers[GetDigit(mins,i)],pX,tY)
					pX += 15
				Next
			End
			
			DrawImage(SemiColon,pX,tY)
			pX += 15
			
			If secs < 10
				DrawImage(_numbers[0],pX,tY)
				pX += 15
				DrawImage(_numbers[secs],pX,tY)
				pX += 15
			else
				For Local i:Int = 2 To 1 Step -1
					DrawImage(_numbers[GetDigit(secs,i)],pX,tY)
					pX += 15
				Next
			End
			
			DrawImage(SemiColon,pX,tY)
			pX += 15
			
			If mils < 10
				DrawImage(_numbers[0],pX,tY)
				pX += 15
				DrawImage(_numbers[0],pX,tY)
				pX += 15
				DrawImage(_numbers[mils],pX,tY)
				pX += 15
			Else If mils < 100
				DrawImage(_numbers[0],pX,tY)
				pX += 15
				For Local i:Int = 2 To 1 Step -1
					DrawImage(_numbers[GetDigit(mils,i)],pX,tY)
					pX += 15
				Next
			Else
				For Local i:Int = 3 To 1 Step -1
					DrawImage(_numbers[GetDigit(mils,i)],pX,tY)
					pX += 15
				Next
			End
		End
		
	End
	

End