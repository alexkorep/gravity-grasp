extends Control
class_name Upgrade

signal upgrade(body)
signal dust_collected(body, amount)

enum CelestialBody { NONE, DUST, METEROID, ASTEROID, MOON, PLANETOID, PLANET, JUPITER, SUN, NEUTRON_STAR, BLACK_HOLE }
enum Units { GRAM, ITEM }

export(CelestialBody) var body_type
export(Units) var units = Units.ITEM
export var title = "Title" setget set_title
export var description = "Description"
export var quantity = 0 setget set_quantity
export var texture: Texture setget set_texture
export var speed: float = 0 setget set_speed
export var upgrade_enabled = false setget enable_upgrade

export(CelestialBody) var source_body
export var source_quantity = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	set_quantity(quantity)
	set_speed(speed)
	var RecepieLabel = $Panel/HBoxContainer/Info/RecepieLabel
	RecepieLabel.text = get_recepie_text()

func get_recepie_text():
	var text = ''
	# for item in recepie:
	# 	if text != '':
	# 		text += ' + '
	# 	text += NumberFormatter.format_large_number(recepie[item]) + ' ' + item
	return text + ' -> +1'

func set_texture(value: Texture):
	var TextureRect = $Panel/HBoxContainer/TextureRect
	if value == null:
		return
	TextureRect.texture = value
	texture = value

func set_title(value: String):
	var TitleLabel = $Panel/HBoxContainer/Info/TitleLabel
	TitleLabel.text = value

func get_total_speed():
	# TODO make speed progressively slower with each upgrade
	return speed*quantity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_upgrade()

	var dust_amount = get_total_speed()*delta
	if dust_amount > 0:
		emit_signal("dust_collected", self, dust_amount)

func set_speed(val: float):
	var SpeedLabel = $Panel/HBoxContainer/Info/SpeedLabel
	speed = val
	SpeedLabel.text = NumberFormatter.format_large_number(speed) + 'g/s'

func set_quantity(val: int):
	var QuantityLabel = $Panel/HBoxContainer/Info/QuantityLabel
	quantity = val
	QuantityLabel.text = 'Qty: ' + NumberFormatter.format_large_number(quantity)

func _on_Button_pressed():
	# set_quantity(quantity + 1)
	emit_signal("upgrade", self, 1)

func get_upgrade_recepie():
	return '' #recepie

func upgrade(qty):
	set_quantity(quantity + qty)

func enable_upgrade(enabled):
	var Button = $Panel/HBoxContainer/Info/UpgradeButton
	Button.disabled = !enabled
	upgrade_enabled = enabled

func check_upgrade():
	var siblings = get_parent().get_children()
	for sibling in siblings:
		if sibling != self:
			if sibling.body_type == source_body and sibling.quantity >= source_quantity:
				enable_upgrade(true)
				return
	enable_upgrade(false)

# func get_all_bodies():
# 	var siblings = get_siblings()
# 	var bodies = []
# 	for sibling in siblings:
# 		if sibling is Upgrade and sibling != self:
# 			bodies.append(sibling)
# 	return bodies
