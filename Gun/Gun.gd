extends Node3D

@export var bullet : PackedScene

@export_node_path(Node3D) var target_path
var target : Node3D 

@onready var last_target_pos : Vector3 = Vector3()

@export var burst_length : int = 1
@export var rounds_per_minute : float = 600
@export_flags_3d_physics var bullet_collsion_layer : int
@export_flags_3d_physics var bullet_collsion_mask : int

var trigger_held : bool = false

func _ready():
	if target_path != null:
		target_path = get_node_or_null(target_path)
		last_target_pos = target.global_transform.origin

func _process(delta):
	if not is_instance_valid(target):
		return
	var p : Vector3 =  (last_target_pos - target.global_transform.origin) * delta 
	look_at(target.global_transform.origin + p)

func fire():
	var fire_count : int = 0
	while trigger_held:
		if burst_length != -1 and fire_count > burst_length:
			break
		bang()
		fire_count += 1
		await get_tree().create_timer(rounds_per_minute/3600).timeout

signal bangged
func bang():
	var b : RigidDynamicBody3D = bullet.instantiate()
	get_tree().root.add_child(b)
	b.global_transform.basis = global_transform.basis
	b.collision_layer = bullet_collsion_layer
	b.collision_mask = bullet_collsion_mask
	bangged.emit()
