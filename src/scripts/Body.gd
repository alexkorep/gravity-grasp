extends Control

signal clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MarginContainer_gui_input(event:InputEvent):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked")

