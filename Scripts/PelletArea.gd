extends Area3D

var speed = 50
var qTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z -= speed * delta
	
	qTimer += delta
	if qTimer > 3:
		get_parent().queue_free()
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemies"):
		body.healthBar.visible = true
		body.healthBar.mesh.size.x -= 0.1
		body.health -= 0.1
		if body.healthBar.mesh.size.x <= 0:
			body.get_parent().queue_free()
		
		if GlobalData.freezeTime > 0:
			body.Freeze()
		
		get_parent().queue_free()
		
	if body.is_in_group("Bosses"):
		body.healthRect.size.x -= 24
		body.healthRect.position.x += 12
		if body.healthRect.size.x <= 0:
			body.healthBar.get_child(0).text = "AN ENDLESS LOOP!"
			body.SPEED += 0.1
		
		if GlobalData.freezeTime > 0:
			body.Freeze()
		
		get_parent().queue_free()
	pass # Replace with function body.
