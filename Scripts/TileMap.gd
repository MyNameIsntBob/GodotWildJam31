extends TileMap

var used_cells 

var top = Vector2(0, -1)
var bottom = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)

var type_of_cells = {
	'special_background': 48,
	'background': 25,
	'special': 5,
	['top']: {
		[]: 2,
		['bottomLeft']: 21,
		['bottomLeft', 'bottomRight']: 20,
		['bottomRight']: 22
	},
	['bottom']: {
		[]: 14,
		['topLeft']: 39,
		['topLeft', 'topRight']: 0,
		['topRight']: 47,
	},
	['left']: {
		[]: 4,
		['topRight']: 11,
		['topRight', 'bottomRight']: 9,
		['bottomRight']: 17
	},

	['right']: {
		[]: 6,
		['topLeft']: 27,
		['bottomLeft']: 30,
		['topLeft', 'bottomLeft']: 44
	},

	['top', 'bottom']: 19,
	['left', 'right']: 31,
	['top', 'left']: {
		[]: 1,
		['bottomRight']: 38
	},
	['top', 'right']: {
		[]: 3,
		['bottomLeft']: 37 
	},
	['bottom', 'left']: { 
		[]: 13, 
		['topRight']: 35,
	},
	['bottom', 'right']: { 
		[]: 15,
		['topLeft']: 33 
	},
	
	['top', 'left', 'right']: 7,
	['top', 'bottom', 'left']: 45,
	['top', 'bottom', 'right']: 34,
	['bottom', 'left', 'right']: 8,

	['top', 'bottom', 'left', 'right']: 16,
	
	[]: {
		['topLeft']: 42,
		['topRight']: 40,
		['bottomLeft']: 41,
		['bottomRight']: 46,
		
		['topLeft', 'topRight']: 12,
		['topLeft', 'bottomLeft']: 36,
		['topLeft', 'bottomRight']: 28,
		['topRight', 'bottomLeft']: 26,
		['topRight', 'bottomRight']: 43,
		['bottomLeft', 'bottomRight']: 18,
		
		['topLeft', 'topRight', 'bottomLeft']: 23,
		['topLeft', 'topRight', 'bottomRight']: 24,
		['topLeft', 'bottomLeft', 'bottomRight']: 10,
		['topRight', 'bottomLeft', 'bottomRight']: 29,
		
		['topLeft', 'topRight', 'bottomLeft', 'bottomRight']: 32,
	}, 
}



func _ready():
	
	
#	if get_cell(cell.x, cell.y) == type_of_cells['special_background']:
#		place_special(cell)
	used_cells = get_used_cells_by_id(type_of_cells['background']) #  _by_id(type_of_cells['background'])
	for cell in used_cells:
		
		var open_cells = check_around(cell)
		for new_cell in open_cells:
			place_cell(new_cell)
			
	for cell in get_used_cells_by_id(type_of_cells["special_background"]):
#		place_special(cell)
		$TileMap.set_cell(cell.x, cell.y, 0)
		set_cell(cell.x, cell.y, -1)

#func place_special(pos):
#	var cells = check_around(pos, false, false)
#	for cell in cells:
#		if !cell in get_used_cells():
#			$TileMap.set_cell(cell.x, cell.y, 0)
##			set_cell(cell.x, cell.y, type_of_cells['special'])
#	set_cell(pos.x, pos.y, -1)
	

func place_cell(pos):
#	check all surounding to get idea of what one to place
	if pos in get_used_cells():
		return
	
	var around = check_around(pos, true)
		
#	print(pos, around)
		
	var value = []
	
	if top + pos in around:
		value.append('top')
	if bottom + pos in around:
		value.append('bottom')
	if left + pos in around:
		value.append('left')
	if right + pos in around: 
		value.append('right')
	
#	print('Cell at: ' + str(pos) + ' gets ' + str(type_of_cells[value]) + "  " + str(value))
	var test = type_of_cells[value]
	
	if typeof(test) == 2:
		set_cell(pos.x, pos.y, type_of_cells[value])
		return
	else:
		var newValues = []
		if top + left + pos in around and !('top' in value) and !('left' in value):
			newValues.append('topLeft')
		if top + right + pos in around and !('top' in value) and !('right' in value):
			newValues.append('topRight')
		if bottom + left + pos in around and !('bottom' in value) and !('left' in value): 
			newValues.append('bottomLeft')
		if bottom + right + pos in around and !('bottom' in value) and !('right' in value):
			newValues.append('bottomRight')
			
		set_cell(pos.x, pos.y, test[newValues])

# Get a list of cells that are taken or not taken depending on if taken is true or not
func check_around(pos, is_used = false, all_around = true):
	var cells = []
	var to_check = [top, bottom, left, right]
	if all_around:
		to_check += [top + left, top + right, bottom + left, bottom + right]
	
	for value in to_check:
		if (is_used and pos + value in used_cells) or (!is_used and !(pos + value in used_cells)):
			cells.append(pos + value)
	
	return cells
