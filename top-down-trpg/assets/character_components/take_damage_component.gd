class_name TakeDamageComponent
extends Node

@export var inventory_component: InventoryComponent
@export var attributes_component: AttributesComponent


var max_hitpoints: int = 10
var hitpoints: int  = 10
var coverage: float = 0
var material_tier: int = 0
var avoidance: float = 0

func _ready() -> void:
	inventory_component.changed_equipment.connect(_update_values)
	attributes_component.changed_attributes.connect(_update_values)
	

func print_values():
	print("max_hitpoints: ", max_hitpoints)
	print("hitpoints: ", hitpoints)
	print("coverage: ", coverage)
	print("material_tier: ", material_tier)
	print("avoidance: ", avoidance)

func take_damage(damage_value: int):
	hitpoints -= damage_value
	print(get_parent().name + " Damage taken: ", damage_value, " Health Remaining: ", hitpoints)
	return

func _update_values():
	var inv_calc_return = inventory_component.calculate_take_damage_stats_from_equipment()
	var inv_calc_cov = inv_calc_return[0]
	var inv_calc_mat_tier = inv_calc_return[1]
	var inv_calc_avoid =inv_calc_return[2]
	
	var att_calc_return = attributes_component.calculate_take_damage_stats_from_attributes()
	var att_calc_hp = att_calc_return[0]
	var att_calc_avoid = att_calc_return[1]
	
	var hitpoint_diff = att_calc_hp - max_hitpoints
	max_hitpoints = att_calc_hp
	hitpoints += hitpoint_diff
	coverage = inv_calc_cov
	material_tier = inv_calc_mat_tier
	avoidance = inv_calc_avoid + att_calc_avoid
