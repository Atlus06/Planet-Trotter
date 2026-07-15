class_name Collectble_component extends Area2D

@export var Colletable_name: String
var resource_value := 1

var can_collect = false

func _ready() -> void:
	await get_tree().create_timer(0.3).timeout
	can_collect = true
	

func _on_collectable_body_entered(body: Node2D) -> void:
	#print("You got a resource!")
	if body is Player and can_collect:
		GameSignals.collectable_collected.emit(resource_value)
		get_parent().queue_free()
