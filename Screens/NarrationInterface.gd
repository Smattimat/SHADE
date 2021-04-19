extends Control

var DNumber=1
var Dindex="1"

var NoSkip
var NoMusic

var IsChoiceBased
var ChoicePath

var Dialogue

func _ready():
	$VideoBox.connect("gui_input",self,"_on_next_step")
	$DialogueBox.connect("gui_input",self,"_on_next_step")
	$Choice/BlackOverlay/TextureRect/Hell.connect("pressed",self,"_on_next_step")
	$Choice/BlackOverlay/TextureRect/Paradise.connect("pressed",self,"_on_next_step")
	$ImageBox/TextureRect/Next.connect("pressed",self,"_on_next_step")
	$DialogueBox/Exit.connect("pressed",self,"_on_exit_narration")

func _on_exit_narration():
	self.visible = false
	var Right = get_tree().get_root().get_node("Main").find_node("Right")
	var Left = get_tree().get_root().get_node("Main").find_node("Left")
	var Jump = get_tree().get_root().get_node("Main").find_node("Jump")
	var Color2 = get_tree().get_root().get_node("Main").find_node("Color2")
	Right.visible=true
	Left.visible=true
	Jump.visible=true
	Color2.visible=true
	var Commands = get_tree().get_root().get_node("Main").find_node("LevelCommands")
	Commands.reapplytoHUD()
	

func Start(var N,var NS,NM,CB,CP):	
	NoSkip=NS
	NoMusic=NM
	IsChoiceBased=CB
	ChoicePath=CP
	
	Dindex="1"
	var D : Dictionary=_load(N)		
	Dialogue=D	
	if(Dialogue[Dindex].type=="dialogue"):
		$Choice.visible=false
		$VideoBox.visible=false
		$DialogueBox.visible=true
		$ImageBox.visible=false
		var FilePath="res://Dialogue/Sprites/"+Dialogue[Dindex].name+"/"+Dialogue[Dindex].Face+".png"
		$DialogueBox.display(Dialogue[Dindex].Text,load(FilePath),NoSkip)
	elif(Dialogue[Dindex].type=="choice"):
		$Choice.visible=true
		$VideoBox.visible=false
		$DialogueBox.visible=false
		$ImageBox.visible=false
		$Choice.display(Dialogue[Dindex].Text,Dialogue[Dindex].good,Dialogue[Dindex].bad,Dialogue[Dindex].id)
	elif(Dialogue[Dindex].type=="video"):
		$Choice.visible=false
		$VideoBox.visible=true
		$DialogueBox.visible=false
		$ImageBox.visible=false
		$VideoBox.display(Dialogue[Dindex].name,NoSkip,NoMusic)
	elif(Dialogue[Dindex].type=="image"):
		$ImageBox.visible=true
		$Choice.visible=false
		$VideoBox.visible=false
		$DialogueBox.visible=false
		$ImageBox.display(Dialogue[Dindex].name,NoSkip)
	

func _load(var N):
	var P = get_tree().get_root().get_node("Main").find_node("Player")
	DNumber=N
	var FilePath
	if IsChoiceBased==true:
		FilePath="res://Dialogue/"+str(P.LevelAt)+Settings.Language+"/"+str(N)+ChoicePath+".json"
	else:
		FilePath="res://Dialogue/"+str(P.LevelAt)+Settings.Language+"/"+str(N)+".json"
	var file = File.new()
	file.open(FilePath,File.READ)	
	var Dialogue = parse_json(file.get_as_text())
	return Dialogue

func _on_next_step():
	var app=int(Dindex)
	app+=1
	Dindex=str(app)
	if(Dialogue.has(Dindex)):
		if(Dialogue[Dindex].type=="dialogue"):
			$Choice.visible=false
			$VideoBox.visible=false
			$DialogueBox.visible=true
			$ImageBox.visible=false
			var FilePath="res://Dialogue/Sprites/"+Dialogue[Dindex].name+"/"+Dialogue[Dindex].Face+".png"
			$DialogueBox.display(Dialogue[Dindex].Text,load(FilePath),NoSkip)
		elif(Dialogue[Dindex].type=="choice"):
			$Choice.visible=true
			$VideoBox.visible=false
			$DialogueBox.visible=false
			$ImageBox.visible=false
			$Choice.display(Dialogue[Dindex].Text,Dialogue[Dindex].good,Dialogue[Dindex].bad,Dialogue[Dindex].id)
		elif(Dialogue[Dindex].type=="video"):
			$Choice.visible=false
			$VideoBox.visible=true
			$DialogueBox.visible=false
			$ImageBox.visible=false
			$VideoBox.display(Dialogue[Dindex].name,NoSkip,NoMusic)
		elif(Dialogue[Dindex].type=="image"):
			$ImageBox.visible=true
			$Choice.visible=false
			$VideoBox.visible=false
			$DialogueBox.visible=false
			$ImageBox.display(Dialogue[Dindex].name,NoSkip)
			
	else:
		_on_exit_narration()
