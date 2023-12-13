# Tickers the text, but goes character by character instead of smoothly, like the previous script.
extends Control

onready var ScrollContainer = $ScrollContainer
onready var Label = $ScrollContainer/Label
var scroll_pos = 0.0

export var scroll_step = 0.5
export var text = 'text to scroll'

func _ready():
	ScrollContainer = $ScrollContainer
	ScrollContainer.get_h_scrollbar().rect_scale.x = 0
	# Copy the text twice to make sure the beginning
	# of the text is displayed after the ending of the text
	Label.text = text + ' ' + text

func _process(delta):
	scroll_pos += scroll_step
	ScrollContainer.scroll_horizontal = int(scroll_pos)
	check_reset_scroll_pos()

func check_reset_scroll_pos():
	var container_width = ScrollContainer.rect_size.x
	var label_width = Label.rect_size.x
	# Reset condition when the beginning of the second copy
	# of the text is at the left edge of the control
	if scroll_pos >= label_width/2:
		scroll_pos = 0
	
