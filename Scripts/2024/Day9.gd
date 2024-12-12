extends Node

var silver = 0
var gold = 0

var diskmap = []
var system_blocks = []
var system_blocks_silver = []
var system_blocks_gold = []

func _ready() -> void:
	for lines in Main.lines:
		for chr in lines.strip_edges():
			diskmap.append(chr.to_int())
		system_blocks = make_filesystem()
		system_blocks_silver = system_blocks.duplicate()
		system_blocks_gold = system_blocks.duplicate()
		system_blocks_silver = move_data_silver(system_blocks_silver)
		move_data_gold(system_blocks_gold)

	print(system_blocks_gold)
	silver = get_checksum(system_blocks_silver)
	gold = get_checksum(system_blocks_gold)
	print("Part One: ", silver)
	print("Part Two: ", gold)
	
func make_filesystem():
	var id = 0 
	var blocks = []
	for i in range(diskmap.size()):
		if i % 2 == 0:
			for j in range(diskmap[i]):
				blocks.append(id)
			id += 1
		else:
			for k in range(diskmap[i]):
				blocks.append(null)
	return blocks

func get_checksum(filesystem: Array) -> int:
	var checksum = 0
	for x in range(filesystem.size()):
		if filesystem[x] != null:
			checksum += x * filesystem[x]
	return checksum
	

func move_data_silver(filesystem: Array):
	var first_free = 0
	while filesystem[first_free] != null:
		first_free += 1
	var i = filesystem.size() - 1
	while filesystem[i] == null:
		i -= 1
	while i > first_free:
		filesystem[first_free] = filesystem[i]
		filesystem[i] = null
		while filesystem[i] == null:
			i -= 1
		while filesystem[first_free] != null:
			first_free += 1
	return filesystem

func move_data_gold(filesystem: Array):
	var first_free = 0
	var i = filesystem.size() - 1
	
