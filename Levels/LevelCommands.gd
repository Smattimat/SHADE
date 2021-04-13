extends Node
#LevelCommands Livello 1

var Jump 
var Color2 

var Jumpactivated=false
var Coloractivated=false
var UnlockedColors=2

func _ready():
	Jump = get_tree().get_root().get_node("Main").find_node("Jump")
	Color2 = get_tree().get_root().get_node("Main").find_node("Color2")
	Jump.visible=false
	Color2.visible=false
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()

func reapplytoHUD():
	Jump = get_tree().get_root().get_node("Main").find_node("Jump")
	Color2 = get_tree().get_root().get_node("Main").find_node("Color2")
	if Jumpactivated==false:
		Jump.visible=false
	if Coloractivated==false:
		Color2.visible=false
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()

	
func _on_ActivateJump_body_entered(body):
	if body.name == "Player":
		Jump.visible=true
		Jumpactivated=true


func _on_ActivateColor_body_entered(body):
	if body.name == "Player":
		Color2.visible=true
		Coloractivated=true
