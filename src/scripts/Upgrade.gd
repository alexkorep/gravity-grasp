extends Control
class_name Upgrade

signal upgrade(body)

enum CelestialBody { NONE, DUST, METEROID, ASTEROID, MOON, PLANETOID, PLANET, JUPITER, SUN, NEUTRON_STAR, BLACK_HOLE }
enum Units { GRAM, ITEM }

export(CelestialBody) var body_type
export(Units) var units = Units.ITEM
export var title = 'Title' setget set_title, get_title
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

func _on_Button_pressed():
	upgrade(1)

func upgrade(qty):
	var required_source_quantity = source_quantity*qty
	var sibling = get_source_body()
	if sibling.quantity >= required_source_quantity:
		set_quantity(quantity + qty)
		sibling.set_quantity(sibling.quantity - required_source_quantity)

func enable_upgrade(enabled):
	var Button = $Panel/HBoxContainer/Info/UpgradeButton
	Button.disabled = !enabled
	upgrade_enabled = enabled

func get_body_for_type(type):
	var siblings = get_parent().get_children()
	for sibling in siblings:
		if sibling != self:
			if sibling.body_type == type:
				return sibling
	return null

func get_source_body():
	return get_body_for_type(source_body)
	
func check_upgrade():
	# TODO check if can upgrade for qty > 1
	var sibling = get_source_body()
	if sibling != null:
		enable_upgrade(sibling.quantity >= source_quantity)
	else:
		var Button = $Panel/HBoxContainer/Info/UpgradeButton
		Button.visible = false
