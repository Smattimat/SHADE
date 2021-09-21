extends Node

var CheckPoint_File= "user://Check.save"

func _ready():	
	#Settings.save_Level()  # per resettare opzioni a ogni avvio
	#Settings.save_Options()
	var f = File.new()
	f.open(CheckPoint_File,File.WRITE)
	f.store_var(0)
	f.close()
	pass

func _on_VideoPlayer_finished():
	_to_menu()
	
func _to_menu():
	$AnimationPlayer.play("Finish")
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Screens/Menu.tscn")


func _on_TouchScreenButton_pressed():
	_to_menu()
