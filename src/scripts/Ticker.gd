# Tickers the text, but goes character by character instead of smoothly, like the previous script.
extends Label

# All of the text to scroll
export (String) var ticker_text = "Big news today! Godot is announced as best engine ever! "
# Number of characters to display
export (int) var num_chars_display = 20

var current_char_pos = 0
onready var text_length = ticker_text.length()

# You could do this cleaner with a timer or something else, this is just quick and dirty
var cumulative_delta = 0
func _process(delta):
	cumulative_delta += delta
	if cumulative_delta > 0.1:
		set_ticker_text()
		cumulative_delta = 0
	
	
func set_ticker_text():
#	Set the text to the current position + some number of characters
	text = ticker_text.substr(current_char_pos, num_chars_display)
	
#	If there is overflow (meaning that "end" of the string is at a higher index than the length of the ticker text)
#	then loop back around and append the start of the text as needed
	if current_char_pos + num_chars_display > ticker_text.length():

		text += ticker_text.substr(0, current_char_pos + num_chars_display - ticker_text.length())

	current_char_pos += 1
# 	Mod the char position so it goes back to zero
	current_char_pos = current_char_pos % text_length
