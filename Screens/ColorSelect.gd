extends Control


func ChoiceMade(var col):
	emit_signal("renamed",col)



func _on_Neutral_pressed():
	ChoiceMade("Gray")


func _on_Angry_pressed():
	ChoiceMade("Red")


func _on_Sad_pressed():
	ChoiceMade("Blue")


func _on_Happy_pressed():
	ChoiceMade("Green")


func _on_Love_pressed():
	ChoiceMade("Pink")


func _on_Empaty_pressed():
	ChoiceMade("Yellow")


func _on_Depre_pressed():
	ChoiceMade("Purple")
