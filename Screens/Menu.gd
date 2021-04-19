extends Node

func _ready():
	$AnimationPlayer.play("FadeInMenù")
	$Options.connect("gui_input",self,"Option_to_Menu")
	$LoadingScreen.visible=false
	Settings.save_Level() #To reset level at one before try and release
	Settings.save_Options() #To reset Options at one before try and release
	UpdateLockedLevels()
	UpdateLanguage()
	
func UpdateLanguage():
	$Options.UpdateLanguage()
	if Settings.Language=="IT":
		$Levels1/Label.text="Mondi 1-3"
		$Levels2/Label.text="Mondi 4-6"
		$MenuContainer/CreditsButton/Label.text="Crediti-TM"
	else:
		$Levels1/Label.text="Worlds 1-3"
		$Levels2/Label.text="Worlds 4-6"
		$MenuContainer/CreditsButton/Label.text="Credits-TM"

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
	$MenuContainer/CreditsButton.set_block_signals(true)

func _on_Options_pressed():
	$AnimationPlayer.play("SwipeToOption")
	$MenuContainer/CreditsButton.set_block_signals(true)

func Option_to_Menu():
	$AnimationPlayer.play("OptionToMenu")
	$MenuContainer/CreditsButton.set_block_signals(false)
	UpdateLanguage()


func _on_Back_pressed():
	$AnimationPlayer.play("LevelsToMenu")
	$MenuContainer/CreditsButton.set_block_signals(false)

func _on_Next_pressed():
	$AnimationPlayer.play("NextLevels")


func _on_Back2_pressed():
	$AnimationPlayer.play("BackToLevels1")
