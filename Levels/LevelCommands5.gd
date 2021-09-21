extends Node

var UnlockedColors=3
var PlayingSiren=false
var signalCounter=0
var goodchoice=false

func _ready():
	var Buttons=get_tree().get_nodes_in_group("ColorButtons")
	for but in Buttons:
		if but.colNum>UnlockedColors:
			but.setLocked()
		else:
			but.setUnlock()
	var NarInt=get_tree().get_root().get_node("Main").find_node("NarrationInterface")
	NarInt.connect("gui_input",self,"HandleSignal")
	

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
		var Aplay = get_tree().get_root().get_node("Main").find_node("APlayer")
		Aplay.play("Gass")


func _on_Area2D2_body_entered(body):
	if body.name == "Player" and PlayingSiren==true:
		var Siren = get_tree().get_root().get_node("Main").find_node("Siren")
		Siren.stop()
		PlayingSiren=false


func _on_Area2D3_body_entered(body):
	if body.name == "Player" and PlayingSiren==false:
		var Siren = get_tree().get_root().get_node("Main").find_node("Siren")
		Siren.play()
		PlayingSiren=true
		var Aplay = get_tree().get_root().get_node("Main").find_node("APlayer")
		Aplay.play("Gass2")

var passato=false
func _on_Area2D4_body_entered(body):
	if body.name=="Player":
		if passato==false:
			var Aplay = get_tree().get_root().get_node("Main").find_node("APlayer")
			Aplay.stop(false)
			passato=true
	

func HandleSignal():
	signalCounter=signalCounter+1
	if signalCounter==1:
		var Main=get_tree().get_root().get_node("Main")
		var Fplay = get_tree().get_root().get_node("Main").find_node("FinalPlayer")
		if(Main.ChoicesArray[0].Good==true):
			goodchoice=true
			Fplay.play("Good")
		else:
			goodchoice=false
			var P = get_tree().get_root().get_node("Main").find_node("Player")
			P.UpdateColor("Green")
			Fplay.play("Bad")
	elif signalCounter==2:
		var Aplay = get_tree().get_root().get_node("Main").find_node("APlayer")
		Aplay.play()
		var P = get_tree().get_root().get_node("Main").find_node("Player")
		P.UpdateColor("Gray")
	elif signalCounter==3:
		UnlockedColors=4
		reapplytoHUD()
		var P = get_tree().get_root().get_node("Main").find_node("Player")
		P.UpdateColor("Blue")
		
		
	


func _on_Area2D5_body_entered(body):
	if body.name == "Player" and PlayingSiren==true:
		var Siren = get_tree().get_root().get_node("Main").find_node("Siren")
		Siren.stop()
		PlayingSiren=false
		var Pers = get_tree().get_root().get_node("Main").find_node("Person")
		Pers.position.x=1792
