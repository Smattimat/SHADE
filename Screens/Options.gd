extends Control

var UK_B=preload("res://Asset/Icons/UK-B.png")
var UK=preload("res://Asset/Icons/UK.png")
var IT_B=preload("res://Asset/Icons/IT-B.png")
var IT=preload("res://Asset/Icons/IT.png")

var Checked=preload("res://Asset/Buttons/BTNChecksi.png")
var UnChecked=preload("res://Asset/Buttons/BTNCheckno.png")

func _ready():
	Settings.load_Options()
	$Music_Slider.value=Settings.Music_Volume
	if(Settings.SkipTutorial==true):
		$Skip_T.normal=Checked
	else:
		$Skip_T.normal=UnChecked
	if(Settings.Particle==true):
		$Particles.normal=Checked
	else:
		$Particles.normal=UnChecked
	if(Settings.InvLayout==true):
		$Layout.normal=Checked
	else:
		$Layout.normal=UnChecked
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
		$LTutorial.text="Salta Tutorial"
		$LParticelle.text="Particelle"
		$LinvertLay.text="Inverti Comandi"
	else:
		$LUK.normal=UK
		$LIT.normal=IT_B
		$LLanguage.text="Language"
		$LMusic.text="Music"
		$LTutorial.text="Skip Tutorial"
		$LParticelle.text="Particles"
		$LinvertLay.text="Invert Layout"
		


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
	var LevelMusic = get_tree().get_root().get_node("Main").find_node("LevelMusic")
	if(Settings.Music_Volume==0):
		LevelMusic.volume_db=-80
	else:
		LevelMusic.volume_db=int((Settings.Music_Volume*5)-35)

func _on_Music_Down_pressed():
	$Music_Slider.value=$Music_Slider.value-1
	Settings.Music_Volume=$Music_Slider.value
	var LevelMusic = get_tree().get_root().get_node("Main").find_node("LevelMusic")
	if(Settings.Music_Volume==0):
		LevelMusic.volume_db=-80
	else:
		LevelMusic.volume_db=int((Settings.Music_Volume*5)-35)

func _on_Skip_T_pressed():
	if(Settings.SkipTutorial==false):
		Settings.SkipTutorial=true
		$Skip_T.normal=Checked
	else:
		Settings.SkipTutorial=false
		$Skip_T.normal=UnChecked


func _on_Particles_pressed():
	if(Settings.Particle==false):
		Settings.Particle=true
		$Particles.normal=Checked
	else:
		Settings.Particle=false
		$Particles.normal=UnChecked


func _on_Layout_pressed():
	if(Settings.InvLayout==false):
		Settings.InvLayout=true
		$Layout.normal=Checked
	else:
		Settings.InvLayout=false
		$Layout.normal=UnChecked
