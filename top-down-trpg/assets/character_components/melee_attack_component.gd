class_name MeleeAttackComponent
extends Node

@export var inventory_component: InventoryComponent
@export var attributes_component: AttributesComponent

var accuracy: float #TODO ADD IN ACCURACY
var precision: float
var puncture: float
var damage: String
var armor_ignore: float
var material_tier: int

func _ready() -> void:
	inventory_component.changed_equipment.connect(_update_values)
	attributes_component.changed_attributes.connect(_update_values)

func _update_values():
	var inv_calc_return = inventory_component.calculate_melee_attack_stats_from_equipment()
	var inv_calc_prec = inv_calc_return[0]
	var inv_calc_punc = inv_calc_return[1]
	var inv_calc_dmg = inv_calc_return[2]
	var inv_calc_arm_ign =inv_calc_return[3]
	var inv_calc_mat_tier = inv_calc_return[4]
	
	var att_calc_return = attributes_component.calculate_melee_attack_stats_from_attributes()
	var att_calc_prec = att_calc_return[0]
	var att_calc_punc = att_calc_return[1]
	
	precision = inv_calc_prec + att_calc_prec
	puncture = inv_calc_punc + att_calc_punc
	damage = inv_calc_dmg
	armor_ignore = inv_calc_arm_ign
	material_tier = inv_calc_mat_tier
	
func attack(tdc: TakeDamageComponent):
	
	tdc.take_damage(5)
