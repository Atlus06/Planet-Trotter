class_name Collectble_component extends Area2D

@export var Colletable_name: String
var resource_value := 1

func _on_collectable_body_entered(body: Node2D) -> void:
	#print("You got a resource!")
	get_parent().queue_free()
