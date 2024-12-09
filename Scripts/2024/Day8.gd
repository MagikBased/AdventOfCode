extends Node

var silver = 0
var gold = 0
var rows = []
var cols = []
var input_grid = []
var frequencies = {}
var antinodes = {}
var antinodes_gold = {}

func _ready() -> void:
	var y = 0
	for line in Main.lines:
		var row = []
		var i = 0
		y += 1
		for chr in line.strip_edges():
			i += 1 
			row.append(chr)
			if chr != ".":
				if chr not in frequencies:
					frequencies[chr] = []
				frequencies[chr].append(Vector2(i, y))
		input_grid.append(row)
	rows = input_grid.size()
	cols = input_grid[0].size()
	#print_grid()
	for frequency in frequencies:
		var coords = frequencies[frequency]
		for i in range(coords.size()):
			for j in range (i + 1, coords.size()):
				get_antinodes(coords[i], coords[j])
		#print("Character: ", frequency, " Coordinates: ", frequencies[frequency])
	silver = antinodes.size()
	gold = antinodes_gold.size()
	print(silver)
	print(gold)
	
	print_grid_with_antinodes()

func get_antinodes(a: Vector2, b: Vector2):
	var c: Vector2
	var d: Vector2
	c.x = a.x - (b.x - a.x)
	c.y = a.y - (b.y - a.y)
	d.x = b.x + (b.x - a.x)
	d.y = b.y + (b.y - a.y)
	if is_in_bounds(c.x, c.y):
		antinodes[c] = true
	if is_in_bounds(d.x, d.y):
		antinodes[d] = true
		
	var diff_c = Vector2(a.x - c.x, a.y - c.y)
	var diff_d = Vector2(d.x - b.x, d.y - b.y)
	var i = 0
	while true:
		var new_pos_c = Vector2(a.x + diff_c.x * i, a.y + diff_c.y * i)
		if is_in_bounds(new_pos_c.x, new_pos_c.y):
			antinodes_gold[new_pos_c] = true
		else:
			break
		i += 1
	i = 0
	while true:
		var new_pos_d = Vector2(b.x - diff_d.x * i, b.y - diff_d.y * i)
		if is_in_bounds(new_pos_d.x, new_pos_d.y):
			antinodes_gold[new_pos_d] = true
		else:
			break
		i += 1

func get_cell(position: Vector2):
	if is_in_bounds(position.x, position.y):
		return input_grid[int(position.y)][int(position.x)]

func is_in_bounds(x, y):
	return 0 <= x - 1 and x - 1 < cols and 0 <= y - 1 and y - 1 < rows

func print_grid():
	for row in input_grid:
		print("".join(row))

func print_grid_with_antinodes():
	var temp_grid = []
	for row in input_grid:
		temp_grid.append(row.duplicate())
	
	for antinode in antinodes_gold.keys():
		var x = int(antinode.x) - 1 
		var y = int(antinode.y) - 1
		if is_in_bounds(x, y):
			temp_grid[y][x] = "#"

	for row in temp_grid:
		print("".join(row))
