extends Node2D

var timer = Timer.new()

export var Lava=true

func _ready():
	timer.wait_time=0.1
	timer.connect("timeout",self,"GameOver") 
	add_child(timer)
	if(Settings.Particle==true):
		$Particles2D.emitting=true
	else:
		$Particles2D.emitting=false
	if Lava==false:	
		$Particles2D.emitting=false
		$LavaTune.stop()
	$AnimationPlayer.play("Shader")

func _on_Area2D_body_entered(body):
	if(body.name=="Player" or body.is_in_group("People")):
		timer.start() 
		var dialogue = get_tree().get_root().get_node("Main").find_node("DialogueBox")
		dialogue.visible=false
		$Sound.play()
		
		
func GameOver():
	var Screen = get_tree().get_root().get_node("Main").find_node("GameOverScreen")	
	Screen.visible = true
	

