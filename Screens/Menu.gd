extends Node


func _ready():
	$Options/ColorRect2.visible=false
	$AnimationPlayer.play("FadeInMenù")
	$Options.connect("gui_input",self,"Option_to_Menu")
	Settings.load_Options()
	UpdateLanguage()
	UpdateVolume()
	$LevelMusic.play()
	UpdateLockedLevels()
	

func UpdateVolume():
	if(Settings.Music_Volume==0):
		$LevelMusic.volume_db=-80
	else:
		$LevelMusic.volume_db=(Settings.Music_Volume*5)-35

	
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
	$Main.UpdateLanguage()

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
	$MenuContainer/CreditsButton.set_block_signals(true)
	$MenuContainer/VBoxContainer/Options.set_block_signals(true)
	$MenuContainer/VBoxContainer/Gioca.set_block_signals(true)
	$MenuContainer/VBoxContainer/Esci.set_block_signals(true)
	$AnimationPlayer.play("ToLevels")
	

func _on_Options_pressed():
	$MenuContainer/CreditsButton.set_block_signals(true)
	$MenuContainer/VBoxContainer/Options.set_block_signals(true)
	$MenuContainer/VBoxContainer/Gioca.set_block_signals(true)
	$MenuContainer/VBoxContainer/Esci.set_block_signals(true)
	$AnimationPlayer.play("SwipeToOption")
	

func Option_to_Menu():
	$AnimationPlayer.play("OptionToMenu")
	UpdateLanguage()
	UpdateVolume()


func _on_Back_pressed():
	$AnimationPlayer.play("LevelsToMenu")
	

func _on_Next_pressed():
	$AnimationPlayer.play("NextLevels")


func _on_Back2_pressed():
	$AnimationPlayer.play("BackToLevels1")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="LevelsToMenu" or anim_name=="OptionToMenu":
		$MenuContainer/CreditsButton.set_block_signals(false)
		$MenuContainer/VBoxContainer/Options.set_block_signals(false)
		$MenuContainer/VBoxContainer/Gioca.set_block_signals(false)
		$MenuContainer/VBoxContainer/Esci.set_block_signals(false)
