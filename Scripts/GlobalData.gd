extends Node

var loopNum: int = 0
var jumpLimit: int = 0
var dashTime: float = 0
var isPlayerDead: bool = false

func SaveData():
	var file = FileAccess.open("GameData", FileAccess.WRITE)
	file.store_var(loopNum)
	file.store_var(jumpLimit)
	file.store_var(dashTime)
	file.store_var(isPlayerDead)
	file.close()
	pass

func LoadData():
	if FileAccess.file_exists("GameData"):
		var file = FileAccess.open("GameData", FileAccess.READ)
		loopNum = file.get_var()
		jumpLimit = file.get_var()
		dashTime = file.get_var()
		isPlayerDead = file.get_var()
		file.close()
	else:
		SaveData()
	pass

func ResetData():
	loopNum = 0
	jumpLimit = 0
	dashTime = 0
	isPlayerDead = false
	SaveData()
