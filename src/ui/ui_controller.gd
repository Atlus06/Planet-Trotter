extends Node

@onready var HudRoot: Control = $HudLayer/HudRoot
@onready var PauseRoot: Control = $PauseLayer/PauseRoot
@onready var TransitionRoot: Control = $TransitionLayer/TransitionRoot

func _process(delta: float) -> void:
	#make it so pausing during transition doesn't break game
	PauseRoot.is_transitioning = TransitionRoot.is_transitioning
