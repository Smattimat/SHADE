extends Control

var timer = Timer.new()
var SCENE
func _ready():
	timer.wait_time=0.6
	timer.connect("timeout",self,"changeScene")
	add_child(timer)

func loadScene(var scene):
	self.visible=true
	SCENE=scene
	timer.start()
	
func changeScene():
	get_tree().change_scene(SCENE)
	
	

