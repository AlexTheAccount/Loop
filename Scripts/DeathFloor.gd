extends Node3D

var playerNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerNode = get_parent().get_node("Player").get_child(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = playerNode.global_position.x
	global_position.z = playerNode.global_position.z
	pass
