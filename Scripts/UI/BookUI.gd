extends Control

var JumpBoostsIconLoad = load("uid://6rt1dh4imclu")
var DashBoostsIconLoad = load("uid://x64iv16s0wlh")
var FreezeShotIconLoad = load("uid://db3exn288okc4")

var abilityNameNode
var iconsNode
var abilityDetailsNode
var bookAreaNode
var pagePlayer
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	
	abilityNameNode = get_node("AbilityName")
	iconsNode = get_node("Icons")
	abilityDetailsNode = get_node("AbilityDetails")
	
	pagePlayer = get_node("PagePlayer")
	pagePlayer.volume_db = GlobalData.sfxVolume
	pagePlayer.pitch_scale = rng.randf_range(0.6, 1.2)
	pagePlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_up() -> void:
	get_tree().paused = false
	queue_free()
	pass # Replace with function body.

func CheckGroup():
	if bookAreaNode.is_in_group("Jump Boost"):
		abilityNameNode.text = "Jump Boosts"
		abilityDetailsNode.text = "Press Space To Jump\nYou can now jump " + str(GlobalData.jumpLimit) + " times in the air"
		var addedJumpBoostsIcon = JumpBoostsIconLoad.instantiate()
		iconsNode.add_child(addedJumpBoostsIcon)
	elif bookAreaNode.is_in_group("Dash"):
		abilityNameNode.text = "Dash Boosts"
		abilityDetailsNode.text = "Hold Shift To Dash\nLets You Dash Through Enemies\nYou can now dash for " + str(GlobalData.dashTime) + " seconds"
		var addedDashBoostsIcon = DashBoostsIconLoad.instantiate()
		iconsNode.add_child(addedDashBoostsIcon)
	elif bookAreaNode.is_in_group("Freeze Shot"):
		abilityNameNode.text = "Freeze Shot"
		abilityDetailsNode.text = "Your Magic Now Freezes Enemies In Place\nYou can now freeze enemies for " + str(GlobalData.freezeTime) + " seconds
"
		var addedFreezeShotIcon = FreezeShotIconLoad.instantiate()
		iconsNode.add_child(addedFreezeShotIcon)
	pass
