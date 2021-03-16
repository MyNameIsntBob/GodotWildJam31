extends Node

var current_level = 5
var keys = 0

var levels = [
	'res://Scenes/Intro.tscn',
	'res://Scenes/Nine.tscn',
	'res://Scenes/Space.tscn',
	'res://Scenes/Level1.tscn',
	'res://Scenes/RoundAndRound.tscn',
	'res://Scenes/Key.tscn'
]

func add_key():
	keys += 1
	
func use_key():
	keys -= 1

func load_level():
	keys = 0
	get_tree().change_scene(levels[current_level])
	
func next_level():
	if current_level < len(levels) - 1:
		current_level += 1
		load_level()
