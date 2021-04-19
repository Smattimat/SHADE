extends Control

var NoSkip
var Completed=false


func display(var text,var speaker,var NS):
	NoSkip=NS
	Completed=false
	$TextureRect/RichTextLabel.text=text
	$Speaker.texture=speaker
	$TextureRect/RichTextLabel.percent_visible=0
	var duration=text.length()/20
	if duration<0.1:
		duration=0.2
	$CharTween.interpolate_property($TextureRect/RichTextLabel,"percent_visible",0,1,duration,
	Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$CharTween.start()
	if NoSkip==true:
		$Exit.visible=false
		$Next.visible=false
	else:
		$Exit.visible=true
		$Next.visible=true


func _on_CharTween_tween_completed(object, key):
	$CharTween.remove(object,key)
	$CharTween.stop_all()
	Completed=true
	if NoSkip==true:
		$Next.visible=true
	$AnimationPlayer.play("Next hopp")


func _on_Next_pressed():
	if Completed==true:
		$AnimationPlayer.stop()
		$Next/Next_sprite.scale.y=1.28
		emit_signal("gui_input")
	else:		
		$CharTween.remove_all()
		$CharTween.stop_all()
		$TextureRect/RichTextLabel.percent_visible=1
		Completed=true
		$AnimationPlayer.play("Next hopp")


func _on_Exit_pressed():
	$AnimationPlayer.stop()
	$Next/Next_sprite.scale.y=1.28
