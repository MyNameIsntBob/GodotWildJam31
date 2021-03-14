extends Node

var current_level = 0

var levels = [
	'res://Scenes/Level1.tscn'
]


func load_level():
	get_tree().change_scene(levels[current_level])
	
func next_level():
	if current_level < len(levels) - 1:
		current_level += 1
		load_level()
