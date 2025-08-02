extends CharacterBody3D


var SPEED
var health

var healthBar
var freezeNode

var freezeLeft = 0

var rng = RandomNumberGenerator.new()
var player

func _ready():
	player = get_parent().get_parent().get_node("Player").get_child(0)
	SPEED = rng.randf_range(0.6, 0.9)
	if SPEED < 0:
		SPEED = -SPEED
	
	health = rng.randi_range(3, 6)
	healthBar = get_node("HealthBar")
	healthBar.mesh.size.x = health/2
	
	freezeNode = get_node("Freeze")

func _physics_process(delta):
	if freezeNode.visible == false:
		healthBar.look_at(player.global_position)
		healthBar.rotation.x = -90
		
		look_at(player.global_position)
		rotation.x = 0
		rotation.z = 0
		
		var direction = (player.global_position - global_position)
		velocity = direction * SPEED
		move_and_slide()
	else:
		freezeLeft -= delta
		
		if freezeLeft <= 0:
			freezeNode.visible = false

func Freeze():
	freezeNode.visible = true
	freezeLeft = GlobalData.freezeTime
	pass
