extends Control






func _on_GameOverScreen_visibility_changed():	
	get_tree().paused=true
	if Settings.Language=="IT":
		$BlackOverlay/ColorRect/Label2.text="Qualcuno e' morto.... forse a causa tua >:("
	else:
		$BlackOverlay/ColorRect/Label2.text="Someone is dead...and maybe it's fault >:("
