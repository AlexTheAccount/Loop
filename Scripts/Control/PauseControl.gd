extends Control

var JumpBoostsIconLoad = load("uid://6rt1dh4imclu")
var DashBoostsIconLoad = load("uid://x64iv16s0wlh")
var FreezeShotIconLoad = load("uid://db3exn288okc4")

var abilityScrollNode
var abilityNameNode
var iconsNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	abilityScrollNode = get_node("AbilityScroll")
	abilityNameNode = get_node("AbilityScroll/AbilityName")
	iconsNode = get_node("Icons")
	_on_ability_scroll_value_changed(0.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_up() -> void:
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.


func _on_ability_scroll_value_changed(value: float) -> void:
	ClearIcons()
	match value:
		0.0:
			abilityNameNode.text = "Jump Boosts"
			for i in range(GlobalData.jumpLimit):
				var addedJumpBoostsIcon = JumpBoostsIconLoad.instantiate()
				addedJumpBoostsIcon.position.x = addedJumpBoostsIcon.global_position.x + i * 100
				iconsNode.add_child(addedJumpBoostsIcon)
		1.0:
			abilityNameNode.text = "Dash Boosts"
			for i in range(GlobalData.dashTime * 10):
				var addedDashBoostsIcon = DashBoostsIconLoad.instantiate()
				addedDashBoostsIcon.position.x = addedDashBoostsIcon.global_position.x + i * 100
				iconsNode.add_child(addedDashBoostsIcon)
		2.0:
			abilityNameNode.text = "Freeze Shot"
			for i in range(GlobalData.freezeTime * 10):
				var addedFreezeShotIcon = FreezeShotIconLoad.instantiate()
				iconsNode.add_child(addedFreezeShotIcon)
			
	pass # Replace with function body.

func ClearIcons():
	var children = iconsNode.get_children()
	for child in children:
		child.queue_free()
	pass
