extends Node

var loopNum = 0
var isPlayerDead = false

func SaveData():
	var file = FileAccess.open("GameData", FileAccess.WRITE)
	file.store_var(loopNum)
	file.store_var(isPlayerDead)
	file.close()
	pass

func LoadData():
	if FileAccess.file_exists("GameData"):
		var file = FileAccess.open("GameData", FileAccess.READ)
		loopNum = file.get_var()
		isPlayerDead = file.get_var()
		file.close()
	else:
		SaveData()
	pass
