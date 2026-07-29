class_name StateMachine
extends Node

var state = null
var previous_state = null
var states: Dictionary# = {}

@onready var parent = get_parent()

func _physics_process(delta: float) -> void:
	if state != null:
		state_logic(delta)
		var transition = get_transition(delta)
		if transition != null:
			set_state(transition)


func state_logic(_delta: float): #tell parent what to do - if state is ____ parent do function ____
	pass

func get_transition(_delta: float): #transitons - which state should play next - if state ___ is and doing ___ then next state is ___
	return null

func enter_state(_new_state, _old_state): #animations - if new state is ____ then play ____ | code: match new_state:
	pass

func exit_state(_new_state, _old_state):
	pass

func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:
		exit_state(previous_state, new_state)
	if new_state != null:
		enter_state(new_state, previous_state)
	

func add_states(state_name):
	states[state_name] = states.size()
