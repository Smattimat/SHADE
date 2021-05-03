extends Node
#LevelCommands Livello 2

var UnlockedColors=2

func _ready():
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()
	#night test
	var Night=get_tree().get_root().get_node("Main").find_node("Night")
	Night.visible=true
	var Player=get_tree().get_root().get_node("Main").find_node("Player")
	Player.BackLayer4Sprite="res://Asset/Sfondi/NightSky.png"

func reapplytoHUD():
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()
			
	#night test
	var Night=get_tree().get_root().get_node("Main").find_node("Night")
	Night.visible=true
	var Player=get_tree().get_root().get_node("Main").find_node("Player")
	Player.BackLayer4Sprite="res://Asset/Sfondi/NightSky.png"
