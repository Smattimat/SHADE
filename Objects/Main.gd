extends Node

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

var GoodCount=0
var BadCount=0

func _ready():
	$Player/Canvas/HUD/RightBox/Left.connect("pressed",self,"on_left")
	$Player/Canvas/HUD/RightBox/Left.connect("released",self,"not_on_left")
	$Player/Canvas/HUD/Box/Jump.connect("pressed",self,"on_jump")
	$Player/Canvas/HUD/Box/Jump.connect("released",self,"not_on_jump")
	$Player/Canvas/HUD/RightBox/Right.connect("pressed",self,"on_right")
	$Player/Canvas/HUD/RightBox/Right.connect("released",self,"not_on_right")
	$Player/Canvas/HUD.connect("renamed",self,"on_color")
	$Player/Canvas/HUD/Box/Exit.connect("pressed",self,"on_exit")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Resume.connect("pressed",self,"on_resume")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/ToMenu.connect("pressed",self,"on_toMenu")
	$Player/Canvas/HUD/GameOverScreen/BlackOverlay/ColorRect/ToMenu.connect("pressed",self,"on_toMenu")
	$Player/Canvas/HUD/GameOverScreen/BlackOverlay/ColorRect/Retry.connect("pressed",self,"on_toRetry")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Retry.connect("pressed",self,"on_toRetry")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Options.connect("pressed",self,"on_Options")
	$Player/Canvas/HUD/Options/Back.connect("pressed",self,"Exit_Options")
	$LevelMusic.play()
	var i=0
	while i<ChoiceN:
		var c = Choice.new()
		c.Good=false
		c.ID=i
		ChoicesArray.append(c)
		i=i+1
		
func Exit_Options():
	$Player/Canvas/HUD/Menuino.visible=true
	$Player/Canvas/HUD/Options.visible=false
	$Player/Canvas/HUD/Menuino.UpdateLanguage()
		
func on_Options():
	$Player/Canvas/HUD/Menuino.visible=false
	$Player/Canvas/HUD/Options.visible=true
	

func on_toRetry():
	get_tree().paused=false
	get_tree().change_scene(CurrentScene)
	
func on_toMenu():
	get_tree().paused=false
	get_tree().change_scene("res://Screens/Menu.tscn")

func on_exit():
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
	#print(Performance.get_monitor(Performance.TIME_FPS))
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
		var diffx=(pp.position.x+pp.get_node("KPerson").position.x)-$Player.position.x
		var diffY=(pp.position.y+pp.get_node("KPerson").position.y)-$Player.position.y
		if diffx<0: 
			diffx=diffx*-1
		if diffY<0: 
			diffY=diffY*-1			
		if diffx<608:
			if diffY<330:
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




