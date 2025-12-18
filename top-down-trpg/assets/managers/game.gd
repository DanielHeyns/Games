class_name Game
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UnitManager.intialize_player()
	
	$UnitManager.spawn_random_creature(208.0, 112.0)
	$UnitManager.initialize_creatures_array()
	$UnitManager.start_turns()

	$UnitManager/Player.printout()
