extends Area2D

var damage := 10


func _on_body_entered(body: Node2D) -> void:
	#if Player:
	GameSignals.hurt_player.emit(damage)
