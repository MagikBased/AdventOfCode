extends Node

var silver = 0
var gold = 0

func _ready() -> void:
	var input_sections = [[]]
	var section_one = []
	var section_two = []
	var rules = {}
	var fixed_updates = []
	
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

	for update in section_two:
		var update_pages = update.split(",") as Array
		for i in range(update_pages.size()):
			update_pages[i] = update_pages[i].to_int()
		
		if is_valid_update(update_pages, rules):
			#print("Valid update: ", update_pages)
			silver += update_pages[int(update_pages.size() / 2)]
		else:
			#print("Invalid update: ", update_pages)
			#print(update_pages)
			while not is_valid_update(update_pages, rules):
				for i in range(update_pages.size()):
					var page_a = update_pages[i]
					var page_b = update_pages[i+1]
					if page_a not in rules or page_b not in rules[page_a]:
						var temp = update_pages[i]
						update_pages.remove_at(i)
						update_pages.append(temp)
						#print(update_pages)
						break
					else:
						continue
			fixed_updates.append(update_pages)
	#print("Fixed updates: ",fixed_updates)
	for fixed_update in fixed_updates:
		gold += fixed_update[int(fixed_update.size() / 2)]

	print("Part One: ", silver)
	print("Part Two: ", gold)

func is_valid_update(update_pages: Array, rules: Dictionary) -> bool:
	var page_indexes = {}
	for k in range(update_pages.size()):
		page_indexes[update_pages[k]] = k
	for page in update_pages:
		if rules.has(page):
			for after_page in rules[page]:
				if update_pages.has(after_page) and page_indexes[after_page] < page_indexes[page]:
					return false
	return true
