class_name TakeDamageComponent
extends Node

@export var inventory_component: InventoryComponent
@export var attributes_component: AttributesComponent

var hf = HelperFunctions
const BASE_DICE_POOL: int = 4

enum HIT_TYPE {MISS = 0, TRUE_HIT = 1, IMPACT_HIT = 2}

var max_hitpoints: int = 10
var hitpoints: int  = 10
var coverage: int = 0
var material_tier: int = 0
var avoidance: int = 0

func _ready() -> void:
	inventory_component.changed_equipment.connect(_update_values)
	attributes_component.changed_attributes.connect(_update_values)
	

func print_values():
	print("max_hitpoints: ", max_hitpoints)
	print("hitpoints: ", hitpoints)
	print("coverage: ", coverage)
	print("material_tier: ", material_tier)
	print("avoidance: ", avoidance)

func receive_attack(atk_acc: int, atk_prec: int, atk_punc: int, atk_mat_tier: int, atk_imp: float, atk_dmg_die: int):
	var hit_scored: int = HIT_TYPE.MISS
	var dmg_dice_multi: int = 0
	
	# --- 1. ACCURACY ---
	var hit_dice_pool = max(1, BASE_DICE_POOL + atk_acc - avoidance)
	var hit_result = hf.roll_for_sixes(hit_dice_pool)
	
	if hit_result == 0:
		print("Attack on %s missed!" % get_parent().name)
		return # attack missed
		
	# --- 2. ARMOR ---
	if material_tier == 0: # No armor = hit
		dmg_dice_multi = hit_result
		hit_scored = HIT_TYPE.TRUE_HIT
		print("Attack on %s hit with no armor!" % get_parent().name)
	else:
		# try precision
		var prec_pool = max(1, BASE_DICE_POOL + atk_prec + (hit_result - 1) - coverage)
		var prec_result = hf.roll_for_sixes(prec_pool)
		
		if prec_result >= 1:
			dmg_dice_multi = prec_result
			hit_scored = HIT_TYPE.TRUE_HIT
			print("Attack on %s hit with precision! Precision pool: %d, Precision result: %d" % [get_parent().name, prec_pool, prec_result])
			
		# try puncture
		elif atk_mat_tier >= material_tier:
			var punc_pool = max(1, atk_punc + (atk_mat_tier - material_tier))
			var punc_result = hf.roll_for_sixes(punc_pool)
			
			if punc_result >= 1:
				dmg_dice_multi = punc_result
				hit_scored = HIT_TYPE.TRUE_HIT
				print("Attack on %s hit with puncture! Puncture pool: %d, Puncture result: %d" % [get_parent().name, punc_pool, punc_result])
			elif atk_imp > 0:
				hit_scored = HIT_TYPE.IMPACT_HIT
				print("Attack on %s hit with impact! Impact: %d" % [get_parent().name, atk_imp])
				
		# precision and puncturing failed, try impact
		elif atk_imp > 0:
			hit_scored = HIT_TYPE.IMPACT_HIT
			print("Attack on %s hit with impact! Impact: %d" % [get_parent().name, atk_imp])

	# --- 3. DAMAGE ---
	if hit_scored != HIT_TYPE.MISS:
		# scales with mat tier
		var num_dice = atk_mat_tier * dmg_dice_multi
		var damage_value = hf.roll_dice(num_dice, atk_dmg_die)
		
		# impact hits
		if hit_scored == HIT_TYPE.IMPACT_HIT:
			damage_value *= atk_imp
			
		hitpoints -= damage_value
		
		print("%s took %d damage (dmg_dice_multi: %d). Health: %d" % [get_parent().name, damage_value, dmg_dice_multi, hitpoints])

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
