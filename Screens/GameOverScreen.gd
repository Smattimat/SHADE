extends Control

func _ready():
	$LoadingScreen.visible=false

func _on_GameOverScreen_visibility_changed():
	$LoadingScreen.visible=false
	$BlackOverlay/ColorRect/Retry.set_block_signals(false)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(false)
	get_tree().paused=true
	if Settings.Language=="IT":
		$BlackOverlay/ColorRect/Label2.text="Qualcuno e' morto.... forse a causa tua >:("
	else:
		$BlackOverlay/ColorRect/Label2.text="Someone is dead...and maybe it's fault >:("

func _on_Retry_pressed():
	var main = get_tree().get_root().get_node("Main")
	$LoadingScreen.loadScene(main.CurrentScene)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(true)
	$BlackOverlay/ColorRect/Retry.set_block_signals(true)


func _on_ToMenu_pressed():
	$LoadingScreen.loadScene("res://Screens/Menu.tscn")
	$BlackOverlay/ColorRect/Retry.set_block_signals(true)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(true)
