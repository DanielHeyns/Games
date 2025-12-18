class_name AttributesComponent
extends Node

signal changed_attributes

var strength: int
var agility: int
var toughness: int
var intelligence: int
var magic_potential: int

func print_attributes():
	print("strength: ", strength)
	print("agility: ", agility)
	print("toughness: ", toughness)
	print("intelligence: ", intelligence)
	print("magic_potential: ", magic_potential)
	
@warning_ignore("shadowed_variable")
func setup_initial_values(strength:int, agility:int, toughness: int, intelligence: int, magic_potential:int):
	self.strength = strength
	self.agility = agility
	self.toughness = toughness
	self.intelligence = intelligence
	self.magic_potential= magic_potential
	
	changed_attributes.emit()

func calculate_take_damage_stats_from_attributes():
	var calc_hitpoints = 10 + toughness * 5
	var calc_avoidance = 0.1 + agility * 0.1
	return [calc_hitpoints, calc_avoidance]

func calculate_melee_attack_stats_from_attributes():
	var calc_precision = 0.1 * agility
	var calc_puncture = 0.1 * strength
	return [calc_puncture, calc_precision]
