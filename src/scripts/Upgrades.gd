extends ScrollContainer
export var upgrades = [] setget ,get_updates

onready var Upgrades = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_updates():
	if not Upgrades:
		return []
	return Upgrades.get_children()