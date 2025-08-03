extends Node

var loopNum: int = 0
var isPlayerDead: bool = false

var jumpLimit: int = 0
var dashTime: float = 0
var freezeTime: float = 0

var sfxVolume: float = 0
var musicVolume: float = 0

func SaveData():
	var file = FileAccess.open("GameData", FileAccess.WRITE)
	file.store_var(loopNum)
	file.store_var(isPlayerDead)
	
	file.store_var(jumpLimit)
	file.store_var(dashTime)
	file.store_var(freezeTime)
	
	file.store_var(sfxVolume)
	file.store_var(musicVolume)
	file.close()
	pass

func LoadData():
	if FileAccess.file_exists("GameData"):
		var file = FileAccess.open("GameData", FileAccess.READ)
		loopNum = file.get_var()
		isPlayerDead = file.get_var()
		
		jumpLimit = file.get_var()
		dashTime = file.get_var()
		freezeTime = file.get_var()
		
		sfxVolume = file.get_var()
		musicVolume = file.get_var()
		file.close()
	else:
		SaveData()
	pass

func ResetData():
	loopNum = 0
	isPlayerDead = false
	
	jumpLimit = 0
	dashTime = 0
	freezeTime = 0
	SaveData()
