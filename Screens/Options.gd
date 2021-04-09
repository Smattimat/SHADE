extends Control



func _on_Back_pressed():
	emit_signal("gui_input")
	print("Backrequest")
