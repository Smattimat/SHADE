extends Control

var ChoiceID

func display(var text,var good,var bad,var id):
	$BlackOverlay/TextureRect/RichTextLabel.text=text
	$BlackOverlay/TextureRect/Hell/hLabel.text=bad
	$BlackOverlay/TextureRect/Paradise/PLabel.text=good
	ChoiceID=id
	


func _on_Paradise_pressed():
	var Main = get_tree().get_root().get_node("Main")
	Main.ChoicesArray[int(ChoiceID)].Good=true
	Main.GoodCount=Main.GoodCount+1
	


func _on_Hell_pressed():
	var Main = get_tree().get_root().get_node("Main")
	Main.ChoicesArray[int(ChoiceID)].Good=false
	Main.BadCount=Main.BadCount+1
