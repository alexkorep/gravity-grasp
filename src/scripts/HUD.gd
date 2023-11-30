extends Control

signal show_settings()

export var speed: float = 100.0 setget set_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_speed(value: float):
	var SpeedLabel = $HUDTop/SpeedLabel
	SpeedLabel.text = 'Dust: ' + NumberFormatter.format_large_number(value) + 'g/s'

func _on_SettingsButton_pressed():
	emit_signal('show_settings')
	print('Settings button pressed')