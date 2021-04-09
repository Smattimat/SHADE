extends Control


func activateLoad(var scene):
	var loading = get_tree().get_root().get_node("Menu").find_node("LoadingScreen")
	loading.loadScene(scene)

func _on_PrimUno_pressed():
	activateLoad("res://Levels/Level1T_Main.tscn")

func _on_PrimDue_pressed():
	activateLoad("res://Levels/Level2T_Main.tscn")


