extends Node
#LevelCommands Livello 3

var UnlockedColors=2
var appChoice
var signalCounter=0


func _ready():
	#connecting signals for indialogue action
	var NarInt=get_tree().get_root().get_node("Main").find_node("NarrationInterface")
	NarInt.connect("gui_input",self,"HandleSignal")
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
	

func HandleSignal():
	signalCounter=signalCounter+1
	if signalCounter==1:
		$AnimationPlayer.play("TimePass")
	elif signalCounter==2:
		var Player=get_tree().get_root().get_node("Main").find_node("Player")
		Player.UpdateColor("Green")
	elif signalCounter==3:
		$AnimationPlayer.play("Fuse")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var Main=get_tree().get_root().get_node("Main")
		var UnlockWithPhoto=get_tree().get_root().get_node("Main").find_node("UnlockGreenPhoto")
		var UnlockWithMap=get_tree().get_root().get_node("Main").find_node("UnlockGreenMap")
		if(Main.ChoicesArray[0].Good==true):
			var Note2=get_tree().get_root().get_node("Main").find_node("LabNote2")
			Note2.GivesPhoto=true
			UnlockWithPhoto.disabled=false
			UnlockWithMap.disabled=true
			appChoice="good"
		else:
			UnlockWithPhoto.disabled=true
			UnlockWithMap.disabled=false
			appChoice="bad"
			
			
		




	

func _on_UnlockWithPhoto_body_entered(body):
	if body.name == "Player"and body.hasPhoto:
		UnlockedColors=3
		reapplytoHUD()
		var Person=get_tree().get_root().get_node("Main").find_node("Encounter")
		Person.UpdateColor("Green")


func _on_UnlockWithMap_body_entered(body):
	if body.name == "Player"and appChoice=="bad":
		UnlockedColors=3
		reapplytoHUD()
