extends CharacterBody3D

signal ball_state_changed(is_to_ball)

@export_range(0.1, 100) var speed : float
@export_range(0.1, 100) var jump_force : float
@export_range(0, 1) var fric_on_legs : float
@export_range(0, 1) var fric_in_ball : float

var motion_velocity_2d : Vector2 = Vector2()

var is_in_a_ball : bool = false: 
	set(v):
		if v != is_in_a_ball:
			is_in_a_ball = v
			need_to_change_ball_state = true
			ball_state_changed.emit(v)
		else:
			need_to_change_ball_state = false

var need_to_change_ball_state : bool = false

func _input(event):
	if event.is_action_pressed("p_change_form"):
		is_in_a_ball = !is_in_a_ball
	if event.is_action_released("p_jump"):
		if motion_velocity.y > 0:
			motion_velocity.y /= 2

func _physics_process(delta):

	var dir : Vector2 = Input.get_vector("p_back", "p_forw", "p_left", "p_right")
	if not is_zero_approx(dir.length_squared()):
		is_in_a_ball = true
	if not is_in_a_ball:
		dir = Vector2()
	if need_to_change_ball_state:
		if is_in_a_ball:
			$SphereShape.disabled = false
			$CapsuleShape.disabled = true
			need_to_change_ball_state = false
		else:
			$CapsuleShape.disabled = false
			$SphereShape.disabled = true
			need_to_change_ball_state = false
			
	
	var dir3 : Vector3 = Vector3(dir.y, Input.get_action_strength("p_jump"), -dir.x)
	motion_velocity += dir3 * Vector3(speed, float(is_on_floor_only()) * jump_force, speed)
	for i in range(get_slide_collision_count()):
		var c : KinematicCollision3D = get_slide_collision(i)
		motion_velocity += speed * c.get_remainder().bounce(c.get_normal())
		
	move_and_slide()
	var y : float = motion_velocity.y - 12 * delta
	
	if is_in_a_ball:
		motion_velocity *= fric_in_ball
	else:
		if is_on_floor():
			motion_velocity *= fric_on_legs
	motion_velocity.y = y
	
	motion_velocity_2d = Vector2(motion_velocity.x, motion_velocity.z)
	
	
	
	


