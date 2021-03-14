extends TileMap

var used_cells 



func _ready():
	used_cells = get_used_cells()
	for cell in used_cells:
		var open_cells = check_all_around(cell)
		for new_cell in open_cells:
			place_cell(new_cell)
			
func place_cell(pos):
#	check all surounding to get idea of what one to place
	pass

# Get a list of cells that are taken or not taken depending on if taken is true or not
func check_all_around(pos, taken = false):
	var cells = []
	
	for i in range(-1, 1):
		for j in range(-1, 1):
			if pos - Vector2(i, j) in used_cells:
				pass
	
	return cells
