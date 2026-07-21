class_name start_level_info extends Node

@onready var player_spawn: Marker2D = $PlayerSpawn

@export var max_collectable_number := 13
@export var max_checkpoint_number: int
@export var player_spawn_pos: Vector2

func _ready() -> void:
	player_spawn_pos = player_spawn.global_position
	
	GameSignals.level_max_collectable.emit(max_collectable_number)
	GameSignals.player_spawn.emit(player_spawn_pos)
	
	#print("Start Level: " + str(max_collectable_number))
	#print(player_spawn_pos)
