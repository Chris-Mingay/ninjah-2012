Import ninjah

Class LevelCoin

	Global CoinCount:Int = 70
	Global NextCoin:Int = 0
	Global Coins:LevelCoin[]
	Global TileSet:Image

	Field X:Int
	Field Y:Int
	Field X2:Int
	Field Y2:Int
	Const W:Int = 16
	Const H:Int = 16
	
	Global CoinTimer:Int = 0
	
	Function Init:Void()
		Coins = New LevelCoin[CoinCount]
		For Local i:Int = 0 To CoinCount - 1
			Coins[i] = New LevelCoin()
		Next
	End
	
	Function DrawAll:Void()
		For Local i:Int = 0 To CoinCount - 1
			If Coins[i].Active = True
				Coins[i].Draw()
			End
		Next
	End
	
	Function Create:Void(tX:Int,tY:Int)
		Coins[NextCoin].Activate(tX,tY)
		NextCoin+=1
		If NextCoin = CoinCount
			NextCoin = 0
		End
	End
	
	Function ReturnActiveCount:Int()
		Local count:Int = 0
		For Local i:Int = 0 To CoinCount - 1
			If Coins[i].Active = True
				count += 1
			End
		Next
		Return count
	End
	
	Function ResetCoins:Void()
		For Local i:Int = 0 To CoinCount - 1
			If Coins[i].Active = True
				Coins[i].Collected = False
			End
		Next
		
		CoinTimer = 0
	End
	
	Function ClearCoins:Void()
		For Local i:Int = 0 To CoinCount - 1
			Coins[i].Active = False
			Coins[i].Collected = False
		Next
	End
	
	Field Active:Bool = False
	Field Collected:Bool = False
	
	Method Activate(tX:Int,tY:Int)
		Active = True
		X = tX
		Y = tY
		X2 = tX+W
		Y2 = tY+H
		Active = Collected = False
	End
	
	Method Collect:Void()
		Collected = True
		Game.ActiveCoins -= 1
		GenerateCoinParticles(X + (LevelCoin.W * 0.5), Y + (LevelCoin.H * 0.5))
		SoundSystem.Play("coin")
	End
	
	Method Draw:Void()
		If Collected = False
			Local dY:Float = Cos(CoinTimer + X)
			If dY > 0
				dY = 0
			EndIf
				
			DrawImage(TileSet, X, Y + dY)
		End
	End
End
