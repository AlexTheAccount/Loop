extends Control

var mainMenu
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_up() -> void:
	if mainMenu.clickPlayer.playing == false:
		mainMenu.clickPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
		mainMenu.clickPlayer.play()
		await mainMenu.clickPlayer.finished
	mainMenu.ToggleAll()
	queue_free()
	pass # Replace with function body.
