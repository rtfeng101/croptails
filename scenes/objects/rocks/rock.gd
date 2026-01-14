extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

# radius around tree where logs can fall
@export var rock_drop_radius: float = 24.0
@export var rock_count: int

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", .30)
	await get_tree().create_timer(0.25).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	# wait to add logs until all other processes are done
	call_deferred("add_stone_scene")
	
	print("max damage reached")
	queue_free()

# add log to scene
func add_stone_scene() -> void:
	var parent_node := get_parent()

	for i in rock_count:
		var stone_instance := stone_scene.instantiate() as Node2D

		# random offset inside a circle
		var offset := Vector2(
			randf_range(-rock_drop_radius, rock_drop_radius),
			randf_range(-rock_drop_radius, rock_drop_radius)
		)

		stone_instance.global_position = global_position + offset
		parent_node.add_child(stone_instance)
	
