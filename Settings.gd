extends Node

var Level_File= "user://Level.save"

var GameLevelAt=20
var ParLevelAt=0
var InfLevelAt=0


var GoodCount=0
var BadCount=0

func save_Level():
	var f = File.new()
	f.open(Level_File,File.WRITE)
	f.store_var(GameLevelAt)
	f.store_var(ParLevelAt)
	f.store_var(InfLevelAt)	
	f.store_var(GoodCount)	
	f.store_var(BadCount)	
	f.close()

func load_Level():
	var f = File.new()
	if f.file_exists(Level_File):
		f.open(Level_File,File.READ)
		GameLevelAt=f.get_var()
		ParLevelAt=f.get_var()
		InfLevelAt=f.get_var()
		GoodCount=f.get_var()
		BadCount=f.get_var()
		f.close()