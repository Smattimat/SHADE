extends Node

func _ready():
	$AnimationPlayer.play("FadeInMenù")
	$Options.connect("gui_input",self,"Option_to_Menu")
	$LoadingScreen.visible=false
	Settings.save_Level() #To reset level at one before try and release
	UpdateLockedLevels()
	
func UpdateLockedLevels():
	var lvlBut=get_tree().get_nodes_in_group("LevelButtons")
	Settings.load_Level()
	var levelat=Settings.GameLevelAt
	var InfLevelAt=Settings.InfLevelAt
	var ParLevelAt=Settings.ParLevelAt
	for but in lvlBut:
		if but.Inf==true:
			if but.levelN<InfLevelAt+1:
				but.setUnlocked()
			else:
				but.setLocked()
		elif but.Par==true:
			if but.levelN<ParLevelAt+1:
					but.setUnlocked()
			else:
				but.setLocked()
		else:	
			if but.levelN<levelat+1:
				but.setUnlocked()
			else:
				but.setLocked()
	

func _on_Esci_pressed():
	get_tree().quit()


func _on_Gioca_pressed():
	$AnimationPlayer.play("ToLevels")


func _on_Options_pressed():
	$AnimationPlayer.play("SwipeToOption")

func Option_to_Menu():
	print("requestHeard")
	$AnimationPlayer.play("OptionToMenu")


func _on_Back_pressed():
	$AnimationPlayer.play("LevelsToMenu")


func _on_Next_pressed():
	$AnimationPlayer.play("NextLevels")


func _on_Back2_pressed():
	$AnimationPlayer.play("BackToLevels1")
