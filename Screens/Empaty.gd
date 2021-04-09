extends TouchScreenButton

var colNum=5
var Locked=preload("res://Asset/Player & Person/EmpathyL.png")
var UnLocked=preload("res://Asset/Player & Person/Cubo Empatico.png")

func setLocked():
	self.normal=Locked
	self.set_block_signals(true)

func setUnlock():
	self.normal=UnLocked
	self.set_block_signals(false)
