extends Node2D



var timer = Timer.new()

const IDLE_DURATION=1.0

export var move_to = Vector2.RIGHT*192
export var speed = 3.0

var Counter=0
var alive = true
var follow = Vector2.ZERO

onready var drone = $DroneBody
onready var tween = $MoveTween

var Eletric = preload("res://Asset/Drone/HitDrone.wav")
var die=preload("res://Asset/Drone die/Drone Espl.ogg")

var rng= RandomNumberGenerator.new()
var incazed=false

func _ready():
	$Sound.pause_mode=Node.PAUSE_MODE_INHERIT
	_init_tween()	
	timer.wait_time=0.1
	timer.connect("timeout",self,"GameOver") 
	add_child(timer)



func _init_tween():
	var duration = move_to.length()/float(speed*32)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION*2+duration)
	tween.start()

const GRAVITY = 12000.0

func _physics_process(delta):
	if alive==true:
		drone.position = drone.position.linear_interpolate(follow,0.075)
		rng.randomize()
		Counter+=rng.randf_range(1,15)
		rng.randomize()
		if incazed==true:
			if Counter>500:
				Counter=0
				incazed=false
				$Sound.stop	()
				$DroneBody/AnimatedSprite.play("default")
				tween.resume(self)	
		else:	
			rng.randomize()
			if Counter>2500:	
				Counter=0		
				incazed=true		
				$Sound.stream=Eletric
				$Sound.play()
				tween.stop(self)
				$DroneBody/AnimatedSprite.play("incaz")
	else:
		var force = Vector2(0, GRAVITY)	
		var velocity = force * delta
		$DroneBody.move_and_slide(velocity,Vector2(0, -1))
		if $DroneBody.is_on_floor(): 
			velocity.y=0
	

		

func _on_Area2D_body_entered(body):
	if alive==true and (body.name=="Player" or body.name=="KPerson"):
		$Sound.pause_mode=Node.PAUSE_MODE_PROCESS
		timer.start() 
		var dialogue = get_tree().get_root().get_node("Main").find_node("DialogueBox")
		dialogue.visible=false
		$Sound.stream=Eletric
		$Sound.play()
		tween.stop_all()
		$DroneBody/AnimatedSprite.play("incaz")

func _on_AreaKill_body_entered(body):
	if(body.name=="Player" or body.name=="KPerson"):
		tween.stop_all()
		if alive==true:
			$Sound.stream=die
			$Sound.play()
		alive=false
		$DroneBody/AnimatedSprite.play("Die")
		

func GameOver():
	var Screen = get_tree().get_root().get_node("Main").find_node("GameOverScreen")	
	Screen.visible = true




