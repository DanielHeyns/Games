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

func add_item(item_string:String):
	inventory_strings.append(item_string)

func remove_item(item_string:String):
	inventory_strings.erase(item_string)

func equip(item_string:String):
	if item_string not in inventory_strings:
		push_error("ITEM NOT IN INVENTORY: " + item_string)
		return
	
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
	changed_equipment.emit()
	
func calculate_take_damage_attributes_from_equipment() -> Array:
	var calculated_coverage: float = 0
	var calculated_material_tier: float = 0
	var calulated_avoidance:float = 0
	
	if torso_slot_string:
		var torso_item_full_dict = JsonAutoloads.get_full_item_dict(torso_slot_string)
		calculated_coverage = torso_item_full_dict["coverage"]
		calculated_material_tier = torso_item_full_dict["material_tier"]
		calulated_avoidance = torso_item_full_dict["avoidance"]
	
	# TODO: As we add more items and flesh out stats and stuff, there will probably be more things to take into account from the equipment side
	
	return [calculated_coverage, calculated_material_tier, calulated_avoidance]
