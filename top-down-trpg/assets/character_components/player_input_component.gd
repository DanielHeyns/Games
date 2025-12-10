class_name PlayerInputComponent
extends Node

@export var move_component: MoveComponent
@export var ray_casting_component: RayCastingComponent
@export var melee_attack_component: MeleeAttackComponent

signal player_turn_complete

const INPUT_DIRECTIONS := {
	"ui_up": Vector2(0, -1),
	"ui_down": Vector2(0, 1),
	"ui_left": Vector2(-1, 0),
	"ui_right": Vector2(1, 0),

	"ui_up_left": Vector2(-1, -1),
	"ui_up_right": Vector2(1, -1),
	"ui_down_left": Vector2(-1, 1),
	"ui_down_right": Vector2(1, 1),
	
	"pass_turn": Vector2(0,0)
}

func _ready():
	set_process_input(false)

func enable_input():
	set_process_input(true)

func disable_input():
	set_process_input(false)
	
	
func _input(event: InputEvent):
	if not event is InputEventKey:
		return
	
	if not event.is_pressed():
		return
		
	for action: String in INPUT_DIRECTIONS.keys():
		if Input.is_action_just_pressed(action):
			var dir = INPUT_DIRECTIONS[action]
			var adjacent_obj = ray_casting_component.check(dir)
			var damage_component = adjacent_obj.get_node_or_null("TakeDamageComponent") if adjacent_obj else false
			if not adjacent_obj:
				move_component._move(dir)
				disable_input()
				player_turn_complete.emit()
			elif damage_component:
				melee_attack_component.attack(damage_component)
				disable_input()
				player_turn_complete.emit()
			return
