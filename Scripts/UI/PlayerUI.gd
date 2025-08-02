extends Control

var LoopLENode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LoopLENode = get_node("LoopLE")
	LoopLENode.text = str(GlobalData.loopNum)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
