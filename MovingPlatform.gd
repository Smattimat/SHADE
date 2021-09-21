extends Node2D

const IDLE_DURATION=1.0

export var move_to = Vector2.RIGHT*192
export var speed = 3.0

var follow = Vector2.ZERO

var counter=0

onready var platform = $MPlatform
onready var tween = $MoveTween

func _ready():
	_init_tween()

func _init_tween():
	var duration = move_to.length()/float(speed*32)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION*2+duration)
	tween.start()

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow,0.075)

func _on_StopArea_body_entered(body):
	if body.name=="Player"or body.name=="Person":
		counter+=1
		tween.stop(self)


func _on_StopArea_body_exited(body):
	if body.name=="Player"or body.name=="Person":
		counter-=1
		if counter==0:
			tween.resume(self)
