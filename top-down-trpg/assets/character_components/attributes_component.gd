class_name AttributesComponent
extends Node

signal changed_attributes

var strength: int
var agility: int
var toughness: int
var intelligence: int
var magic_potential: int

@warning_ignore("shadowed_variable")
func setup_initial_values(strength:int, agility:int, toughness: int, intelligence: int, magic_potential:int):
	self.strength = strength
	self.agility = agility
	self.toughness = toughness
	self.intelligence = intelligence
	self.magic_potential= magic_potential
	
	changed_attributes.emit()

func calculate_take_damage_attributes_from_attributes():
	var calc_hitpoints = 10 + toughness * 5
	var calc_avoidance = 0.1 + agility * 0.1
	return [calc_hitpoints, calc_avoidance]
