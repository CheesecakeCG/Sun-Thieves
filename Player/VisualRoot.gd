extends Node3D

@onready var player : CharacterBody3D = get_parent()

var hold_rot : float

func _process(delta):
	var angle : float = player.motion_velocity_2d.angle() + PI
	var speed : float = player.motion_velocity.length()
	if not is_zero_approx(speed):
		rotation.y = lerp_angle(angle, rotation.y, delta * 1.2)
		hold_rot = rotation.y
		if player.is_in_a_ball:
			$BallForm.visible = true
			$LegForm.visible = false
			$BallForm.rotation.z += delta * speed
		else:
			$BallForm.visible = false
			$LegForm.visible = true
	else:
		rotation.y = hold_rot


func _on_Player_ball_state_changed(is_to_ball):
	pass # Replace with function body.
