extends Node2D

var Pressed=false
var Counter=0
var differentstate=false

var timer = Timer.new()

export var ID=1
export var delay=0.1

var UPSkin = preload("res://Asset/InteractableThings/PressurePlateTestUp.png")
var DownSkin = preload("res://Asset/InteractableThings/PressurePlateTestDown.png")

func _ready():
	$Area2D/Sprite.texture=UPSkin;
	timer.wait_time=delay
	timer.connect("timeout",self,"update")
	add_child(timer)

func update():
	if Pressed==true:
		$Area2D/Sprite.texture=UPSkin
		Pressed=false
	else:
		$Area2D/Sprite.texture=DownSkin
		Pressed=true
	differentstate=true
	timer.stop()


func _on_Area2D_body_entered(body):
	Counter+=1
	if Counter>0:
		update()
		
	


func _on_Area2D_body_exited(body):
	Counter-=1
	if Counter==0:
		timer.start()
