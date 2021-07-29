extends Node

var UnlockedColors=3
var PlayingSiren=false
func _ready():
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()
	

func reapplytoHUD():
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()


func _on_Area2D_body_entered(body):
	if body.name == "Player" and PlayingSiren==false:
		var Siren = get_tree().get_root().get_node("Main").find_node("Siren")
		Siren.play()
		PlayingSiren=true
