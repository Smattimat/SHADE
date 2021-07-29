extends Control

var skipped = false
var NoSkip
var NoMusic

func display(var name,var NS,NM,LangDep):
	NoSkip=NS
	NoMusic=NM
	$AnimationPlayer.play("Start")
	$VideoPlayer.visible=true
	skipped=false
	if LangDep=="true":
		$VideoPlayer.stream=load("res://Dialogue/Videos"+Settings.Language+"/"+name)
	else:
		$VideoPlayer.stream=load("res://Dialogue/Videos"+"Common"+"/"+name)
	$VideoPlayer.play()
	if NoSkip==true:
		$TouchScreenButton.visible=false
	else:
		$TouchScreenButton.visible=true
	if NoMusic==true:
		var Music = get_tree().get_root().get_node("Main").find_node("LevelMusic")
		Music.stop()

func _skip_stop_video():
	$VideoPlayer.stop()
	$AnimationPlayer.play("Finish")
		

func _on_VideoPlayer_finished():
	_skip_stop_video()


func _on_TouchScreenButton_pressed():
	if skipped==false:
		_skip_stop_video()
	skipped=true



func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name=="Finish"):
		emit_signal("gui_input")
		if NoMusic==true:
			var Music = get_tree().get_root().get_node("Main").find_node("LevelMusic")
			Music.play()
