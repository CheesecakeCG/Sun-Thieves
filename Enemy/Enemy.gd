extends CharacterBody3D

signal ball_state_changed(is_to_ball)

@export_range(0.1, 100) var speed : float
@export_range(0.1, 100) var jump_force : float
@export_range(0, 1) var fric : float

var motion_velocity_2d : Vector2 = Vector2()
@export_node_path(Node3D) var follow_path
@onready var follow : Node3D = get_node(follow_path)

@onready var nav : NavigationAgent3D = $Nav

func _ready():
	pass

func _physics_process(delta):
	nav.set_target_location(follow.global_transform.origin)
	var dir3 : Vector3 = nav.get_next_location() - global_transform.origin 
	
	dir3.y = 0
	motion_velocity += dir3.normalized() * Vector3(speed, jump_force, speed) 
	
	move_and_slide()
	
	var y : float = motion_velocity.y - 9.81 * delta
	
	if is_on_floor():
		motion_velocity *= fric
	motion_velocity.y = y
	
	nav.set_velocity(motion_velocity)
	
	motion_velocity_2d = Vector2(motion_velocity.x, motion_velocity.z)


func _on_Nav_velocity_computed(safe_velocity):
	motion_velocity = safe_velocity
	pass
	
