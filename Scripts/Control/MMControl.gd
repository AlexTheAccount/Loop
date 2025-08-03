extends Control

var MMDLoad = load("uid://ds2tdse6btxsq")
var levelLoad = load("uid://d1kdwsejf8x15")
var creditsLoad = load("uid://c5ig66n7nijgc")

var startNode
var continueNode
var restartNode
var settingsNode
var creditsNode
var quitNode
var addedMMD
var clickPlayer
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.LoadData()
	startNode = get_node("Start")
	continueNode = get_node("Continue")
	restartNode = get_node("Restart")
	settingsNode = get_node("Settings")
	creditsNode = get_node("Credits")
	quitNode = get_node("Quit")
	clickPlayer = get_node("ClickPlayer")
	clickPlayer.volume_db = GlobalData.sfxVolume
	
	if GlobalData.loopNum > 0:
		startNode.disabled = true
	
	addedMMD = MMDLoad.instantiate()
	add_child(addedMMD)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ToggleAll():
	startNode.visible = not startNode.visible
	continueNode.visible = not continueNode.visible
	restartNode.visible = not restartNode.visible
	settingsNode.visible = not settingsNode.visible
	creditsNode.visible = not creditsNode.visible
	quitNode.visible = not quitNode.visible
	
	if GlobalData.loopNum > 0:
		startNode.disabled = true
	
	if addedMMD == null:
		addedMMD = MMDLoad.instantiate()
		add_child(addedMMD)

func _on_start_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	GlobalData.loopNum = 1
	GlobalData.SaveData()
	ToggleAll()
	addedMMD.queue_free()
	var addedLevel = levelLoad.instantiate()
	add_child(addedLevel)
	pass # Replace with function body.

func _on_continue_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	GlobalData.loopNum += 1
	GlobalData.isPlayerDead = false
	GlobalData.SaveData()
	ToggleAll()
	addedMMD.queue_free()
	var addedLevel = levelLoad.instantiate()
	add_child(addedLevel)
	pass # Replace with function body.


func _on_restart_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	GlobalData.ResetData()
	GlobalData.loopNum = 1
	GlobalData.SaveData()
	ToggleAll()
	addedMMD.queue_free()
	var addedLevel = levelLoad.instantiate()
	add_child(addedLevel)
	pass # Replace with function body.


func _on_settings_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	pass # Replace with function body.


func _on_credits_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	ToggleAll()
	var addedCredits = creditsLoad.instantiate()
	add_child(addedCredits)
	addedCredits.mainMenu = self
	pass # Replace with function body.


func _on_quit_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	get_tree().quit()
	pass # Replace with function body.
