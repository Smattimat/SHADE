extends TouchScreenButton

var colNum=4
var Locked=preload("res://Asset/Player & Person/SadL.png")
var UnLocked=preload("res://Asset/Player & Person/Cubo triste sketch style gg copy.png")

func setLocked():
	self.normal=Locked
	self.set_block_signals(true)

func setUnlock():
	self.normal=UnLocked
	self.set_block_signals(false)
