extends Node

var collectables_collected: int
var max_collectables: int


func _ready() -> void:
	GameSignals.level_max_collectable.connect(set_max_collectables)
	GameSignals.collectable_collected.connect(update_collectables)



#Collectable system
func set_max_collectables(most: int) -> void:
	max_collectables = most

func update_collectables(value: int) -> void:
	collectables_collected += value
	clamp(collectables_collected, 0, max_collectables)
	print("Collectables Collected: %d / %d" %[collectables_collected, max_collectables])
	
	
