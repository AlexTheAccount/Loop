extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var pelletLoad = load("uid://6p3xnxkixoqb")

var mainMenuNode
var camera
var playerShape

func _ready():
	mainMenuNode = get_tree().root.get_node("Main Menu")
	playerShape = get_node("CollisionShape3D")
	camera = get_node("Camera3D")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	# for shooting pellets
	if event.is_action_pressed("Fire"):
		SpawnPellet()
	
	# for player mouse rotation
	if event is InputEventMouseMotion:
		AlignPlayerWithMouse()

func SpawnPellet():
	var pelletInsta = pelletLoad.instantiate() 
	pelletInsta.position = playerShape.global_position
	pelletInsta.rotation = playerShape.global_rotation
	get_parent().get_parent().add_child(pelletInsta)

func AlignPlayerWithMouse():
	var space_state = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var rayStart = camera.project_ray_origin(mousePos)
	var rayEnd = rayStart + camera.project_ray_normal(mousePos) * 1000
	var query = PhysicsRayQueryParameters3D.create(rayStart, rayEnd)
	query.collide_with_areas = true
	query.set_collision_mask(128)
	
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		playerShape.look_at(intersection.position)
		playerShape.rotation.x = 0
		playerShape.rotation.z = 0


func _on_player_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		mainMenuNode.ToggleAll()
		GlobalData.isPlayerDead = true
		GlobalData.SaveData()
		get_parent().get_parent().queue_free()
	pass # Replace with function body.


func _on_player_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Books"):
		if area.is_in_group("Double Jump"):
			pass
		elif area.is_in_group("Dash"):
			pass
		elif area.is_in_group("Freeze Shot"):
			pass
		area.get_parent().queue_free()
	pass # Replace with function body.
