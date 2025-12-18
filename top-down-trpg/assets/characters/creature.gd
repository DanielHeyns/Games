class_name Creature
extends CharacterBody2D

func take_turn():
	$RandomMovementComponent.move()

func _set_sprite_from_dict(creature_dict):
	$Sprite2D.texture = load("res://resources/art/" + creature_dict["spriteArt"]["fileName"])
	$Sprite2D.region_enabled = true
	$Sprite2D.region_rect = Rect2(creature_dict["spriteArt"]["x"], creature_dict["spriteArt"]["y"] ,32, 32)

func setup_from_dict(creature_dict):
	_set_sprite_from_dict(creature_dict)
	name = creature_dict["name"]
	$AttributesComponent.setup_initial_values(
		creature_dict["strength"],
		creature_dict["agility"],
		creature_dict["toughness"],
		creature_dict["intelligence"],
		creature_dict["magic_potential"]
	)
	$InventoryComponent.equip_items(creature_dict.get("equipment", []))

func printout():
	print("Name: ", name)
	$AttributesComponent.print_attributes()
	$InventoryComponent.print_equipment()
	$TakeDamageComponent.print_values()
