extends Control
class_name Upgrade

enum CelestialBody { NONE, DUST, METEROID, ASTEROID, MOON, PLANETOID, PLANET, JUPITER, SUN, NEUTRON_STAR, BLACK_HOLE }
enum Units { GRAM, ITEM }

export(CelestialBody) var body_type
export(Units) var units = Units.ITEM
export var title = 'Title' setget set_title, get_title
export var description = "Description"
export var quantity = 0 setget set_quantity
export var texture: Texture setget set_texture
export var speed: float = 0 setget set_speed

export(CelestialBody) var source_body
export var source_quantity = 100

var upgrade_buttons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_quantity(quantity)
	set_speed(speed)
	var RecepieLabel = $Panel/HBoxContainer/Info/RecepieLabel
	RecepieLabel.text = get_recepie_text()
	upgrade_buttons = [
		{
			'button': $Panel/HBoxContainer/Buttons/Upgrade0,
			'quantity': 1
		},
		{
			'button': $Panel/HBoxContainer/Buttons/Upgrade1,
			'quantity': 10
		},
		{
			'button': $Panel/HBoxContainer/Buttons/Upgrade2,
			'quantity': 100
		},
		{
			'button': $Panel/HBoxContainer/Buttons/Upgrade3,
			'quantity': 1000
		},
	]

func get_recepie_text():
	var src = get_source_body()
	if src == null:
		return ''
	return str(source_quantity) + ' ' + src.title + ' -> +1'

func set_texture(value: Texture):
	var TextureRect = $Panel/HBoxContainer/TextureRect
	if value == null:
		return
	TextureRect.texture = value
	texture = value

func set_title(value: String):
	var TitleLabel = $Panel/HBoxContainer/Info/TitleLabel
	TitleLabel.text = value
	title = value

func get_title():
	return title

func get_total_speed():
	# TODO make speed progressively slower with each upgrade
	return speed*quantity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_upgrade()
	# Every body produces dust
	# Calculate how much dust did we produce since last frame
	# and add it to the dust body
	var dust_amount = get_total_speed()*delta
	if dust_amount > 0:
		var dust_body = get_body_for_type(CelestialBody.DUST)
		if dust_body != null:
			dust_body.increment_quantity(dust_amount)

func set_speed(val: float):
	var SpeedLabel = $Panel/HBoxContainer/Info/SpeedLabel
	speed = val
	SpeedLabel.text = NumberFormatter.format_large_number(speed) + 'g/s'

func increment_quantity(value: float):
	set_quantity(quantity + value)

func set_quantity(val: float):
	var QuantityLabel = $Panel/HBoxContainer/Info/QuantityLabel
	quantity = val
	QuantityLabel.text = 'Qty: ' + NumberFormatter.format_large_number(quantity)

func _on_Button_pressed(qty):
	upgrade(qty)

func upgrade(qty):
	var required_source_quantity = source_quantity*qty
	var sibling = get_source_body()
	if sibling.quantity >= required_source_quantity:
		set_quantity(quantity + qty)
		sibling.set_quantity(sibling.quantity - required_source_quantity)

func enable_upgrade_buttons():
	var sibling = get_source_body()
	var quantity_available = sibling.quantity
	for button in upgrade_buttons:
		var button_control = button['button']
		var quantity_required_for_button = button['quantity']*source_quantity
		var enabled = quantity_available >= quantity_required_for_button
		button_control.disabled = !enabled

func hide_upgrade_buttons():
	for button in upgrade_buttons:
		var button_control = button['button']
		button_control.visible = false

func get_body_for_type(type):
	var siblings = get_parent().get_children()
	for sibling in siblings:
		if sibling != self:
			if sibling.body_type == type:
				return sibling
	return null

func get_source_body():
	"""
		Returns the body that is required to upgrade this body.
	"""
	return get_body_for_type(source_body)
	
func check_upgrade():
	"""
		Checks if we can upgrade this body.
		Checks if the source body has enough quantity to upgrade this body.
	"""
	# TODO check if can upgrade for qty > 1
	var sibling = get_source_body()
	if sibling != null:
		enable_upgrade_buttons()
	else:
		hide_upgrade_buttons()

func get_save_data():
	var data = {}
	data['body_type'] = body_type
	data['quantity'] = quantity
	return data

func load_save_data(data):
	set_quantity(data['quantity'])

func reset():
	set_quantity(0)
