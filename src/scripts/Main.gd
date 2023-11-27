extends VBoxContainer

onready var HUD = $Top/HUD
onready var Ungrades = $Bottom/Upgrades

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var spd = get_total_speed()
	# set_mass(mass + spd * delta)
	set_speed(spd)
	pass

func _on_Body_clicked():
	#set_mass(mass + 1)
	Ungrades.add_dust(1)

func set_mass(val: float):
	if not HUD:
		return
	HUD.mass = val

func set_speed(val: float):
	if not HUD:
		return
	HUD.speed = val

func get_total_speed():
	var total_speed = 0
	var upgrades = Ungrades.get_upgrades()
	for upgrade in upgrades:
		total_speed += upgrade.get_total_speed()
	return total_speed

func _on_Upgrades_upgrade(body, qty):
	# var recepie = body.recepie
	# for required_body in recepie:
	# 	var quantity = recepie[required_body]*qty
	# 	if required_body == 'dust':
	# 		if mass < quantity:
	# 			return
	# 		set_mass(mass - quantity)
	# 		body.upgrade(1)
	# 	print(body.texture)
	# 	set_body_texture(body.texture)
	pass

# func can_upgrade(body, qty):
# 	var recepie = body.recepie
# 	for required_body in recepie:
# 		var quantity = recepie[required_body]*qty
# 		if required_body == 'dust':
# 			if mass < quantity:
# 				return false
# 	return true

# func update_upgrade_buttons():
# 	var upgrades = Ungrades.upgrades
# 	for upgrade in upgrades:
# 		var can_up = can_upgrade(upgrade, 1)
# 		upgrade.enable_upgrade(can_up)

func set_body_texture(texture: Texture):
	$Top/Body.body_texture = texture
