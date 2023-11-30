extends Control

onready var HUD = $MainContainer/Top/HUD
onready var Ungrades = $MainContainer/Bottom/Upgrades
onready var Settings = $Settings

export var save_file_name = "user://save_game.dat"

# Called when the node enters the scene tree for the first time.
func _ready():
	if save_game_exists():
		load_game()
	else:
		new_game()

func _process(_delta):
	var spd = get_total_speed()
	set_speed(spd)
	pass

func _on_Body_clicked():
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

func set_body_texture(texture: Texture):
	$MainContainer/Top/Body.body_texture = texture

func delete_game_file():
	var dir = Directory.new()
	dir.remove(save_file_name)
	
func save_game():
	var save_game = File.new()
	var save_data = {}
	var upgrades = []
	for upgrade in Ungrades.get_upgrades():
		upgrades.append(upgrade.get_save_data())
	save_data['upgrades'] = upgrades
	save_game.open(save_file_name, File.WRITE)
	save_game.store_var(save_data)
	save_game.close()
	
func save_game_exists():
	var save_game = File.new()
	if save_game.file_exists(save_file_name):
			return true
	return false
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(save_file_name):
		return false
	save_game.open(save_file_name, File.READ)
	var save_data = save_game.get_var()
	save_game.close()
	print('save_data: ', save_data)
	var upgrades = save_data['upgrades']
	var i = 0
	for upgrade in Ungrades.get_upgrades():
		upgrade.load_save_data(upgrades[i])
		i += 1
	return true

func new_game():
	delete_game_file()
	for upgrade in Ungrades.get_upgrades():
		upgrade.reset()

func _on_HUD_show_settings():
	Settings.show()

func _on_Settings_new_game():
	new_game()

func _on_SaveGameTimer_timeout():
	save_game()
