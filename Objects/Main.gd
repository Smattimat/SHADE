extends Node

var CheckPoint_File= "user://Check.save"

export(String,FILE,"*.tscn")var CurrentScene

var Right=false
var Left=false
var Jump=false

var WasDialogue = false
var WasColorChange=false
var WasPaused=false

export var ChoiceN=0

class Choice:
	var Good: bool
	var ID: int
	
var ChoicesArray=[]
var CheckAt=0

var GoodCount=0
var BadCount=0

func UpdateVolume():
	if(Settings.Music_Volume==0):
		$LevelMusic.volume_db=-80
	else:
		$LevelMusic.volume_db=(Settings.Music_Volume*5)-35

func _ready():
	$Player/Canvas/HUD/Vignettatura.visible=true
	$Player/Canvas/HUD/RightBox/Left.connect("pressed",self,"on_left")
	$Player/Canvas/HUD/RightBox/Left.connect("released",self,"not_on_left")
	$Player/Canvas/HUD/Box/Jump.connect("pressed",self,"on_jump")
	$Player/Canvas/HUD/Box/Jump.connect("released",self,"not_on_jump")
	$Player/Canvas/HUD/RightBox/Right.connect("pressed",self,"on_right")
	$Player/Canvas/HUD/RightBox/Right.connect("released",self,"not_on_right")
	$Player/Canvas/HUD.connect("renamed",self,"on_color")
	$Player/Canvas/HUD/Box/Exit.connect("pressed",self,"on_exit")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Resume.connect("pressed",self,"on_resume")	
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Options.connect("pressed",self,"on_Options")
	$Player/Canvas/HUD/Options/Back.connect("pressed",self,"Exit_Options")
	UpdateVolume()
	$LevelMusic.play()
	#carica Checkpoint
	var f = File.new()
	if f.file_exists(CheckPoint_File):
		f.open(CheckPoint_File,File.READ)
		CheckAt=f.get_var()		
		f.close()
		if CheckAt!=0:
			UpdateCheck()
	#imposta il layout
	if(Settings.InvLayout==true):
		$Player/Canvas/HUD/Box/Jump.position=Vector2(1120 ,704)
		$Player/Canvas/HUD/Box/Color2.position=Vector2(1152,416)
		$Player/Canvas/HUD/RightBox/Left.position=Vector2(-672,544)
		$Player/Canvas/HUD/RightBox/Right.position=Vector2(-480,544)
	else:
		$Player/Canvas/HUD/Box/Jump.position=Vector2(0 ,704)
		$Player/Canvas/HUD/Box/Color2.position=Vector2(32,416)
		$Player/Canvas/HUD/RightBox/Left.position=Vector2(128,544)
		$Player/Canvas/HUD/RightBox/Right.position=Vector2(320,544)
	#imposta suggerienti tutorial
	var Hints = get_tree().get_nodes_in_group("Hints")
	if(Settings.SkipTutorial==true):
		for h in Hints:
			h.visible=false
	else:
		for h in Hints:
			h.visible=true		

	var i=0
	while i<ChoiceN:
		var c = Choice.new()
		c.Good=false
		c.ID=i
		ChoicesArray.append(c)
		i=i+1
		
		
	
		
func UpdateCheck():
	if(CheckAt!=0):	
		print(CheckAt)
		var Checks=get_tree().get_nodes_in_group("Checks")
		for c in Checks:
			if c.Id==CheckAt:
				$Player.position=c.position
				break
			
			
func Exit_Options():
	$Player/Canvas/HUD/Menuino.visible=true
	$Player/Canvas/HUD/Options.visible=false
	$Player/Canvas/HUD/Menuino.UpdateLanguage()
	#aggiorna il layout
	if(Settings.InvLayout==true):
		$Player/Canvas/HUD/Box/Jump.position=Vector2(1120 ,704)
		$Player/Canvas/HUD/Box/Color2.position=Vector2(1152,416)
		$Player/Canvas/HUD/RightBox/Left.position=Vector2(-672,544)
		$Player/Canvas/HUD/RightBox/Right.position=Vector2(-480,544)
	else:
		$Player/Canvas/HUD/Box/Jump.position=Vector2(0 ,704)
		$Player/Canvas/HUD/Box/Color2.position=Vector2(32,416)
		$Player/Canvas/HUD/RightBox/Left.position=Vector2(128,544)
		$Player/Canvas/HUD/RightBox/Right.position=Vector2(320,544)
	#aggiorna i suggerimenti tutorial
	var Hints = get_tree().get_nodes_in_group("Hints")
	if(Settings.SkipTutorial==true):
		for h in Hints:
			h.visible=false
	else:
		for h in Hints:
			h.visible=true		
	UpdateVolume()
		
