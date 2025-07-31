extends CharacterBody3D


const SPEED = 0.5
const JUMP_VELOCITY = 4.5

var player

func _ready():
	player = get_parent().get_parent().get_node("Player").get_child(0)
	
func _process(delta):
	look_at(player.global_position)
	rotation.x = 0
	rotation.z = 0
	
	var direction = (player.global_position - global_position)
	velocity = direction * SPEED
	move_and_slide()
