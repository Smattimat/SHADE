extends Control

func activateLoad(var scene):
	var loading = get_tree().get_root().get_node("Main").find_node("LoadingScreen")
	loading.loadScene(scene)
	self.visible=false
