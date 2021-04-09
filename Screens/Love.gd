extends TouchScreenButton

var colNum=6
var Locked=preload("res://Asset/Player & Person/LoveL.png")
var UnLocked=preload("res://Asset/Player & Person/Cubo Innamorato.png")

func setLocked():
	self.normal=Locked
	self.set_block_signals(true)

func setUnlock():
	self.normal=UnLocked
	self.set_block_signals(false)
