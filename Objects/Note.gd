extends Node2D



const IDLE_DURATION=0

export var move_to = Vector2.RIGHT*0
export var speed = 3.0

export var DialogueNumber="PUno"
export var OneTime=false
export var NoSkip=false
export var NoMusicVideoBox=false
export var IsChoiceBased=false
export var ChoiceId=0
export var TutorialNote=false
var Used=false

var follow = Vector2.ZERO

onready var Note = $NoteArea
onready var tween = $MoveTween

func _ready():
	if TutorialNote==true and Settings.SkipTutorial==true:
		self.visible=false
	else:
		self.visible=true
	_init_tween()

func _init_tween():
	var duration = move_to.length()/float(speed*32)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT,IDLE_DURATION*2+duration)
	tween.start()

func _physics_process(delta):
	Note.position = Note.position.linear_interpolate(follow,0.075)


func _on_NoteArea_body_entered(body):
	if TutorialNote==false or Settings.SkipTutorial==false:
		if body.name == "Player":
			if OneTime==true and Used==true:
				pass
			else:
				var Dialogue = get_tree().get_root().get_node("Main").find_node("NarrationInterface")
				Dialogue.visible = true
				if IsChoiceBased==true:
					var Main = get_tree().get_root().get_node("Main")
					var c=Main.ChoicesArray[ChoiceId]
					if c.Good==true:
						Dialogue.Start(DialogueNumber,NoSkip,NoMusicVideoBox,IsChoiceBased,"Good")
					else:
						Dialogue.Start(DialogueNumber,NoSkip,NoMusicVideoBox,IsChoiceBased,"Bad")	
				else:			
					Dialogue.Start(DialogueNumber,NoSkip,NoMusicVideoBox,IsChoiceBased,"a")
				var Right = get_tree().get_root().get_node("Main").find_node("Right")
				var Left = get_tree().get_root().get_node("Main").find_node("Left")
				var Jump = get_tree().get_root().get_node("Main").find_node("Jump")
				var Color2 = get_tree().get_root().get_node("Main").find_node("Color2")
				Right.visible=false
				Left.visible=false
				Jump.visible=false
				Color2.visible=false
			Used=true


