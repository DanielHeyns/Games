extends Node


@export var move_component: MoveComponent
@export var ray_casting_component: RayCastingComponent
@export var melee_attack_component: MeleeAttackComponent

func move():
	var dir: Vector2 = Vector2(randi_range(-1, 1),randi_range(-1, 1))
	var adjacent_obj = ray_casting_component.check(dir)
	var damage_component = adjacent_obj.get_node_or_null("TakeDamageComponent") if adjacent_obj else false
	if not adjacent_obj:
		move_component._move(dir)
	elif damage_component:
		melee_attack_component.attack(damage_component)
