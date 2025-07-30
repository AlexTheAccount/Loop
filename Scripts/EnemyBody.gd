extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var player

func _ready():
	player = get_parent().get_parent().get_node("Player").get_child(0)
	
func _process(delta):
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()
