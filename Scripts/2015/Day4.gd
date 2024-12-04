extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var secret_key = Main.lines[0]
	var five_zeroes_found = false
	var i = 0
	
	while true:
		var input_string = secret_key + str(i)
		var hash_context = HashingContext.new()
		hash_context.start(HashingContext.HASH_MD5)
		hash_context.update(input_string.to_utf8_buffer())
		var advent_hash = hash_context.finish().hex_encode()

		if not five_zeroes_found and advent_hash.begins_with("00000"):
			silver = i
			five_zeroes_found = true 

		if advent_hash.begins_with("000000"):
			gold = i
			break
		i += 1
	
	print("Part One: ", silver)
	print("Part Two: ", gold)
