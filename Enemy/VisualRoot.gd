extends Node3D

@onready var actor : CharacterBody3D = get_parent()

var hold_rot : float

func _process(delta):
	var angle : float = actor.motion_velocity_2d.angle() + PI
	var speed : float = actor.motion_velocity.length()
	if not is_zero_approx(speed):
		rotation.y = lerp_angle(angle, rotation.y, delta * 1.2)
		hold_rot = rotation.y
	else:
		rotation.y = hold_rot
