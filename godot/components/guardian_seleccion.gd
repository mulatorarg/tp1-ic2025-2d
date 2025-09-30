extends PanelContainer

## Item para la selección de Guardianes a agregar a la grilla.
class_name GuardianSeleccion

@onready var icon: TextureRect = $TextureRect
@onready var label: Label = %Label
@onready var texture_rect: TextureRect = $TextureRect

@export var reproductor: AudioStreamPlayer2D

var audio_sin_recursos = preload("res://assets/audios/sin_recursos_suficientes.ogg")

## La escena a instanciar en la grilla. Debe ser un Guardían.
@export var guardian_scene: PackedScene

## Costo de Energía necesario para insertar en la grilla.
@export var costo_energia : int = 50: 
	set(value):
		costo_energia = value
		%Label.text = str(costo_energia)
		_on_recursos_changed_emit()

## .
@export var textura : Texture2D:
	set(new_texture):
		textura = new_texture
		if new_texture:
			if  texture_rect:
				texture_rect.texture = new_texture

func _ready() -> void:
	RecursosManager.recursos_changed.connect(_on_recursos_changed_emit)
	if textura:
		texture_rect.texture = textura
	if guardian_scene:
		label.text = str(costo_energia)
	_on_recursos_changed_emit()

func _get_drag_data(_at_position: Vector2) -> Variant:
	
	if guardian_scene == null:
		print_rich("[color=red]No se seleccionó Guardian.[/color]")
		return null

	if RecursosManager.energia >= costo_energia:
		var preview := TextureRect.new()
		preview.texture = icon.texture
		preview.custom_minimum_size = Vector2(128, 180)
		preview.scale = Vector2(0.5, 0.5)
		set_drag_preview(preview)

		return {"escena": guardian_scene, "costo": costo_energia}

	else:
		print_rich("[color=red]Sin recursos para jugar Guardian.[/color]")
		if reproductor and audio_sin_recursos:
			reproductor.stream = audio_sin_recursos
			reproductor.play()
		return null

func _on_recursos_changed_emit() -> void:
	if RecursosManager.energia >= costo_energia:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(0.6,0.6,0.6,.96)
