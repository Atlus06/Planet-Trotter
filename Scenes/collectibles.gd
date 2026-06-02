extends Area2D

@onready var can_collect_component: Can_Collect_Component = $Can_Collect_Component

func _ready() -> void:
	can_collect_component.Collected_Item.connect(gained_collectable)
	can_collect_component.Level_cleared.connect(cleared_level)
	
	

func gained_collectable():
	#can_collect_component.got_collectable()
	print("You got a collectable!")
	queue_free()

func cleared_level():
	print("You got all of the collectables!!")
