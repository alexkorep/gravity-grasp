extends ScrollContainer
export var upgrades = [] setget ,get_upgrades

onready var Upgrades = $VBoxContainer

signal upgrade(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_upgrades():
	if not Upgrades:
		return []
	return Upgrades.get_children()

func get_upgrade_by_name(name):
	for upgrade in upgrades:
		if upgrade.name == name:
			return upgrade
	return null

func _on_body_upgrade(body, qty):
	emit_signal("upgrade", body, qty)
