extends Area2D

#signal Switch_Level
var can_switch = false

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	can_switch = true

func _on_body_entered(body: Node2D) -> void:
	#GameSignals.change_level.emit()
	if can_switch and body is Player:
		GameSignals.leaving_level.emit("res://src/levels/levels/level_1_test.tscn")
		#print("to level 1")
	
	
