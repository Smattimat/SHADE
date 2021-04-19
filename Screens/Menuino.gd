extends Control

func _on_Resume_pressed():
 self.visible=false


func UpdateLanguage():
	if Settings.Language=="IT":
		$BlackOvelay/ColorRect/Label.text="MENU PAUSA"
	else:
		$BlackOvelay/ColorRect/Label.text="PAUSE MENU"


