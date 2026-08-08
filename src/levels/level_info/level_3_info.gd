class_name level_3_info extends Node

@onready var player_spawn: Marker2D = $PlayerSpawn

@export var max_collectable_number := 26
@export var current_level_number: int = 3
@export var player_spawn_pos: Vector2
var next_level: String = "res://src/levels/levels/level_4_test.tscn"

func _ready() -> void:
	player_spawn_pos = player_spawn.global_position
	GameVariables.last_checkpoint_pos = player_spawn_pos
	
	GameSignals.player_spawn.emit(player_spawn_pos)
	GameSignals.level_max_collectable.emit(max_collectable_number)
	
	#print("Level 1: " + str(max_collectable_number))
	#print(player_spawn_pos)
