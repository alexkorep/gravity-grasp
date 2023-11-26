extends Control
class_name Upgrade

signal upgrade(body)

export var title = "Title"
export var id = "ID"
export var description = "Description"
export var quantity = 0 setget set_quantity
export var recepie = {}
export var texture: Texture setget set_texture
export var speed: float = 0 setget set_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	set_quantity(quantity)
	set_speed(speed)
	var RecepieLabel = $Panel/HBoxContainer/Info/RecepieLabel
	RecepieLabel.text = get_recepie_text()

func get_recepie_text():
	var text = ''
	for item in recepie:
		text += NumberFormatter.format_large_number(recepie[item]) + ' ' + item + '\n'
	return text

func set_texture(value: Texture):
	var TextureRect = $Panel/HBoxContainer/TextureRect
	if value == null:
		return
	TextureRect.texture = value

func get_total_speed():
	return speed*quantity

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_speed(val: float):
	var SpeedLabel = $Panel/HBoxContainer/Info/SpeedLabel
	speed = val
	SpeedLabel.text = NumberFormatter.format_large_number(speed) + 'g/s'

func set_quantity(val: int):
	var QuantityLabel = $Panel/HBoxContainer/Info/QuantityLabel
	quantity = val
	QuantityLabel.text = NumberFormatter.format_large_number(quantity)

func _on_Button_pressed():
	# set_quantity(quantity + 1)
	emit_signal("upgrade", self, 1)

func get_upgrade_recepie():
	return recepie

func upgrade(qty):
	set_quantity(quantity + qty)
