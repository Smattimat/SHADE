#WorldComplete.gd
extends Area2D

const IDLE_DURATION=0

var called=false
#export a variable means doing things to it not via code
export(String,FILE,"*.tscn")var next_world
export var levelN=0

export var move_to = Vector2.RIGHT*0
export var speed = 3.0

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
		if body.name=="Player" and called==false:
			if levelN==777:
				var Main = get_tree().get_root().get_node("Main").find_node("Main")
				Main.DeactivateLevel()
			else:
				var EndLevelScreen = get_tree().get_root().get_node("Main").find_node("EndLevelScreen")
				EndLevelScreen.deploy(next_world,levelN)
				Settings.load_Level()
				if Settings.GameLevelAt==levelN:
					Settings.GameLevelAt=Settings.GameLevelAt+1
					Settings.save_Level()
				var Right = get_tree().get_root().get_node("Main").find_node("Right")
				var Left = get_tree().get_root().get_node("Main").find_node("Left")
				var Jump = get_tree().get_root().get_node("Main").find_node("Jump")
				var Color2 = get_tree().get_root().get_node("Main").find_node("Color2")
				var exit =get_tree().get_root().get_node("Main").find_node("Exit")
				exit.visible=false
				Right.visible=false
				Left.visible=false
				Jump.visible=false
				Color2.visible=false
				called=true
