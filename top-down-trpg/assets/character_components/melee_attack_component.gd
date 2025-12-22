class_name MeleeAttackComponent
extends Node

@export var inventory_component: InventoryComponent
@export var attributes_component: AttributesComponent

var accuracy: int #TODO ADD IN ACCURACY
var precision: int
var puncture: int
var damage_die: int
var impact: float
var material_tier: int

func _ready() -> void:
	inventory_component.changed_equipment.connect(_update_values)
	attributes_component.changed_attributes.connect(_update_values)

func _update_values():
	var inv_calc_return = inventory_component.calculate_melee_attack_stats_from_equipment()
	var inv_calc_prec = inv_calc_return[0]
	var inv_calc_punc = inv_calc_return[1]
	var inv_calc_dmg_die = inv_calc_return[2]
	var inv_calc_imp =inv_calc_return[3]
	var inv_calc_mat_tier = inv_calc_return[4]
	var inv_is_heavy = inv_calc_return[5]
	
	var att_calc_return = attributes_component.calculate_melee_attack_stats_from_attributes()
	var att_calc_acc_not_h = att_calc_return[0]
	var att_calc_acc_h = att_calc_return[1]
	var att_calc_punc = att_calc_return[2]
	
	accuracy = att_calc_acc_h if inv_is_heavy else att_calc_acc_not_h
	precision = inv_calc_prec
	puncture = inv_calc_punc + att_calc_punc
	damage_die = inv_calc_dmg_die
	impact = inv_calc_imp
	material_tier = inv_calc_mat_tier
	
func attack(tdc: TakeDamageComponent):
	tdc.receive_attack(accuracy, precision, puncture, material_tier, impact, damage_die)
