extends Node

func _ready():
#	set_physics_process(false)
	pass


func _on_Timer_timeout():
	$Timer.wait_time = randf_range(0.1, 0.2)
	$Gun.target = get_parent().follow
	return
	$RayCast3D.look_at(get_parent().follow.global_transform.origin)
	
	$RayCast3D.force_raycast_update()
	if $RayCast3D.is_colliding():
		if $RayCast3D.get_collider() == $Gun.target:
#			await get_tree().create_timer(0.1).timeout
			$RayCast3D.enabled = true
			set_physics_process(true)
		else:
			$RayCast3D.enabled = false
			set_physics_process(false)

func _physics_process(delta):
	$RayCast3D.look_at(get_parent().follow.global_transform.origin)
	if $RayCast3D.is_colliding():
		if $RayCast3D.get_collider() == $Gun.target:
			$Gun.trigger_held = true
#			print("skittle skittle ", owner)
			await $Gun.fire()

			return
	
	$Gun.trigger_held = false
	
