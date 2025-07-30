extends Control

var levelLoad = load("res://PackedScenes/Level.tscn")

var startNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startNode = get_node("Start");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	startNode.visible = false;
	var addedLevel = levelLoad.instantiate()
	add_child(addedLevel)
	pass # Replace with function body.
