class_name Player
extends CharacterBody2D

func take_turn():
	$PlayerInputComponent.enable_input()

func load_character_start_json():
	var starting_attributes = JsonAutoloads.character_start_dict["attributes"]
	$AttributesComponent.setup_initial_values(
		starting_attributes["strength"],
		starting_attributes["agility"],
		starting_attributes["toughness"],
		starting_attributes["intelligence"],
		starting_attributes["magic_potential"]
	)
	
	var starting_items = JsonAutoloads.character_start_dict.get("equipment", [])
	$InventoryComponent.equip_items(starting_items)
	return

func printout():
	print("Player: ")
	$AttributesComponent.print_attributes()
	$InventoryComponent.print_equipment()
	$TakeDamageComponent.print_values()
