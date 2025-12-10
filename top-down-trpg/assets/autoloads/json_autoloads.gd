extends Node

var items_dict = JSON.parse_string(FileAccess.get_file_as_string("res://resources/jsons/items.json"))
var materials_dict = JSON.parse_string(FileAccess.get_file_as_string("res://resources/jsons/materials.json"))
var creatures_dict = JSON.parse_string(FileAccess.get_file_as_string("res://resources/jsons/creatures.json"))
var character_start_dict = JSON.parse_string(FileAccess.get_file_as_string("res://resources/jsons/character_start.json"))

func get_full_item_dict(torso_slot_string:String) -> Dictionary:
	var item_dict = items_dict["items"][torso_slot_string]
	var base_item_dict = items_dict["base_items"][item_dict["inherits"]]
	for i in base_item_dict.keys():
		item_dict[i] = base_item_dict[i]
	return item_dict
