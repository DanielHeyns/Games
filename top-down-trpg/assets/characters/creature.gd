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
	$TakeDamageComponent.setup_initial_values(
		creature_dict["hitpoints"], 
		creature_dict["coverage"], 
		creature_dict["material_tier"], 
		creature_dict["avoidance"]
	)
