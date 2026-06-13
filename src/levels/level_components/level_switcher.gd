class_name LevelSwitcher extends Area2D

#signal Switch_Level


func _on_body_entered(body: Node2D) -> void:
	GameSignals.change_level.emit()
	
