extends Node

export var Id = 0
var Holehaskey = false
var passed=false

var KeySkin = preload("res://Asset/InteractableThings/ToppaPienaTest.png")
var NoKeySkin = preload("res://Asset/InteractableThings/ToppaVuotaTest.png")

func UpdateKey():
	if Holehaskey==true:
		$Area2D/Sprite.texture=KeySkin
	else:
		$Area2D/Sprite.texture=NoKeySkin

func interchange(body):
	passed=false
	if Holehaskey==true and body.hasKey==false:
			Holehaskey=false
			body.hasKey=true
			passed=true
	elif Holehaskey==false and body.hasKey==true:
			Holehaskey=true
			body.hasKey=false
			passed=true
	body.UpdateKey()
	UpdateKey()
	

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		interchange(body)		
	else:
		pass





