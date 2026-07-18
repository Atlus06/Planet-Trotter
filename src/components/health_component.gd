class_name Health_Component extends Node

var max_health := 30
var current_health: int


signal dead

func _ready() -> void:
	current_health = max_health
	GameSignals.health_changed.connect(health_update)
	GameSignals.hurt_player.connect(player_hurt)
	
	#print(current_health)

func health_update() -> void:
	current_health = clamp(current_health, 0, 30)
	print("Health: %d / %d" %[current_health, max_health])

func player_hurt(damage) -> void:
	current_health -= damage
	GameSignals.health_changed.emit(current_health)
