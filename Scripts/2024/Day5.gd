extends Node

var silver = 0
var gold = 0


func _ready() -> void:
	var input_sections = [[]]
	var section_one = []
	var section_two = []
	var rules = {}
	for line in Main.lines:
		if line.is_empty():
			input_sections.append([])
		else:
			input_sections[-1].append(line.strip_edges())
	if input_sections.size() > 1:
		section_one = input_sections[0]
		section_two = input_sections[1]
	for rule in section_one:
		var pages = rule.split("|")
		var before = pages[0].to_int()
		var after = pages[1].to_int()
		if not rules.has(before):
			rules[before] = []
		rules[before].append(after)
	print(rules)
	for update in section_two:
		var update_pages = update.split(",") as Array
		for i in range(update_pages.size()):
			update_pages[i] = update_pages[i].to_int()
		#print("update pages: ",update_pages)
		var page_indexes = {}
		for k in range(update_pages.size()):
			page_indexes[update_pages[k]] = k
		var is_valid_update = true
		for page in update_pages:
			if rules.has(page):
				for after_page in rules[page]:
					if update_pages.has(after_page) and page_indexes[after_page] < page_indexes[page]:
						is_valid_update = false
						break
			if not is_valid_update:
				break
		if is_valid_update:
			#print("Valid update: ", update_pages)
			silver += update_pages[update_pages.size()/2]
		else:
			pass
			#print("Invalid update: ", update_pages)

				
		
	print("Part One: ",silver)
	print("Part Two: ",gold)
 
