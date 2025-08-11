extends CharacterBody2D


const SPEED = 130.0
const ROLLING_SPEED = 200
const ROLLING_DISTANCE = 70
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer: Timer = $JumpBuffer

enum States {IDLE, RUNNING, JUMPING, FALLING, ROLLING}
var state: States = States.IDLE: set = _set_state
var rolling_direction = 0
var distance_rolled = 0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var previous_velocity_y = velocity.y
	
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# handle state changes
	if state == States.IDLE and direction != 0:
		state = States.RUNNING
	elif state in [States.IDLE, States.RUNNING] \
	 and (Input.is_action_just_pressed("jump") or not jump_buffer.is_stopped()):
		state = States.JUMPING
	elif state == States.FALLING and not coyote_timer.is_stopped() and Input.is_action_just_pressed("jump"):
		state = States.JUMPING
	elif state in [States.IDLE, States.RUNNING] and Input.is_action_just_pressed("roll") and direction != 0:
		state = States.ROLLING
		rolling_direction = direction
		distance_rolled = 0
	elif state == States.JUMPING and velocity.y < 0:
		state = States.FALLING
	elif state == States.FALLING and is_on_floor() and direction != 0:
		state = States.RUNNING
	elif state == States.RUNNING and not is_on_floor():
		state = States.FALLING
	elif state == States.ROLLING and distance_rolled > ROLLING_DISTANCE:
		state = States.IDLE
	elif is_on_floor() and direction == 0 and state != States.ROLLING:
		state = States.IDLE
		
	# set timers
	if state == States.FALLING and Input.is_action_just_pressed("jump"):
		jump_buffer.start()
	
	# handle state execution
	if state == States.IDLE:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	elif state == States.RUNNING:
		velocity.x = direction * SPEED
	elif state == States.JUMPING:
		velocity.y = JUMP_VELOCITY
	elif state == States.FALLING:
		velocity.x = lerp(velocity.x, direction * SPEED, 0.15)
		velocity.y = lerp(previous_velocity_y, velocity.y, 0.9)
		if Input.is_action_just_released("jump"):
			velocity.y *= 0.4
	elif state == States.ROLLING:
		velocity.x = ROLLING_SPEED * rolling_direction
		distance_rolled += ROLLING_SPEED * delta
	
		
	# handle sprite direction
	if state != States.ROLLING:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
	print("velocity.x: ", velocity.x)
	move_and_slide()
	

func _set_state(new_state: int) -> void:
	#entering states
	if new_state == States.IDLE:
		animated_sprite.play("idle")
	elif new_state == States.RUNNING:
		animated_sprite.play("run")
	elif new_state == States.ROLLING:
		animated_sprite.play("roll")
		set_collision_layer_value(2, false)
	elif new_state == States.JUMPING:
		animated_sprite.play("jump")
	elif new_state == States.FALLING:
		animated_sprite.play("jump")
		if state == States.RUNNING: # check old stated
			coyote_timer.start()
	
	# exiting statesa
	if state == States.ROLLING:
		set_collision_layer_value(2, true)
	state = new_state
