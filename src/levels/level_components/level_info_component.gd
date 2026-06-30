class_name level_info extends Node

@export var max_collectable_number: int
@export var max_checkpoint_number: int

func _enter_tree() -> void:
	if get_parent() == null:
		return
	elif get_parent() != null:
		GameSignals.level_max_collectable.emit()
