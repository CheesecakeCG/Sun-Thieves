extends Area3D


func _input(event):
	if event.is_action_pressed("p_attack"):
		get_parent().get_parent().is_in_a_ball = false
		for b in get_overlapping_bodies():
			print(b)
