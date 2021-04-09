extends TouchScreenButton



export var levelN = 1
export var Inf = false
export var Par=false

var lvlofseason

func _ready():
	var divis = levelN/5  
	lvlofseason = levelN-(divis*5)

var Uno=preload("res://Asset/Buttons/BTN1.png")
var UnoL=preload("res://Asset/Buttons/BTN1L.png")
var Due=preload("res://Asset/Buttons/BTN2.png")
var DueL=preload("res://Asset/Buttons/BTN2L.png")
var Tre=preload("res://Asset/Buttons/BTN3.png")
var TreL=preload("res://Asset/Buttons/BTN3L.png")
var Quattro=preload("res://Asset/Buttons/BTN4.png")
var QuattroL=preload("res://Asset/Buttons/BTN4L.png")
var Cinque=preload("res://Asset/Buttons/BTN5.png")
var CinqueL=preload("res://Asset/Buttons/BTN5L.png")


func setLocked():
	if(lvlofseason==1):
		self.normal=UnoL
	elif(lvlofseason==2):
		self.normal=DueL
	elif(lvlofseason==3):
		self.normal=TreL
	elif(lvlofseason==4):
		self.normal=QuattroL
	elif(lvlofseason==0):
		self.normal=CinqueL
	self.set_block_signals(true)
	
func setUnlocked():
	if(lvlofseason==1):
		self.normal=Uno
	elif(lvlofseason==2):
		self.normal=Due
	elif(lvlofseason==3):
		self.normal=Tre
	elif(lvlofseason==4):
		self.normal=Quattro
	elif(lvlofseason==0):
		self.normal=Cinque
	self.set_block_signals(false)
