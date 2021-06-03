Import mojo
Import os
Import raz
Import src.includes

Global ClosestResolutionWidth:Int
Global ClosestResolutionHeight:Int

#If TARGET="bmax"
    Extern
	
        Function HidePointer:Void() = "HideMouse"
		Function ShowPointer:Void() = "ShowMouse"
		Function BMaxMills:Int() = "MilliSecs"
		Function MaxModSetMusicVolume:Void(tVol:Float) = "MaxModSetMusicVolume"
		Function MaxModPlayTrack:Void(tTrack:Int) = "MaxModPlayTrack"
		Function UpdateMaxMod:Void() = "UpdateMaxMod"
		
		
#Else
	Function HidePointer:Void()
		
	End
	
	Function ShowPointer:Void()
		
	End
	
	Function BMaxMills:Int()
		Return Millisecs()
	End
	
	Function MaxModSetMusicVolume:Void(tVol:Float)
		SetMusicVolume(tVol)
	End
	
	Function MaxModPlayTrack:Void(tTrack:Int)
		
	End
	
	Function UpdateMaxMod:Void()
		
	End
	
#Endif

Public


Class MyScreenManager Extends ScreenManager
	Function Init:Void()
		
		InitGraphics()
		
		InitSound()
		
		InitScreens()
		
		GraveStone.Init()
		
		LevelBullet.Init()
		
		LevelCoin.Init()
		Mine.Init()
		
		
		ParticleManager.Init()
		
		
	End
	
	Function DrawFade:Void()
		If FadeAlpha > 0
			SetColor(0,0,0)
			SetAlpha(FadeAlpha)
			DrawRect(0,0,NinjahApp.ScreenWidth,NinjahApp.ScreenHeight)
		End
	End
	
	Function InitScreens:Void()
		Screens.Set("main",New MainScreen())
		Screens.Set("game",New GameScreen())
		Screens.Set("credits",New CreditsScreen())
		Screens.Set("intro",New IntroScreen())
		Screens.Set("editor",New EditorScreen())
		Screens.Set("levelselector",New LevelSelectScreen())
		Screens.Set("options",New OptionsScreen())
		ActiveScreen = Screens.Get("credits")
		MyScreenManager.InitiateChangeScreen("intro")
	End
	
	Function InitGraphics:Void()
	
		LevelBlock.TileSet1 = LoadImage( "graphics/blocks.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners1 = LoadImage( "graphics/corners_4.png", 16, 16, 16, Image.DefaultFlags)
		LevelBlock.TileSet2 = LoadImage( "graphics/blocks_2.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners2 = LoadImage( "graphics/corners_2.png", 16, 16, 16, Image.DefaultFlags)
		LevelBlock.TileSet3 = LoadImage( "graphics/blocks_3.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners3 = LoadImage( "graphics/corners_3.png", 16, 16, 16, Image.DefaultFlags)
		LevelBlock.TileSet4 = LoadImage( "graphics/blocks_4.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners4 = LoadImage( "graphics/corners_4.png", 16, 16, 16, Image.DefaultFlags)
		LevelBlock.TileSet5 = LoadImage( "graphics/blocks_5.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners5 = LoadImage( "graphics/corners_5.png", 16, 16, 16, Image.DefaultFlags)
		LevelBlock.TileSet6 = LoadImage( "graphics/blocks_6.png", 16, 16, (16 * 3), Image.DefaultFlags)
		LevelBlock.Corners6 = LoadImage( "graphics/corners_6.png", 16, 16, 16, Image.DefaultFlags)
	
		LevelBlock.TileSet = LevelBlock.TileSet2
		LevelBlock.Corners = LevelBlock.Corners2
		
		
		Game.gfxBack1 = LoadImage("graphics/background_1.png")
		Game.gfxBack2 = LoadImage("graphics/background_2.png")
		Game.gfxBack3 = LoadImage("graphics/background_3.png")
		Game.gfxBack = Game.gfxBack2
		Game.gfxReady = LoadImage("graphics/ready.png", 1, Image.MidHandle )
		Game.gfxSteady = LoadImage("graphics/steady.png", 1, Image.MidHandle )
		Game.gfxGo = LoadImage("graphics/go.png", 1, Image.MidHandle )
		Game.gfxPixel = LoadImage("graphics/guide.png", 1, Image.MidHandle )
		Game.gfxIconBack = LoadImage("graphics/icon_blank.png",1,Image.MidHandle)
		Game.gfxIconMove = LoadImage("graphics/icon_move.png",1,Image.MidHandle)
		Game.gfxIconRope = LoadImage("graphics/icon_rope.png",1,Image.MidHandle)
		Game.gfxIconGun = LoadImage("graphics/icon_bullet.png",1,Image.MidHandle)
		Game.gfxGui = LoadImage("graphics/gui_back.png",1,Image.DefaultFlags)
		Game.gfxGuiBack = LoadImage("graphics/besttimes_back.png",1,Image.DefaultFlags)
		Game.gfxGhost = LoadImage("graphics/ghost.png",1,Image.MidHandle)
		Game.gfxGuiSolid = LoadImage("graphics/gui_back_solid.png", 1, Image.DefaultFlags)
		Game.gfxStartMarker = LoadImage("graphics/start_marker.png", 1, Image.MidHandle)
		LevelSelector.gfxSelectLeft = LoadImage("graphics/select_left.png",1,Image.DefaultFlags)
		LevelSelector.gfxSelectRight = LoadImage("graphics/select_right.png",1,Image.DefaultFlags)
		LevelBullet.TileSet = LoadImage( "graphics/bullet.png", 1, Image.MidHandle )
		LevelRope.TileSet = LoadImage( "graphics/rope.png", 1, Image.MidHandle )
		LevelCoin.TileSet = LoadImage( "graphics/coin.png", 1 )
		LevelExit.TileSet = LoadImage( "graphics/exit.png", 1)
		Firework.Init()
		NinjahSprite.Init()
		ParticleSprites.Init()
		
		OptionsScreen.gfxTitle = LoadImage("graphics/menu_options.png")
		OptionsScreen.gfxVolumeBar = LoadImage("graphics/volume_bar.png")
		OptionsScreen.gfxVolumeMark = LoadImage("graphics/volume_mark.png")
		
		OptionsScreen.gfxTicked = LoadImage("graphics/ticked.png")
		OptionsScreen.gfxNotTicked = LoadImage("graphics/not_ticked.png")
		
	End
	
	Function InitSound:Void()
		MySoundSystem.Init()
		MySoundSystem.Sounds.Set("step",LoadSound("sound/step.wav"))
		MySoundSystem.Sounds.Set("bounce",LoadSound("sound/bounce.wav"))
		MySoundSystem.Sounds.Set("jump",LoadSound("sound/jump.wav"))
		MySoundSystem.Sounds.Set("firework_pop",LoadSound("sound/firework_pop.wav"))
		MySoundSystem.Sounds.Set("firework_launch",LoadSound("sound/firework_launch.wav"))
		MySoundSystem.Sounds.Set("ready",LoadSound("sound/ready.wav"))
		MySoundSystem.Sounds.Set("go",LoadSound("sound/go.wav"))
		MySoundSystem.Sounds.Set("die",LoadSound("sound/die.wav"))
		MySoundSystem.Sounds.Set("applause",LoadSound("sound/applause.wav"))
		MySoundSystem.Sounds.Set("click",LoadSound("sound/click.wav"))
		MySoundSystem.Sounds.Set("select", LoadSound("sound/ready.wav"))
		MySoundSystem.Sounds.Set("exitopen",LoadSound("sound/exitopen.wav"))
		MySoundSystem.Sounds.Set("finish",LoadSound("sound/levelfinish.wav"))
		MySoundSystem.Sounds.Set("shot",LoadSound("sound/shot.wav"))
		MySoundSystem.Sounds.Set("change",LoadSound("sound/change.wav"))
		MySoundSystem.Sounds.Set("coin",LoadSound("sound/coin.wav"))
		MySoundSystem.Sounds.Set("new_time",LoadSound("sound/new_time.wav"))
		MySoundSystem.Sounds.Set("new_best_time",LoadSound("sound/new_best_time.wav"))
		' MySoundSystem.Sounds.Set("drum_roll",LoadSound("sound/drum_roll.wav"))
		MySoundSystem.Sounds.Set("bad_move", LoadSound("sound/bad_move.wav"))
		
		MySoundSystem.Sounds.Set("rope_in", LoadSound("sound/rope_in.wav"))
		MySoundSystem.Sounds.Set("rope_out", LoadSound("sound/rope_out.wav"))
		MySoundSystem.Sounds.Set("rope_connect", LoadSound("sound/rope_connect.wav"))
		
		MySoundSystem.Sounds.Set("falafel_drop",LoadSound("sound/falafel_drop.wav"))
		MySoundSystem.Sounds.Set("falafel_psst",LoadSound("sound/falafel_psst.wav"))
		MySoundSystem.Sounds.Set("falafel_bang",LoadSound("sound/falafel_bang.wav"))
		
		
		' PlayMusic("music/test.wma",1)
	End
End

Class MySoundSystem Extends SoundSystem

	'Global Track1:String = "music/1.wma"
	'Global Track2:String = "music/2.wma"
	'Global Track3:String = "music/3.wma"
	'Global Track4:String = "music/4.wma"
	'Global Track5:String = "music/5.wma"
	
	Global Track1:String = "music/1.ogg"
	Global Track2:String = "music/2.ogg"
	Global Track3:String = "music/3.ogg"
	Global Track4:String = "music/4.ogg"
	Global Track5:String = "music/5.ogg"
	
	'Global Track2:String = "music/2.mp3"
	'Global Track3:String = "music/3.mp3"
	'Global Track4:String = "music/4.wav"
	'Global Track5:String = "music/5.wav"
	
	Global MusicVolume:Float = 1
	
	Global CurrentMusicTrack:Int = 0
	
	Function InitMusic:Void()
		Local nextTrack:Int = Floor(Rnd(0,5))
		PlayTrack(nextTrack)
	End
	
	Function UpdateMusic:Void()
	
	
		If JoyHit(JOY_LB) Or KeyHit(KEY_HOME)
			MaxModPlayTrack(CurrentMusicTrack - 1)
			
		Endif
		
		If JoyHit(JOY_RB) Or KeyHit(KEY_END)
			MaxModPlayTrack(CurrentMusicTrack + 1)
		EndIf
		
		UpdateMaxMod()
		
'		If MusicState() = 0 And MusicVolume > 0 And Game.Status <> Game.PLAY
'			
'			Local nextTrack:Int = CurrentMusicTrack
'			While nextTrack = CurrentMusicTrack
'				nextTrack = Floor(Rnd(0,5))
'			Wend
'			If nextTrack = 5
'				nextTrack = 4
'			Endif
'			PlayTrack(nextTrack)
'		End

	End
	
	Function PlayTrack:Void(track:Int)
	
		' Return
		
		Local tTrack:Int = track
		If tTrack < 0
			tTrack = 4
		Endif
		If tTrack > 4
			tTrack = 0
		Endif
		
		CurrentMusicTrack = tTrack
		
		
		
		Select tTrack
			Case 0
				PlayMusic(Track1,0)
			Case 1
				PlayMusic(Track2,0)
			Case 2
				PlayMusic(Track3,0)
			Case 3
				PlayMusic(Track4,0)
			Case 4
				PlayMusic(Track5,0)
		End
		
		
		MaxModSetMusicVolume(MySoundSystem.MusicVolume)
	
		
	End
	
End

Class NinjahApp Extends App

	Global LinuxTestDebug:Bool = False

	Global fontSmall:AngelFont
	Global fontNormal:AngelFont
	Global fontLarge:AngelFont
	
	Global gfxXButton:Image
	Global gfxYButton:Image
	Global gfxAButton:Image
	Global gfxBButton:Image
	
	Global gfxBack:Image
	
	Global gfxColourfy:Image
	Global gfxTick:Image
	Global gfxMedal:Image
	
	Global ScreenWidth:Float
	Global ScreenHeight:Float
	Global ScreenXScale:Float
	Global ScreenYScale:Float
	Global ScreenScaling:Bool
	
	Global Keyboard:Bool = True
	
	Global Title:Image
	
	Global gfxButtonBack:Image

	Global sx1:Int
	Global sy1:Int
	Global sw:Int
	Global sh:Int
	
	Global FrameTicker:Int = 0
	
	Global MusicStarted:Bool = False

	Method OnCreate()
	
		SetVirtualDisplay(1280, 720)
	
		LinuxTestDebug = False
	
		
		'ScreenWidth = 640
		'ScreenHeight = 360
		ScreenWidth = 1280
		ScreenHeight = 720
		ScreenXScale = DeviceWidth() / ScreenWidth
		ScreenYScale = DeviceHeight() / ScreenHeight
		ScreenScaling = False
		
		sx1 = ScreenWidth / 20
		sy1 = ScreenHeight / 20
		sw = sx1 * 18
		sh = sy1 * 18
	
		
		AppState.Init()	
		
		MyScreenManager.Init()
		
		Game.Init()
		
		TextImages.Init()
		
		DrawHelper.Init()
		SetUpdateRate 60
		
		
		'fontNormal = New AngelFont()
		'fontNormal.LoadFont("fonts/harbaba_normal")
		
		'fontSmall = New AngelFont()		
		'fontSmall.LoadFont("fonts/harbaba_small")
		
		'fontLarge = New AngelFont()
		'fontLarge.LoadFont("fonts/harbaba_large")
		
		gfxXButton = LoadImage("graphics/xboxControllerButtonX.png",1,Image.DefaultFlags)
		gfxYButton = LoadImage("graphics/xboxControllerButtonY.png",1,Image.DefaultFlags)
		gfxAButton = LoadImage("graphics/xboxControllerButtonA.png",1,Image.DefaultFlags)
		gfxBButton = LoadImage("graphics/xboxControllerButtonB.png", 1, Image.DefaultFlags)
		
		gfxBack = LoadImage("text/back.png",1,Image.DefaultFlags)
		
		gfxColourfy = LoadImage("graphics/colourfy.png",1,Image.MidHandle)
		
		gfxTick = LoadImage("graphics/tick.png",1,Image.DefaultFlags)
		gfxMedal = LoadImage("graphics/medal.png",1,Image.DefaultFlags)
		
		Title = LoadImage("graphics/ninjah_title.png")
		
		gfxButtonBack = LoadImage("graphics/button_back.png",1,Image.DefaultFlags)
		
		
		AppState.Load()
		
		MaxModSetMusicVolume(MySoundSystem.MusicVolume)
		
		HidePointer()
		
		Seed = BMaxMills()
		
		
		' Graphics
		
		
		
		' AngelFont.Use("fonts/harbaba_small")
		
		 ' PlayMusic("music/1.wav",0)
		 
		 
		
			
	End
	Method OnUpdate()
	
		#If TARGET="glfw"
		If KeyHit(KEY_C)
			MyScreenManager.InitiateChangeScreen("editor")
		EndIf
		#EndIf
	
		If MusicStarted = False
			MusicStarted = True
		Endif
	
		If JoyDown(JOY_BACK)
			Error ""
		End
	
		FrameTicker += 1
		If FrameTicker = 60
			FrameTicker = 0
		End
		
		MySoundSystem.UpdateMusic()
		
		MyScreenManager.Update()
		
		If MouseHit()
			
		EndIf
		
		
		
	End
	Method OnRender()
	
		UpdateVirtualDisplay()
	
		'If ScreenScaling
		'	PushMatrix()			
		'	Scale(ScreenXScale,ScreenYScale)
		'End
	
		Cls
		
		MyScreenManager.Draw()
		MyScreenManager.DrawFade()
		
		' DrawSafeZone()
		
		'If ScreenScaling
		'	PopMatrix()
		'End
		
		' DrawFrameTicker()
	End
	
	Method DrawSafeZone:Void()
		SetColor(255,0,0)
		SetAlpha(1)
		SetBlend(0)
		DrawHollowRect(sx1,sy1,sw,sh)
		DrawLine(sx1,sy1+sh-32,sx1+sw,sy1+sh-32)
	End
	
	Method DrawFrameTicker:Void()
		SetAlpha(1)
		SetColor(128,128,128)
		DrawLine(sx1+sw-120,sy1+sh-120,sx1+sw-60,sy1+sh-120)
		DrawLine(sx1+sw-120,sy1+sh-60,sx1+sw-60,sy1+sh-60)
		SetColor(255,255,255)
		DrawLine(sx1+sw-120,sy1+sh-120 + FrameTicker,sx1+sw-60,sy1+sh-120 + FrameTicker)
		
	End
End


Function Main()
	' MyHideMouse()
	New NinjahApp
End





