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
	#easter command
	$Player/Camera2D.current=false
	$Player/Canvas/HUD/Box.visible=false
	$Player/Canvas/HUD/RightBox.visible=false
	$Player/Canvas/HUD/Menuino.visible=false
	$Player.position=$SpawnPointP.position
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/ToMenu.visible=false
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Options.visible=false
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect.rect_size.y=384
	
	
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
	$Player/Canvas/HUD/GameOverScreen/BlackOverlay/ColorRect/Retry.connect("pressed",self,"on_toRetry")
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Retry.connect("pressed",self,"on_toRetry")
	$LevelMusic.play()
	var i=0
	while i<ChoiceN:
		var c = Choice.new()
		c.Good=false
		c.ID=i
		ChoicesArray.append(c)
		i=i+1
		

func on_toRetry():
	get_tree().paused=false
	$Player.position=$SpawnPointP.position
	$Player/Canvas/HUD/Menuino.visible=false
	
	


func on_exit():
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


func ActivateLevel():
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/ToMenu.visible=false
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Options.visible=false
	$Player/Camera2D.current=true
	var Menucam = get_tree().get_root().get_node("Main").find_node("Menucam")
	var leveltwo = get_tree().get_root().get_node("Main").find_node("Levels2")
	var options = get_tree().get_root().get_node("Main").find_node("Options")
	Menucam.current=false
	options.visible=false
	leveltwo.visible=false
	$Player/Canvas/HUD/Box.visible=true
	$Player/Canvas/HUD/RightBox.visible=true
	$Player.position=$SpawnPointP.position
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect.rect_size.y=384
	var lvlBut=get_tree().get_nodes_in_group("LevelButtons")
	for but in lvlBut:
		but.set_block_signals(true)
	var ActBut=get_tree().get_nodes_in_group("ActButtons")
	for but in ActBut:
		but.set_block_signals(true)
	
func DeactivateLevel():
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/ToMenu.visible=true
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect/Options.visible=true
	$Player/Camera2D.current=false
	var Menucam = get_tree().get_root().get_node("Main").find_node("Menucam")
	Menucam.current=true
	var leveltwo = get_tree().get_root().get_node("Main").find_node("Levels2")
	var options = get_tree().get_root().get_node("Main").find_node("Options")
	options.visible=true
	leveltwo.visible=true
	$Player/Canvas/HUD/Box.visible=false
	$Player/Canvas/HUD/RightBox.visible=false
	$Player/Canvas/HUD/Menuino.visible=false
	$Player/Canvas/HUD/Menuino/BlackOvelay/ColorRect.rect_size.y=640
	var lvlBut=get_tree().get_nodes_in_group("LevelButtons")
	for but in lvlBut:
		but.set_block_signals(false)
	var ActBut=get_tree().get_nodes_in_group("ActButtons")
	for but in ActBut:
		but.set_block_signals(false)

	


func _on_CreditsButton_pressed():
	ActivateLevel()
