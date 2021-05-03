extends Node2D


#se troppo piccolo scalarlo in scena poi easy

export var DialogueNumber="Puno"
export var OneTime=true
export var NoSkip=false
export var NoMusicVideoBox=false
export var IsChoiceBased=false
export var ChoiceId=0

export var TutorialNote=false

var Used=false

func _ready():
	if TutorialNote==true and Settings.SkipTutorial==true:
		self.visible=false
	else:
		self.visible=true

func _on_Area_body_entered(body):
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
