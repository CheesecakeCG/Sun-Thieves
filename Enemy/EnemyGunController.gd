extends Node

func _ready():
	set_physics_process(false)


func _on_Timer_timeout():
	$Gun.target = get_parent().follow
	$RayCast3D.look_at(get_parent().follow.global_transform.origin)
	$RayCast3D.force_raycast_update()
	if $RayCast3D.is_colliding():
#		await get_tree().create_timer(0.1).timeout
		$RayCast3D.enabled = true
		set_physics_process(true)

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		$Gun.trigger_held = true
		await $Gun.fire()
		
	else:
		set_physics_process(false)
		$RayCast3D.enabled = false
		$Gun.trigger_held = false
