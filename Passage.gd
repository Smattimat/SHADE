extends Node2D

export var ID=1
export var AlreadyOpen=false

var OpenSkin = preload("res://Asset/InteractableThings/PassaggioOpen.png")
var ClosedSkin = preload("res://Asset/InteractableThings/PassageClosed.png")

func _ready():
	if(AlreadyOpen==true):
		Open()

func Open():
	$StaticBody2D/CollisionShape2D.disabled=true
	$Sprite.texture=OpenSkin

func Close():
	$StaticBody2D/CollisionShape2D.disabled=false
	$Sprite.texture=ClosedSkin
