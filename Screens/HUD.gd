extends Node


func _ready():	
	$ColorSelect.connect("renamed",self,"_On_selection")


func _On_selection(var col="Gray"):
	emit_signal("renamed",col)
	get_tree().paused=false
	$Box/Exit.visible=true
	$ColorSelect.visible=false
	$Box/Jump.visible=true
	$RightBox/Left.visible=true
	$RightBox/Right.visible=true
	$Box/Color2.visible=true
	
func _on_Exit_pressed():
	$Menuino.visible=true
	


func _on_Color2_pressed():
	$ColorSelect.visible=true
	get_tree().paused=true
	$Box/Exit.visible=false
	$Box/Jump.visible=false
	$RightBox/Left.visible=false
	$RightBox/Right.visible=false
	$Box/Color2.visible=false
