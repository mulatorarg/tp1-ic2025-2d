extends Control
## Grilla.
class_name Grilla

@export var grilla_columnas := 7 ## Columnas de la grilla.
@export var grilla_filas := 6 ## Filas de la grilla.
@export var grilla_celda_tamaño := Vector2(128, 180) ## Tamaño de los sprite de la grilla.

var grilla_posiciones: Array = []

# Diccionario para ir guardando los guardianes que coloco en las celdas
var celdas:Dictionary = {}

func _ready() -> void:
	# para saber las position de los paneles que actuan como celda
	#mostrar_posiciones()
	pass

func mostrar_posiciones():
	grilla_posiciones.clear()
	for control in get_children():
		grilla_posiciones.append(Vector2(control.position.x, control.position.y))
	print(grilla_posiciones)

func get_celda_posicion(row:int, col:int) -> Vector2:
	return grilla_posiciones[row][col]

func is_celda_disponible(row:int, col:int) -> bool:
	return not celdas.has(Vector2i(row, col))

func insertar_guardian(scene:PackedScene, row:int, col:int):
	if is_celda_disponible(row, col):
		var guardian = scene.instantiate()
		guardian.position = get_celda_posicion(row, col)
		get_tree().current_scene.add_child(guardian)
		celdas[Vector2i(row, col)] = guardian
