extends Area2D

@onready var respawn_point: Marker2D = $RespawnPoint


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameVariables.last_checkpoint_pos = respawn_point.global_position
