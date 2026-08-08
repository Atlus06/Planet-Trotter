extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	GameSignals.toggle_debug.connect(debug)


func debug(onoff):
	visible = onoff
