extends Control

var nextScene
var LevelN

func deploy(var next,var lN):
	nextScene=next
	LevelN=lN
	self.visible=true
	$Music.play()
	if Settings.Language=="IT":
		$BlackOverlay/ColorRect/Label.text="Successo!"
		$BlackOverlay/ColorRect/Label2.text="Hai completato il livello"
	else:
		$BlackOverlay/ColorRect/Label.text="Success!"
		$BlackOverlay/ColorRect/Label2.text="You completed the level"
	
	
func UpdateKarma():
	var Main = get_tree().get_root().get_node("Main")
	if Settings.GameLevelAt==LevelN+1:
		Settings.load_Level()
		Settings.GoodCount=Settings.GoodCount+Main.GoodCount
		Settings.BadCount=Settings.BadCount+Main.BadCount
		Settings.save_Level()
		if LevelN==20:
			Settings.GameLevelAt=Settings.GameLevelAt+5
			if Settings.GoodCount>=Settings.BadCount:
				Settings.ParLevelAt=1
			else:
				Settings.InfLevelAt=1
			Settings.save_Level()
	#implementare per livelli par e inf pk così nn va

func _on_Next_pressed():
	get_tree().change_scene(nextScene)
	UpdateKarma()
	

func _on_Exit_pressed():
	get_tree().change_scene("res://Screens/Menu.tscn")
	UpdateKarma()
