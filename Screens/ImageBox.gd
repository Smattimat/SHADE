extends Control


func display(var name,var NS,LangDep):	
	self.visible=true
	if LangDep=="true":
		$TextureRect/ShownImage.texture=load("res://Dialogue/Images"+Settings.Language+"/"+name)
	else:
		$TextureRect/ShownImage.texture=load("res://Dialogue/Images"+"Common"+"/"+name)
	$TextureRect/AnimationPlayer.play("Next Hopp")





func _on_Next_pressed():	
	$TextureRect/AnimationPlayer.stop()
	$TextureRect/Next/Next_Sprite.scale.y=1.28



