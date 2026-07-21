class_name Health_Component extends Node

var max_health := 30
var current_health: int

var timer := 0.0
var time_to_heal_duration := 3.0
var between_heals_duration := 1.0


func _ready() -> void:
	current_health = max_health
	GameSignals.health_changed.connect(health_update)
	GameSignals.hurt_player.connect(player_hurt)
	GameSignals.reset_player_health.connect(reset_health)
	
	#print(current_health)

func _process(delta: float) -> void:
	#if health is below a certain numner for a long enough time health goes up automatically
	if timer > 0:
		timer -= delta
		timer = max(0.0, timer)
		#print(timer)
	
	
	if current_health != max_health and timer <= 0:
		current_health += 1
		timer = between_heals_duration
		GameSignals.health_changed.emit(current_health)
		#print(current_health)
	
	if current_health <= 0:
		GameSignals.player_died.emit(GameVariables.last_checkpoint_pos)
		print("You Died")


func health_update(_health) -> void:
	current_health = clamp(current_health, 0, 30)
	print("Health: %d / %d" %[current_health, max_health])

func player_hurt(damage) -> void:
	current_health -= damage
	timer = time_to_heal_duration
	GameSignals.health_changed.emit(current_health)

func reset_health(_health):
	current_health = max_health
	GameSignals.health_changed.emit(current_health)
