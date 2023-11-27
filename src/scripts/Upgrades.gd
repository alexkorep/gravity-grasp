extends ScrollContainer

onready var Upgrades = $VBoxContainer

signal upgrade(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_upgrades():
	if not Upgrades:
		return []
	return Upgrades.get_children()


func _on_body_upgrade(body, qty):
	emit_signal("upgrade", body, qty)

func add_dust(amount):
	var upgrades = get_upgrades()
	for upgrade in upgrades:
		if upgrade.body_type == upgrade.CelestialBody.DUST:
			upgrade.quantity += amount
