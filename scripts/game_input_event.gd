class_name GameInputEvents

static var direction: Vector2

# return: Vector2 of input direction
static func movement_input() -> Vector2:
	# walking inputs
	if Input.is_action_pressed("walk_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("walk_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
		
	return direction

# return: bool if movement input
static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true

# return: bool if hit/left click
static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("hit")
	return use_tool_value
