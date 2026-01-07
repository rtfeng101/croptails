extends NodeState

# use Player class for dynamic directions
@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite_2d.play("walk_back")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("walk_right")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("walk_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("walk_left")
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	# move player based on input
	player.velocity = direction * speed
	# moves player based on velocity, has collision effects
	player.move_and_slide()

# transition out of walk
func _on_next_transitions() -> void:
	# to idle
	if GameInputEvents.is_movement_input() == false:
		transition.emit("Idle")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
