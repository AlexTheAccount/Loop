extends CharacterBody3D

var SPEED = 5.0
const JUMP_VELOCITY = 4.5

var pauseLoad = load("uid://cgwpp6r4aqbmm")
var pelletLoad = load("uid://6p3xnxkixoqb")
var bookUILoad = load("uid://cds4kxtfn56wb")

var bookUIGD = load("uid://c0lcu5txdj6ry")

var mainMenuNode
var playerUI
var camera
var playerShape
var playerBlend
var playerDashingBlend
var playerArea

var jumpCount = 0
var dashLeft = GlobalData.dashTime
var shiftPressed = false

func _ready():
	mainMenuNode = get_tree().root.get_node("Main Menu")
	playerUI = get_node("PlayerUI")
	playerShape = get_node("CollisionShape3D")
	camera = get_node("Camera3D")
	playerUI.DashBar.visible = false
	
	playerBlend = get_node("CollisionShape3D/PlayerBlend")
	playerDashingBlend = get_node("CollisionShape3D/PlayerDashingBlend")
	playerArea = get_node("PlayerArea3D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var pauseInsta = pauseLoad.instantiate() 
		get_parent().get_parent().add_child(pauseInsta)
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() || Input.is_action_just_pressed("ui_accept") && jumpCount < GlobalData.jumpLimit:
		velocity.y = JUMP_VELOCITY
		jumpCount += 1
	if is_on_floor():
		jumpCount = 0
	
	# Handle Dash.
	if Input.is_action_just_pressed("Dash") && dashLeft > 0 || not Input.is_action_just_released("Dash") && shiftPressed == true && dashLeft > 0:
		playerArea.set_collision_mask_value(2, false) # 2 colides with enemies
		SPEED = 25
		dashLeft -= delta
		playerUI.DashBar.visible = true
		playerUI.DashRect.scale.x = dashLeft
		shiftPressed = true
		playerDashingBlend.visible = true
		playerBlend.visible = false
	if Input.is_action_just_released("Dash") || dashLeft < 0:
		playerArea.set_collision_mask_value(2, true) # 2 colides with enemies
		SPEED = 5
		shiftPressed = false
		playerDashingBlend.visible = false
		playerBlend.visible = true
	if dashLeft < GlobalData.dashTime && shiftPressed == false:
		dashLeft += 0.01
		playerUI.DashRect.scale.x = dashLeft
	elif dashLeft >= GlobalData.dashTime && shiftPressed == false:
		playerUI.DashBar.visible = false

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
	if area.is_in_group("Enemies"):
		mainMenuNode.ToggleAll()
		GlobalData.isPlayerDead = true
		GlobalData.SaveData()
		get_parent().get_parent().queue_free()
	
	if area.is_in_group("Books"):
		if area.is_in_group("Jump Boost"):
			GlobalData.jumpLimit += 1
			
			var bookUIInsta = bookUILoad.instantiate() 
			get_parent().get_parent().add_child(bookUIInsta)
			bookUIInsta.bookAreaNode = area
			bookUIInsta.CheckGroup()
		elif area.is_in_group("Dash"):
			GlobalData.dashTime += 0.1
			dashLeft = GlobalData.dashTime
			
			var bookUIInsta = bookUILoad.instantiate() 
			get_parent().get_parent().add_child(bookUIInsta)
			bookUIInsta.bookAreaNode = area
			bookUIInsta.CheckGroup()
		elif area.is_in_group("Freeze Shot"):
			GlobalData.freezeTime += 0.1
			
			var bookUIInsta = bookUILoad.instantiate() 
			get_parent().get_parent().add_child(bookUIInsta)
			bookUIInsta.bookAreaNode = area
			bookUIInsta.CheckGroup()
		GlobalData.SaveData()
		area.get_parent().queue_free()
	pass # Replace with function body.
