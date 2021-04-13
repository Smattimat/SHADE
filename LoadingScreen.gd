extends Control

var timer = Timer.new()
var SCENE

var rng = RandomNumberGenerator.new()
	
func _ready():
	timer.wait_time=3
	timer.connect("timeout",self,"changeScene")
	add_child(timer)
	rng.randomize()
	

func loadScene(var scene):
	self.visible=true
	SCENE=scene
	timer.start()
	var back=rng.randi_range(0, 2)
	print(back)
	$AnimationPlayer.play("dots")
	var path="res://Asset/LoadingImages/im"+str(back)+".png"
	$Node2D/ColorRect/TextureRect.texture=load(path)
	
func changeScene():
	get_tree().change_scene(SCENE)
	
	

