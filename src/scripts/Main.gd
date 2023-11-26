extends VBoxContainer

# Mass increment per second
var speed: float = 0
# Current mass
var mass: float = 0 setget set_mass

onready var HUD = $Top/HUD
onready var Ungrades = $Bottom/Upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var spd = get_total_speed()
	set_mass(mass + spd * delta)
	set_speed(spd)

func _on_Body_clicked():
	set_mass(mass + 1)

func set_mass(val: float):
	if not HUD:
		return
	HUD.mass = val
	mass = val

func set_speed(val: float):
	if not HUD:
		return
	HUD.speed = val
	speed = val

func get_total_speed():
	var total_speed = 0
	var upgrades = Ungrades.upgrades
	for upgrade in upgrades:
		total_speed += upgrade.get_total_speed()
	return total_speed


func _on_Upgrades_upgrade(body, qty):
	print(body.recepie)
	var recepie = body.recepie
	for required_body in recepie:
		var quantity = recepie[required_body]*qty
		print(required_body, quantity)
		if required_body == 'dust':
			if mass < quantity:
				return
			set_mass(mass - quantity)
			body.upgrade(1)
