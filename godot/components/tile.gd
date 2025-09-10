extends Area2D

var guardian = null

func place_guardian(guardian_scene):
	if guardian == null:
		guardian = guardian_scene.instantiate()
		guardian.position = position
		get_parent().add_child(guardian)
