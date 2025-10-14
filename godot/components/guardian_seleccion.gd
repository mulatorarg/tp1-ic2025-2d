@tool
extends PanelContainer

## Item para la selección de Guardianes a agregar a la grilla.
class_name GuardianSeleccion

@onready var nombre_label: Label = %NombreLabel
@onready var imagen_texture: TextureRect = %ImagenTexture
@onready var energia_label: Label = %EnergiaLabel

var audio_sin_recursos = preload("res://assets/audios/sin_recursos_suficientes.ogg")

## .
@export var reproductor: AudioStreamPlayer2D

## La escena a instanciar en la grilla. Debe ser un Guardían.
@export var guardian_scene: PackedScene:
	set(new_packed):
		guardian_scene = new_packed
		if (new_packed):
			if nombre_label and energia_label:
				actualizar_valores()

## Imagen que se mostrará durante el "drag and drop".
@export var textura : Texture2D:
	set(new_texture):
		textura = new_texture
		if new_texture:
			if imagen_texture:
				imagen_texture.texture = new_texture

var nombre : String = ""
var costo_energia : int = 0

func _ready() -> void:
	if imagen_texture:
		imagen_texture.texture = textura
	if guardian_scene:
		actualizar_valores()

	if not Engine.is_editor_hint():
		GameManager.recursos_changed.connect(_on_recursos_changed_emit)

	_on_recursos_changed_emit()

func _get_drag_data(_at_position: Vector2) -> Variant:
	
	if guardian_scene == null:
		print_rich("[color=red]No se seleccionó Guardian.[/color]")
		return null

	if GameManager.energia >= costo_energia:
		var preview := TextureRect.new()
		preview.texture = imagen_texture.texture
		preview.custom_minimum_size = Vector2(128, 180)
		preview.scale = Vector2(0.5, 0.5)
		set_drag_preview(preview)

		return {
			"escena": guardian_scene,
			"costo": costo_energia
		}

	else:
		print_rich("[color=red]Sin recursos para jugar Guardian.[/color]")
		if reproductor and audio_sin_recursos:
			reproductor.stream = audio_sin_recursos
			reproductor.play()
		return null

func actualizar_valores() -> void:
	if guardian_scene:
		var inst = guardian_scene.instantiate()
		if inst:
			var n = inst.get("nombre")
			if n != null:
				nombre = str(n)
			var e = inst.get("recurso_energia")
			if e != null:
				costo_energia = int(e)
			inst.queue_free()

		nombre_label.text = str(nombre)
		energia_label.text = str(costo_energia)

func _tooltip_text() -> String:
	var tooltip_nombre := "Guardian"
	if guardian_scene:
		var inst = guardian_scene.instantiate()
		if inst:
			var n = inst.get("nombre")
			if n != null:
				tooltip_nombre = str(n)
			inst.queue_free()
	return "%s\nCosto energía: %s" % [tooltip_nombre, str(costo_energia)]

func _on_recursos_changed_emit() -> void:
	if not Engine.is_editor_hint():
		if GameManager.energia >= costo_energia:
			modulate = Color(1,1,1,1)
		else:
			modulate = Color(0.4,0.4,0.4,.96)
