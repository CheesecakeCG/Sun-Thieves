extends AnimationPlayer

@export_file("*.tscn") var next_scene : String

func go_to_next_scene():
	get_tree().change_scene(next_scene)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		go_to_next_scene()
