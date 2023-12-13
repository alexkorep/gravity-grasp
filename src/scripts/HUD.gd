extends Control

signal on_settings_pressed()

export var speed: float = 100.0 setget set_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_speed(value: float):
	var SpeedLabel = $Panel/HUDTop/SpeedLabel
	SpeedLabel.text = NumberFormatter.format_large_number(value) + 'g/s'


func _on_SettingsButton_pressed():
	emit_signal("on_settings_pressed")

