extends Area3D

var enemiesLoad = load("uid://ddy8i5cbnnvgs")
var bossesLoad = load("uid://c1210ia4d5lb5")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		var children = get_children()
		for child in children:
			if child.name != "SpawnerShape":
				if is_in_group("Enemies"):
					var addedEnemies = enemiesLoad.instantiate()
					addedEnemies.global_position = child.global_position
					get_parent().add_child(addedEnemies)
				if is_in_group("Bosses"):
					var addedBosses = bossesLoad.instantiate()
					addedBosses.global_position = child.global_position
					get_parent().add_child(addedBosses)
	pass # Replace with function body.
