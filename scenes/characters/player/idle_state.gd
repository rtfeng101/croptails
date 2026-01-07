extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	# idle animation based on direction
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	else:
		animated_sprite_2d.play("idle_front")

# transition out of idle
func _on_next_transitions() -> void:
	# updates the shared input state
	GameInputEvents.movement_input()
	
	# to walk
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	
	# axe
	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvents.use_tool():
		transition.emit("Chopping")
	
	# till
	if player.current_tool == DataTypes.Tools.TillGround && GameInputEvents.use_tool():
		transition.emit("Tilling")
	
	# watering
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvents.use_tool():
		transition.emit("Watering")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	# stop idle animation (next state will handle own animations)
	animated_sprite_2d.stop()
