extends CharacterBody3D


var SPEED = 0.5
var health = 12

var healthBar
var healthRect
var freezeNode

var freezeLeft = 0

var rng = RandomNumberGenerator.new()
var player

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player").get_child(0)
	
	healthBar = get_parent().get_node("BossUI")
	healthRect = healthBar.get_child(0).get_child(0)
	
	freezeNode = get_node("Freeze")

func _physics_process(delta):
	look_at(player.global_position)
	rotation.x = 0
	rotation.z = 0
	global_position.y = player.global_position.y
	
	var direction = (player.global_position - global_position)
	velocity = direction * SPEED
	move_and_slide()
	
	if freezeNode.visible == false:
		freezeLeft -= delta
		
		if freezeLeft <= 0:
			freezeNode.visible = false
			SPEED = 0.5

func Freeze():
	freezeNode.visible = true
	freezeLeft = GlobalData.freezeTime
	SPEED = 0.25
	pass
