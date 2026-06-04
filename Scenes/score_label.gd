extends Label

var max_c = GameManager.max_resources
var collected = GameManager.resources_collected


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.Collected_item.connect(update_score)
	max_c = GameManager.max_resources
	collected = GameManager.resources_collected
	text = "Resources Collected: %d / %d" % [0,max_c]

func update_score(amount: int) -> void:
	collected = GameManager.resources_collected
	#text = "Resources Collected: " + collected + " / " + max_c
	text = "Resources Collected: %d / %d" % [collected, max_c]
