extends Control


func display(var name,var NS):	
	self.visible=true
	$TextureRect/ShownImage.texture=load("res://Dialogue/Images/"+name)
	$TextureRect/AnimationPlayer.play("Next Hopp")





func _on_Next_pressed():	
	$TextureRect/AnimationPlayer.stop()
	$TextureRect/Next/Next_Sprite.scale.y=1.28



