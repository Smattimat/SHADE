extends Control

var CheckPoint_File= "user://Check.save"

func _ready():
	$LoadingScreen.visible=false

func _on_GameOverScreen_visibility_changed():
	$LoadingScreen.visible=false
	$BlackOverlay/ColorRect/Retry.set_block_signals(false)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(false)
	var LevelMusic= get_tree().get_root().get_node("Main").find_node("LevelMusic")	
	LevelMusic.stop()
	$Music.play()
	var box= get_tree().get_root().get_node("Main").find_node("Box")	
	var rightbox= get_tree().get_root().get_node("Main").find_node("RightBox")	
	box.visible=false
	rightbox.visible=false
	get_tree().paused=true
	if Settings.Language=="IT":
		$BlackOverlay/ColorRect/Label2.text="Qualcuno e'morto...forse a causa tua >:("
	else:
		$BlackOverlay/ColorRect/Label2.text="Someone died...maybe it's your fault >:("

func _on_Retry_pressed():
	var main = get_tree().get_root().get_node("Main")
	var app = main.CheckAt
	var f = File.new()
	f.open(CheckPoint_File,File.WRITE)
	f.store_var(app)	
	f.close()
	$LoadingScreen.loadScene(main.CurrentScene)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(true)
	$BlackOverlay/ColorRect/Retry.set_block_signals(true)


func _on_ToMenu_pressed():
	$LoadingScreen.loadScene("res://Screens/Menu.tscn")
	$BlackOverlay/ColorRect/Retry.set_block_signals(true)
	$BlackOverlay/ColorRect/ToMenu.set_block_signals(true)
	var f = File.new()
	f.open(CheckPoint_File,File.WRITE)
	f.store_var(0)	
	f.close()
