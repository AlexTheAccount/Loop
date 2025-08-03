extends Node3D

var headNode
var hatNode
var eyesNode
var PlayerLight

var blinkTimer = 0

var rng = RandomNumberGenerator.new()
var ranBlinkAmo

var orEyeScaY
var isBlinkTime = false
var isEndBlink = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	headNode = get_node("Head")
	hatNode = get_node("Hat")
	eyesNode = get_node("Eyes")
	PlayerLight = get_parent().get_node("PlayerLight")
	
	orEyeScaY = eyesNode.scale.y
	ranBlinkAmo = rng.randi_range(1, 10)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if name == "MenuPlayer" && GlobalData.isPlayerDead == true:
		PlayerLight.visible = false
		queue_free()
	elif name == "MenuDeadPlayer" && GlobalData.isPlayerDead == false:
		queue_free()
		
	if GlobalData.isPlayerDead == false:
		if isBlinkTime == false && isEndBlink == false:
			blinkTimer += delta
			if blinkTimer > ranBlinkAmo:
				isBlinkTime = true
		
		if isBlinkTime == true && isEndBlink == false:
			StartBlink()
		elif isBlinkTime == false && isEndBlink == true:
			EndBlink()
	pass

func StartBlink():
	if eyesNode.scale.y > 0.01:
		eyesNode.scale.y -= 0.01
	else:
		isBlinkTime = false
		isEndBlink = true
	pass
	
func EndBlink():
	if eyesNode.scale.y < orEyeScaY:
		eyesNode.scale.y += 0.01
	else:
		isEndBlink = false
		ranBlinkAmo = rng.randi_range(1, 10)
		blinkTimer = 0
	pass
