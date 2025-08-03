extends Control

var clickPlayer
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	clickPlayer = get_node("ClickPlayer")
	clickPlayer.volume_db = GlobalData.sfxVolume
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_button_up() -> void:
	if clickPlayer.playing == false:
		clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		clickPlayer.play()
		await clickPlayer.finished
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
