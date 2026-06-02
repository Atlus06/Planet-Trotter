class_name Can_Collect_Component extends Node


signal Collected_Item(current: int, max: int)
signal Level_cleared

@export var max_collectable_amt := 13
var current_collected := 0

func _ready() -> void:
	_emit()
	

func got_collectable() -> void:
	#current_collected = clamp(current_collected + 1, 0, max_collectable_amt)
	#_emit()
	
	if current_collected == max_collectable_amt:
		Level_cleared.emit()


func _emit() -> void:

	Collected_Item.emit()
	
	print("Items Collected: %d / %d" % [current_collected, max_collectable_amt])
	


func _on_collectibles_body_entered(body: Node2D) -> void:
	current_collected = clamp(current_collected + 1, 0, max_collectable_amt)
	_emit()
	got_collectable()