func on_Options():
	$Player/Canvas/HUD/Menuino.visible=false
	$Player/Canvas/HUD/Options.visible=true
	

func on_exit():
	$Player/Canvas/HUD/Box.visible=false
	$Player/Canvas/HUD/RightBox.visible=false
	
	$Player/Canvas/HUD/Menuino.UpdateLanguage()
	if get_tree().paused==true:
		WasPaused=true
	else:
		WasPaused=false
	get_tree().paused=true
	if $Player/Canvas/HUD/NarrationInterface.visible==true:
		$Player/Canvas/HUD/NarrationInterface.visible=false
		WasDialogue=true
	else:
		WasDialogue=false
	if $Player/Canvas/HUD/ColorSelect.visible==true:
		$Player/Canvas/HUD/ColorSelect.visible=false
		WasColorChange=true
	else:
		WasColorChange=false
		
	
	
func on_resume():
	$Player/Canvas/HUD/Box.visible=true
	$Player/Canvas/HUD/RightBox.visible=true
	if WasPaused==true:
		get_tree().paused=true
	else:
		get_tree().paused=false
	if WasDialogue==true:
		$Player/Canvas/HUD/NarrationInterface.visible=true
	if WasColorChange==true:
		$Player/Canvas/HUD/ColorSelect.visible=true

func not_on_right():
	Right=false

func on_right():
	Right=true

func not_on_left():
	Left=false

func on_left():
	Left=true
	
func not_on_jump():
	Jump=false
	
func on_jump():
	Jump=true
	
	
func on_color(var col="Gray"):
	$Player.UpdateColor(col)
	
	
	
func _process(delta):
	#print(Performance.get_monitor(Performance.TIME_FPS)) #print fps
	#if Input.is_action_pressed("ui_right"):
	#	Right=true
	#else:
	#	Right=false
	#if Input.is_action_pressed("ui_left"):
	#	Left=true
	#else:
	#	Left=false
	#if Input.is_action_pressed("ui_up"):
	#	Jump=true	
	#else:
	#	Jump=false
	#test 
	var colorP = $Player.colorazion
	var LevelPeople=get_tree().get_nodes_in_group("People")
	$Player.MovePlayer(Left,Right,Jump)
	for pp in LevelPeople:
		var diffx=pp.position.x-$Player.position.x
		var diffY=pp.position.y-$Player.position.y
		if diffx<0: 
			diffx=diffx*-1
		if diffY<0: 
			diffY=diffY*-1			
		if diffx<616:
			if diffY<360:
				if(pp.colorazion==colorP):
					pp.ImitatePlayer(true,Left,Right,Jump)
				else:
					pp.ImitatePlayer(false,false,false,false)
			else:
				pp.ImitatePlayer(false,false,false,false)
		else:
			pp.ImitatePlayer(false,false,false,false)
	
	var Passaggi=get_tree().get_nodes_in_group("Passages")
	var PressurePlates=get_tree().get_nodes_in_group("Plates")
	for pl in PressurePlates:
			if pl.differentstate==true:
				pl.differentstate=false
				if pl.Pressed==true:
					for pas in Passaggi:
						if pas.ID==pl.ID:
							pas.Open();
				else:
					for pas in Passaggi:
						if pas.ID==pl.ID:
							pas.Close();
	
	var KPassaggi=get_tree().get_nodes_in_group("KPassages")
	var KToppe=get_tree().get_nodes_in_group("Kholes")
	for kp in KPassaggi:
		kp.Resett()
		for kt in KToppe:
			if kp.Id == kt.Id:
				if kt.Holehaskey==true:
					kp.CountUp()
		kp.Update()




