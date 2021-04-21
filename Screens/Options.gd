extends Control

var UK_B=preload("res://Asset/Icons/UK-B.png")
var UK=preload("res://Asset/Icons/UK.png")
var IT_B=preload("res://Asset/Icons/IT-B.png")
var IT=preload("res://Asset/Icons/IT.png")


func _ready():
	Settings.load_Options()
	$Music_Slider.value=Settings.Music_Volume
	UpdateLanguage()

func _on_Back_pressed():
	emit_signal("gui_input")
	Settings.save_Options()

func UpdateLanguage():
	if Settings.Language=="IT":
		$LUK.normal=UK_B
		$LIT.normal=IT
		$LLanguage.text="Lingua"
		$LMusic.text="Musica"
	else:
		$LUK.normal=UK
		$LIT.normal=IT_B
		$LLanguage.text="Language"
		$LMusic.text="Music"
		


func _on_LIT_pressed():
	$LUK.normal=UK_B
	$LIT.normal=IT
	Settings.Language="IT"
	Settings.save_Options()
	UpdateLanguage()


func _on_LUK_pressed():
	$LUK.normal=UK
	$LIT.normal=IT_B
	Settings.Language="UK"
	Settings.save_Options()
	UpdateLanguage()


func _on_Music_UP_pressed():
	$Music_Slider.value=$Music_Slider.value+1
	Settings.Music_Volume=$Music_Slider.value
	


func _on_Music_Down_pressed():
	$Music_Slider.value=$Music_Slider.value-1
	Settings.Music_Volume=$Music_Slider.value

