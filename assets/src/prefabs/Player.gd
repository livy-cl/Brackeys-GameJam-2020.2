extends Actor

func _physics_process(_delta: float) -> void:
	var animation: = "PlayerJump"
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, Vector2.UP)
	animation = AnimationChooser(animation, velocity)
	#print(animation)
	get_node("AnimationPlayer").play(animation)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func AnimationChooser(animation, velocity):
	if not velocity.y == 0:
		#print(velocity.y)
		animation = "PlayerJump"
	if not Input.get_action_strength("jump") == 0 and not is_on_floor():
		animation = "PlayerJump"
	elif velocity.x > 0:
		animation = "PlayerRunRight"
	elif velocity.x < 0:
		animation = "PlayerRunLeft"
	else:
		animation = "PlayerIdle"
		
	return animation
	
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = gravity * 0.0
	return new_velocity