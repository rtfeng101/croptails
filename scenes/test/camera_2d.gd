extends Camera2D

@onready var player: Node2D = get_parent()

var shake_offset := Vector2.ZERO

func _process(delta):
	# 1. Read player position (float precision)
	var base_pos: Vector2 = player.global_position

	# 2. Quantize ONLY the base origin
	var stable_base := base_pos.floor()

	# 3. Apply sub-pixel shake on top
	global_position = stable_base + shake_offset
