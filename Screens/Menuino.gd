extends Control

var CheckPoint_File= "user://Check.save"

func _on_Resume_pressed():
 self.visible=false
 


func UpdateLanguage():
	if Settings.Language=="IT":
		$BlackOvelay/ColorRect/Label.text="MENU PAUSA"
	else:
		$BlackOvelay/ColorRect/Label.text="PAUSE MENU"




func _on_Retry_pressed():
	if $BlackOvelay/ColorRect/ToMenu.visible==true:
		var main = get_tree().get_root().get_node("Main")
		var app = main.CheckAt	
		var f = File.new()
		f.open(CheckPoint_File,File.WRITE)
		f.store_var(app)	
		f.close()
		$LoadingScreen.loadScene(main.CurrentScene)
		$BlackOvelay/ColorRect/Resume.set_block_signals(true)
		$BlackOvelay/ColorRect/Retry.set_block_signals(true)
		$BlackOvelay/ColorRect/Options.set_block_signals(true)
		$BlackOvelay/ColorRect/ToMenu.set_block_signals(true)

func _on_ToMenu_pressed():
	$LoadingScreen.loadScene("res://Screens/Menu.tscn")
	$BlackOvelay/ColorRect/Resume.set_block_signals(true)
	$BlackOvelay/ColorRect/Retry.set_block_signals(true)
	$BlackOvelay/ColorRect/Options.set_block_signals(true)
	$BlackOvelay/ColorRect/ToMenu.set_block_signals(true)
	var f = File.new()
	f.open(CheckPoint_File,File.WRITE)
	f.store_var(0)	
	f.close()

func _on_Menuino_visibility_changed():
	$LoadingScreen.visible=false
	$BlackOvelay/ColorRect/Resume.set_block_signals(false)
	$BlackOvelay/ColorRect/Retry.set_block_signals(false)
	$BlackOvelay/ColorRect/Options.set_block_signals(false)
	$BlackOvelay/ColorRect/ToMenu.set_block_signals(false)
