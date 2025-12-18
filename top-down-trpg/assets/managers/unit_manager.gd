class_name UnitManager
extends Node2D

# setup resources etc
const CREATURE_SCENE = preload("res://assets/characters/creature.tscn")

var creatures: Array = []

func intialize_player():
	$Player/PlayerInputComponent.player_turn_complete.connect(_run_enemy_turns)
	$Player.load_character_start_json()

func initialize_creatures_array():
	creatures = get_children()
	if $Player not in creatures:
		push_error("NO PLAYER FOUND, CRITCAL ERROR")
		return
	creatures.remove_at(creatures.find($Player))
	
func start_turns():
	_run_player_turn()
	
func _run_player_turn():
	$Player.take_turn()

func _run_enemy_turns():
	for creature in creatures:
		# for some reason we need to wait two physics frames here so the raycasting can catch up and ensure no collisions
		await get_tree().physics_frame
		await get_tree().physics_frame
		creature.take_turn()
	_run_player_turn()

func spawn_random_creature(x_coord: int, y_coord: int):
	var new_creature_obj = CREATURE_SCENE.instantiate()
	var creature_dict = _select_random_creature()
	add_child(new_creature_obj)
	
	new_creature_obj.set_position(Vector2(x_coord, y_coord))
	new_creature_obj.setup_from_dict(creature_dict)
	new_creature_obj.printout()

func _select_random_creature():
	var number_of_creatures = JsonAutoloads.creatures_dict["creatures"].size()
	var random_creature_index = randi_range(0,number_of_creatures-1)
	var creature_dict = JsonAutoloads.creatures_dict["creatures"][random_creature_index]
	return creature_dict
