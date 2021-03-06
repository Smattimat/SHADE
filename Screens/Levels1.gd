extends Control


func activateLoad(var scene):
	var loading = get_tree().get_root().get_node("Main").find_node("LoadingScreen")
	loading.loadScene(scene)
	self.visible=false

func _on_PrimUno_pressed():
	activateLoad("res://Levels/Level1T_Main.tscn")

func _on_PrimDue_pressed():
	activateLoad("res://Levels/Level2T_Main.tscn")

func _on_PrimTre_pressed():
	activateLoad("res://Levels/Level3Prim.tscn")

func _on_PrimQuattro_pressed():
	activateLoad("res://Levels/Level4Prim.tscn")

func _on_PrimCinque_pressed():
	activateLoad("res://Levels/Level5Prim.tscn")


func _on_EstUno_pressed():
	activateLoad("res://Levels/M_Level1Est.tscn")


func _on_EstDue_pressed():
	activateLoad("res://Levels/M_Level2Est.tscn")


func _on_EstTre_pressed():
	activateLoad("res://Levels/M_Level3Est.tscn")


func _on_EstQuattro_pressed():
	activateLoad("res://Levels/M_Level4Est.tscn")


func _on_EstCinque_pressed():
	activateLoad("res://Levels/M_Level5Est.tscn")
