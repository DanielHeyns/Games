class_name MoveComponent 
extends Node

@export var sprite: Sprite2D

const tile_size: Vector2 = Vector2(32, 32)
var sprite_node_pos_tween: Tween

func _move(dir: Vector2):
	get_parent().global_position += dir * tile_size
	sprite.global_position -= dir * tile_size
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property(sprite, "global_position", get_parent().global_position, 0.1).set_trans(Tween.TRANS_SINE)
