extends Node2D

var timer = Timer.new()

export var Lava=true

func _ready():
	timer.wait_time=0.1
	timer.connect("timeout",self,"GameOver") 
	add_child(timer)
	if Lava==false:
		if(Settings.Particle==true):
			$Particles2D.emitting=false
		$LavaTune.stop()

func _on_Area2D_body_entered(body):
	if(body.name=="Player" or body.name=="KPerson"):
		timer.start() 
		var dialogue = get_tree().get_root().get_node("Main").find_node("DialogueBox")
		dialogue.visible=false
		$Sound.play()
		$Particles2D.emitting=true
		
func GameOver():
	var Screen = get_tree().get_root().get_node("Main").find_node("GameOverScreen")	
	Screen.visible = true
