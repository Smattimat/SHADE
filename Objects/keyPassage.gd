extends Node

export var Id = 0

var activeHoles=0
export var preactive = false


func _ready():
	Resett()
	Update()

var noholeSkin = preload("res://Asset/InteractableThings/PassageClosedNochiave.png")
var oneholeSkin = preload("res://Asset/InteractableThings/PassageClosedUnachiave.png")
var twoholeSkin = preload("res://Asset/InteractableThings/PassaggioOpenChiavi.png")

func Resett():
	if preactive==false:
		activeHoles=0
	else:
		activeHoles=1

func CountUp():
	activeHoles+=1
	
func Update():
	if activeHoles==0:
		$Sprite.texture=noholeSkin
		$StaticBody2D/CollisionShape2D.disabled=false
	elif activeHoles==1:
		$Sprite.texture=oneholeSkin
		$StaticBody2D/CollisionShape2D.disabled=false
	else:
		$Sprite.texture=twoholeSkin
		$StaticBody2D/CollisionShape2D.disabled=true
	
