extends Node

signal Collected_item(new_amount: int)

@export var max_resources := 13
var resources_collected = 0

func collected_resource(amount: int) -> void:
	#resources_collected = clamp(resources_collected + amount, 0, max_resources)
	resources_collected += amount
	Collected_item.emit(resources_collected)
	print("Resources Collected: %d / %d" % [resources_collected, max_resources])
	
	

#add func to say level cleared when all rescources collected


func _process(delta: float) -> void:
	pass
