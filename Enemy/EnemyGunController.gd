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
	if $RayCast3D.global_transform.basis.z.dot(get_parent().follow.global_transform.basis.z) > 0:
		$Gun.trigger_held = true
		await $Gun.fire()
		if $RayCast3D.is_colliding():
			print($RayCast3D.get_collider())
			if $RayCast3D.get_collider() == $Gun.target:
				pass
#				$Gun.trigger_held = true
	#			print("skittle skittle ", owner)
		return
	
	$Gun.trigger_held = false
	
