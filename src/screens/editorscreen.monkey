Import ninjah

Class EditorScreen Extends Screen

	Field editor:GameEditor
	
	Method New()
		editor = New GameEditor()
	End
	
	Method Update:Void()
		If KeyHit(KEY_H)
			MyScreenManager.InitiateChangeScreen("levelselector")
		End
		If KeyHit(KEY_ESCAPE)
			MyScreenManager.InitiateChangeScreen("main")
		EndIf
		editor.Update()
	End
	
	Method Draw:Void()
		editor.Draw()
		
	End

End

