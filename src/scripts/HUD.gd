extends Control

signal show_settings()

export var speed: float = 100.0 setget set_speed
export var mass: float = 100.0 setget set_mass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_speed(value: float):
	var SpeedLabel = $HUDTop/SpeedLabel
	SpeedLabel.text = NumberFormatter.format_large_number(value) + 'g/s'

func set_mass(value: float):
	var MassLabel = $HUDTop/MassLabel
	MassLabel.text = NumberFormatter.format_large_number(value) + 'g'

func _on_SettingsButton_pressed():
	emit_signal('show_settings')
	print('Settings button pressed')