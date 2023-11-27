extends Control

signal clicked

export var body_texture: Texture = null setget set_body_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_MarginContainer_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked")
		$MarginContainer/CPUParticles2D.emitting = true

func set_body_texture(texture):
	body_texture = texture
	$MarginContainer/BodyTextureRect.texture = body_texture
