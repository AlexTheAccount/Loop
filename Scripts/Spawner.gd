extends Area3D

var enemiesLoad = load("uid://ddy8i5cbnnvgs")
var bossesLoad = load("uid://c1210ia4d5lb5")

var spawnerHumPlayer
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnerHumPlayer = get_node("SpawnerHumPlayer3D")
	spawnerHumPlayer.volume_db = GlobalData.sfxVolume
	spawnerHumPlayer.pitch_scale = rng.randf_range(0.8, 1.2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		spawnerHumPlayer.play()
		var children = get_children()
		for child in children:
			if child.name != "SpawnerShape" && child.name != "SpawnerHumPlayer3D":
				if is_in_group("Enemies"):
					var addedEnemies = enemiesLoad.instantiate()
					addedEnemies.global_position = child.global_position
					get_parent().add_child(addedEnemies)
				if is_in_group("Bosses"):
					var addedBosses = bossesLoad.instantiate()
					addedBosses.global_position = child.global_position
					get_parent().add_child(addedBosses)
	pass # Replace with function body.
