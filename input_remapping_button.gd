extends Button
class_name InputReMapButton

@export var action: String
@export var action_event_index: int = 0


#For later - when contoller inputs are added
const CONTROLLER_LABELS: Dictionary = {
		JoyButton.JOY_BUTTON_A: "A",
		JoyButton.JOY_BUTTON_B: "B",
		JoyButton.JOY_BUTTON_X: "X",
		JoyButton.JOY_BUTTON_Y: "Y",
		JoyButton.JOY_BUTTON_LEFT_SHOULDER: "LB",
		JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "RB",
		JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
		JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
		JoyButton.JOY_BUTTON_DPAD_UP: "↑",
		JoyButton.JOY_BUTTON_DPAD_DOWN: "↓",
		JoyButton.JOY_BUTTON_DPAD_LEFT: "←",
		JoyButton.JOY_BUTTON_DPAD_RIGHT: "→",
		JoyButton.JOY_BUTTON_START: "START",
		JoyButton.JOY_BUTTON_GUIDE: "GUIDE",
}


func _ready() -> void:
	add_to_group("rebind_buttons")
	toggle_mode = true
	update_display()
	
	


func update_display():
	if !action or !InputMap.has_action(action):
		return
	
	var events = InputMap.action_get_events(action)
	#print("Action: ", action, " Events found: ", events.size())
	if action_event_index >= events.size():
		action_event_index = 0
	
	
	if events.size() == 0:
		text = "Unassaigned"
		return
	
	
	var input = events[action_event_index]
	if input is InputEventJoypadButton:
		if CONTROLLER_LABELS.has(input.button_index):
			text = CONTROLLER_LABELS.get(input.button_index)
		else:
			text = "Button " + str(input.button_index)
	elif input is InputEventKey:
		if input.physical_keycode != 0:
			text = OS.get_keycode_string(input.physical_keycode)
		else:
			text = OS.get_keycode_string(input.keycode)
	

func _toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "Awaiting Input"
	else:
		update_display()

func _unhandled_input(event: InputEvent) -> void:
	if !InputMap.has_action(action) or !is_pressed():
		return
	
	if event.is_pressed() and (event is InputEventKey or event is InputEventJoypadButton):
		var action_events_list = InputMap.action_get_events(action)
		if action_event_index < action_events_list.size():
			InputMap.action_erase_event(action, action_events_list[action_event_index])
	
	InputMap.action_add_event(action, event)
	action_event_index = InputMap.action_get_events(action).size() - 1
	button_pressed = false
	release_focus()
	

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event is InputEventMouseButton:
			button_pressed = false
			release_focus()
