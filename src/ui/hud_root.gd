extends Control

@onready var health_bar: ProgressBar = $VBoxContainer2/VBoxContainer/HealthBar
@onready var dash_charge_bar: ProgressBar = $VBoxContainer2/VBoxContainer/DashChargeBar
@onready var collectable_counter: Label = $VBoxContainer2/CollectableCounter

@export var duration := 1.5
var timer := 0.0

@export var max_collectables: int
var collectables_collected: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameSignals.health_changed.connect(change_healthbar)
	GameSignals.player_dashed.connect(change_dashbar)
	GameSignals.level_max_collectable.connect(set_max_collectables)
	GameSignals.collectable_collected.connect(collected_collectable)
	GameSignals.leaving_level.connect(reset_collectables)
	dash_charge_bar.max_value = duration


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer <= dash_charge_bar.max_value:
		timer += delta
		dash_charge_bar.value = timer
	


func change_healthbar(health):
	health_bar.value = health

func change_dashbar():
	dash_charge_bar.value = 0
	timer = 0
	dash_charge_bar.max_value = duration


func set_max_collectables(max_collectable: int):
	max_collectables = max_collectable
	collectable_counter.text = "Collectables Collected: %d / %d" %[collectables_collected, max_collectables]

func collected_collectable(value):
	collectables_collected += value
	clampi(collectables_collected, 0, max_collectables)
	collectable_counter.text = "Collectables Collected: %d / %d" %[collectables_collected, max_collectables]

func reset_collectables(_level_path):
	collectables_collected = 0
	collectable_counter.text = "Collectables Collected: %d / %d" %[collectables_collected, max_collectables]
