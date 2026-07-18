extends Control

@onready var transition_rect: ColorRect = $TransitionRect
@onready var transition_label: Label = $TransitionRect/TransitionLabel

var is_transitioning: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition_rect.visible = false
	
	GameSignals.start_transition.connect(transition)
	GameSignals.end_transition.connect(transition_end)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition():
	is_transitioning = true
	transition_rect.visible = true
	get_viewport().set_input_as_handled()
	get_tree().paused = true

func transition_end():
	
	await get_tree().create_timer(1.5).timeout
	
	transition_rect.visible = false
	get_tree().paused = false
	is_transitioning = false
