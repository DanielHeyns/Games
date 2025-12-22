class_name InventoryComponent
extends Node

signal changed_equipment

var inventory_strings: Array[String]
var head_slot_string: String
var torso_slot_string: String
var gloves_slot_string: String
var shoes_slot_string: String
var melee_weapon_slot_string: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func print_equipment():
	print("head: ", head_slot_string)
	print("torso: ", torso_slot_string)
	print("gloves: ", gloves_slot_string)
	print("shoes: ", shoes_slot_string)
	print("melee weapon: ", melee_weapon_slot_string)

func add_item(item_string:String):
	inventory_strings.append(item_string)

func remove_item(item_string:String):
	inventory_strings.erase(item_string)

func equip_items(items_array: Array):
	for item in items_array:
		equip(item, false)
	changed_equipment.emit()
	return

func equip(item_string:String, fire_the_signal:bool = true):
	var item = JsonAutoloads.get_full_item_dict(item_string)
	match item["slot"]:
		"head_slot":
			head_slot_string = item_string
		"torso_slot":
			torso_slot_string = item_string
		"gloves_slot":
			gloves_slot_string = item_string
		"shoes_slot":
			shoes_slot_string = item_string
		"melee_weapon_slot":
			melee_weapon_slot_string = item_string
		_:
			push_error("Unknown slot type: " + item["slot"])
			return
			
	remove_item(item_string)
	if fire_the_signal:
		changed_equipment.emit()
	
func calculate_take_damage_stats_from_equipment() -> Array:
	var calculated_coverage: int = 0
	var calculated_material_tier: int = 0
	var calulated_avoidance:int = 0
	
	if torso_slot_string:
		var torso_item_full_dict = JsonAutoloads.get_full_item_dict(torso_slot_string)
		calculated_coverage = torso_item_full_dict["coverage"]
		calculated_material_tier = torso_item_full_dict["material_tier"]
		calulated_avoidance = torso_item_full_dict["avoidance"]
	
	# TODO: As we add more items and flesh out stats and stuff, there will probably be more things to take into account from the equipment side
	
	return [calculated_coverage, calculated_material_tier, calulated_avoidance]

func calculate_melee_attack_stats_from_equipment() -> Array:
	var calculated_precision: int = 0
	var calculated_puncture: int =0
	var calculated_damage_die: int = 0
	var calculated_impact: int = 0
	var calculated_material_tier: int = 0
	var is_heavy: bool = false
	
	if melee_weapon_slot_string:
		var melee_weapon_item_full_dict = JsonAutoloads.get_full_item_dict(melee_weapon_slot_string)
		calculated_precision = melee_weapon_item_full_dict["precision"]
		calculated_puncture = melee_weapon_item_full_dict["puncture"]
		calculated_damage_die = melee_weapon_item_full_dict["damage_die"]
		calculated_impact = melee_weapon_item_full_dict["impact"]
		calculated_material_tier = melee_weapon_item_full_dict["material_tier"]
		is_heavy = melee_weapon_item_full_dict["is_heavy"]
	# TODO: As we add more items and flesh out stats and stuff, there will probably be more things to take into account from the equipment side
	return [calculated_precision, calculated_puncture, calculated_damage_die, calculated_impact, calculated_material_tier, is_heavy]
	
