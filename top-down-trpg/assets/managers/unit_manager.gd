class_name UnitManager
extends Node2D

# setup resources etc
const CREATURE_SCENE = preload("res://assets/characters/creature.tscn")

var units: Array = []

func initialize_units():
	$Player/PlayerInputComponent.player_turn_complete.connect(_run_enemy_turns)
	$Player.load_character_start_json()
	
	units = get_children()
	if $Player not in units:
		push_error("NO PLAYER FOUND, CRITCAL ERROR")
		return
	units.remove_at(units.find($Player))
	
func start_turns():
	_run_player_turn()
	
func _run_player_turn():
	$Player.take_turn()

func _run_enemy_turns():
	for unit in units:
		# for some reason we need to wait two physics frames here so the raycasting can catch up and ensure no collisions
		await get_tree().physics_frame
		await get_tree().physics_frame
		unit.take_turn()
	_run_player_turn()

func spawn_random_creature(x_coord: int, y_coord: int):
	var new_creature_obj = CREATURE_SCENE.instantiate()
	var creature_dict = _select_random_creature()
	
	new_creature_obj.set_position(Vector2(x_coord, y_coord))
	new_creature_obj.setup_from_dict(creature_dict)
	add_child(new_creature_obj)

func _select_random_creature():
	var number_of_creatures = JsonAutoloads.creatures_dict["creatures"].size()
	var random_creature_index = randi_range(0,number_of_creatures-1)
	var creature_dict = JsonAutoloads.creatures_dict["creatures"][random_creature_index]
	return creature_dict
