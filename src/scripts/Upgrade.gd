extends Control
class_name Upgrade

export var title = "Title"
export var id = "ID"
export var description = "Description"
export var quantity = 0
var recepie = {}
export var texture: Texture setget set_texture

#onready var TextureRect = $HBoxContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_texture(value: Texture):
	var TextureRect = $Panel/HBoxContainer/TextureRect
	print("Setting texture", TextureRect, value)
	if value == null:
		print("Texture is null")
		return
	TextureRect.texture = value


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
