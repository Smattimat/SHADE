extends Node

const IDLE_DURATION=0

export var move_to = Vector2.RIGHT*0
export var speed = 3.0

var follow = Vector2.ZERO

onready var Key = $KeyArea
onready var tween = $MoveTween

func _ready():
	_init_tween()

func _init_tween():
	var duration = move_to.length()/float(speed*32)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION*2+duration)
	tween.start()

func _physics_process(delta):
	Key.position = Key.position.linear_interpolate(follow,0.075)



func _on_KeyArea_body_entered(body):
	if body.name == "Player"and self.visible==true and body.hasKey==false:
		self.visible=false
		$SEffect.play()
		body.hasKey=true
		body.UpdateKey()



