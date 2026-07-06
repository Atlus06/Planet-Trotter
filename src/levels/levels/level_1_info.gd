class_name level_1_info extends Node

@onready var player_spawn: Marker2D = $PlayerSpawn

@export var max_collectable_number := 0
@export var max_checkpoint_number: int
@export var player_spawn_pos: Vector2

func _ready() -> void:
	player_spawn_pos = player_spawn.global_position
	
	GameSignals.player_spawn.emit(player_spawn_pos)
	GameSignals.level_max_collectable.emit(max_collectable_number)
	
	#print("Level 1: " + str(max_collectable_number))
	#print(player_spawn_pos)
