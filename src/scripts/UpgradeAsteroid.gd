extends Upgrade

# Called when the node enters the scene tree for the first time.
func _ready():
	recepie = {
		"Wood": 10,
		"Stone": 10,
		"Metal": 10,
		"Food": 10,
		"Water": 10,
		"Fuel": 10,
		"Energy": 10,
		"Oxygen": 10,
		"Hydrogen": 10,
		"Carbon": 10,
		"Silicon": 10,
		"Plastic": 10,
		"Glass": 2,
	}	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Upgrade_pressed():
	pass

func can_upgrade():
	return true
