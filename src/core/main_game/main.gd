extends Node

@onready var LevelRoot = get_node("World/LevelRoot")

func _ready() -> void:
	#$Systems/LevelSwitcher.Switch_Level.connect(switch_level)
	GameSignals.change_level.connect(switch_level)
	#pass


func switch_level():
	#print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
	if LevelRoot.get_child_count() > 0:
		var old_level = LevelRoot.get_child(0)
		old_level.queue_free()
	
	var new_level_instance = preload("uid://n8mlxlm6rc5c").instantiate()
	
	LevelRoot.add_child.call_deferred(new_level_instance)
	
	
	
