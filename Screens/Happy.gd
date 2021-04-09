extends TouchScreenButton

var colNum=3

var Locked=preload("res://Asset/Player & Person/HappyL.png")
var UnLocked=preload("res://Asset/Player & Person/Cubo Happy.png")

func setLocked():
	self.normal=Locked
	self.set_block_signals(true)

func setUnlock():
	self.normal=UnLocked
	self.set_block_signals(false)
