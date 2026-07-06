extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = false
	
	GameSignals.start_transition.connect(transition)
	GameSignals.end_transition.connect(transition_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition():
	color_rect.visible = true
	get_tree().paused = true

func transition_end():
	
	await get_tree().create_timer(1.5).timeout
	
	color_rect.visible = false
	get_tree().paused = false
