extends TouchScreenButton

var colNum=7
var Locked=preload("res://Asset/Player & Person/DepreL.png")
var UnLocked=preload("res://Asset/Player & Person/Cubo Depre.png")

func setLocked():
	self.normal=Locked
	self.set_block_signals(true)

func setUnlock():
	self.normal=UnLocked
	self.set_block_signals(false)

