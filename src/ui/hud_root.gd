extends Control

@onready var health_bar: ProgressBar = %HealthBar
@onready var dash_charge_bar: ProgressBar = %DashChargeBar
@onready var collectable_counter: Label = %CollectableCounter

@onready var fps_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/FPSLabel
@onready var fps_color_rect: ColorRect = $MarginContainer/ColorRect
@onready var fps_v_box_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer


@export var duration := 0.75
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
	GameSignals.show_fps.connect(show_frames_per_second)
	GameSignals.hide_fps.connect(hide_frames_per_second)
	dash_charge_bar.max_value = duration
	
	fps_color_rect.visible = false
	fps_label.visible = false
	fps_v_box_container.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer <= dash_charge_bar.max_value:
		timer += delta
		dash_charge_bar.value = timer
	
	
	var current_fps = Engine.get_frames_per_second()
	fps_label.text = "FPS: " + str(current_fps)
	#print("FPS: " + str(current_fps))


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

func hide_frames_per_second():
	if fps_color_rect.visible == true:
		fps_color_rect.visible = false
		fps_label.visible = false
		fps_v_box_container.visible = false

func show_frames_per_second():
		if fps_color_rect.visible == false:
			fps_color_rect.visible = true
			fps_label.visible = true
			fps_v_box_container.visible = true
