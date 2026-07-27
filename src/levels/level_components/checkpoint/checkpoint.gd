extends Area2D

@onready var respawn_point: Marker2D = $RespawnPoint

var disabled = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if respawn_point.global_position != GameVariables.last_checkpoint_pos and disabled == false:
			GameSignals.reset_player_health.emit(null)
		GameVariables.last_checkpoint_pos = respawn_point.global_position
	
	disabled = true
