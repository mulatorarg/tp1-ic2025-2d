extends HBoxContainer

@export var guardian_scene:PackedScene
@onready var icon:TextureRect = $TextureRect
#@export var color = Color(1, 0, 0, 1)


func _get_drag_data(_at_position: Vector2) -> Variant:
	if guardian_scene == null:
		print_rich("[color=red]No se seleccionó Guardian.[/color]")
		return null
	var preview := TextureRect.new()
	preview.texture = icon.texture
	preview.custom_minimum_size = Vector2(128, 180)
	preview.scale = Vector2(0.5, 0.5)
	set_drag_preview(preview)
	return guardian_scene


	# Use a control that is not in the tree
	#var cpb = ColorPickerButton.new()
	#cpb.color = color
	#cpb.size = Vector2(50, 50)
	#set_drag_preview(cpb)
	#return color
