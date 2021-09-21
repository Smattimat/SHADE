extends Area2D


const IDLE_DURATION=0

export var move_to = Vector2.RIGHT*0
export var speed = 3.0
export var Id=1

var Active=false

var follow = Vector2.ZERO
onready var tween = $MoveTween

func _ready():
	_init_tween()
	

func _init_tween():
	var duration = move_to.length()/float(speed*32)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION*2+duration)
	tween.start()


func _physics_process(delta):
	#get overlapping bodyes visto in search help
	$Sprite.position = $Sprite.position.linear_interpolate(follow,0.075)
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name=="Player":
			var main = get_tree().get_root().get_node("Main")
			main.CheckAt=Id
			$AnimationPlayer.play("Spin")
			Active=true


func _on_CheckPoint_body_entered(body):
	if body.name=="Player"&&Active==false:
		$AudioStreamPlayer.play()
