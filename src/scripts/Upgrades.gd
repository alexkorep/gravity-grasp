extends ScrollContainer

onready var Upgrades = $VBoxContainer

signal on_first_upgrade(body)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_upgrades():
	if not Upgrades:
		return []
	return Upgrades.get_children()

func add_dust(amount):
	var upgrades = get_upgrades()
	for upgrade in upgrades:
		if upgrade.body_type == upgrade.CelestialBody.DUST:
			upgrade.quantity += amount


func on_body_upgrade(body, qty):
	print(body, qty)
	var is_new_body_opened = false
	var upgrades = get_upgrades()
	for upgrade in upgrades:
		if upgrade.body_type == body.body_type:
			is_new_body_opened = true
		elif upgrade.quantity > 0:
			is_new_body_opened = false
	if is_new_body_opened:
		emit_signal("on_first_upgrade", body)


