extends Control

var JumpBoostsIconLoad = load("uid://6rt1dh4imclu")
var DashBoostsIconLoad = load("uid://x64iv16s0wlh")
var FreezeShotIconLoad = load("uid://db3exn288okc4")

var abilityNameNode
var iconsNode
var bookAreaNode
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	
	if bookAreaNode.is_in_group("Jump Boost"):
		abilityNameNode.text = "Jump Boosts"
		var addedJumpBoostsIcon = JumpBoostsIconLoad.instantiate()
		iconsNode.add_child(addedJumpBoostsIcon)
	elif bookAreaNode.is_in_group("Dash"):
		abilityNameNode.text = "Dash Boosts"
		var addedDashBoostsIcon = DashBoostsIconLoad.instantiate()
		iconsNode.add_child(addedDashBoostsIcon)
	elif bookAreaNode.is_in_group("Freeze Shot"):
		abilityNameNode.text = "Freeze Shot"
		var addedFreezeShotIcon = FreezeShotIconLoad.instantiate()
		iconsNode.add_child(addedFreezeShotIcon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_up() -> void:
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.
