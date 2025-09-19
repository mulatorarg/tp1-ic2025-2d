extends PanelContainer

## Emm.
class_name GuardianSeleccion

@export var guardian_scene: PackedScene

@onready var icon: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	#if guardian_scene:
	#	label.text str(guardian_scene.name)
	draw.connect(prueba)
	pass

func prueba() -> void:
	print("lisa")

func _get_drag_data(_at_position: Vector2) -> Variant:
	if guardian_scene == null:
		print_rich("[color=red]No se seleccionó Guardian.[/color]")
		return null

	var guardian = guardian_scene.instantiate()
	if guardian.has_method("recursos_disponibles") and !guardian.recursos_disponibles():
		print_rich("[color=red]Recursos insuficientes para agregar ese Guardian.[/color]")
		return null

	var preview := TextureRect.new()
	preview.texture = icon.texture
	preview.custom_minimum_size = Vector2(128, 180)
	preview.scale = Vector2(0.5, 0.5)
	set_drag_preview(preview)
	return guardian_scene
