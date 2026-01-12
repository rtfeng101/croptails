extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var log_scene = preload("res://scenes/objects/trees/log.tscn")

# radius around tree where logs can fall
@export var log_drop_radius: float = 24.0
@export var log_count: int = 2

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)

func on_max_damage_reached() -> void:
	# wait to add logs until all other processes are done
	call_deferred("add_logs_scene")
	
	print("max damage reached")
	queue_free()

# add log to scene
func add_logs_scene() -> void:
	var parent_node := get_parent()

	for i in log_count:
		var log_instance := log_scene.instantiate() as Node2D

		# random offset inside a circle
		var offset := Vector2(
			randf_range(-log_drop_radius, log_drop_radius),
			randf_range(-log_drop_radius, log_drop_radius)
		)

		log_instance.global_position = global_position + offset
		parent_node.add_child(log_instance)
	
