extends Control
## Grilla.
class_name Grilla

@export var grilla_columnas := 7 ## Columnas de la grilla.
@export var grilla_filas := 6 ## Filas de la grilla.
@export var grilla_celda_tamaño := Vector2(128, 180) ## Tamaño de los sprite de la grilla.

var grilla_posiciones: Array = [
	[Vector2i(267.0, 277.0), Vector2i(388.0, 277.0), Vector2i(508.0, 277.0), Vector2i(618.0, 277.0), Vector2i(736.0, 277.0), Vector2i(857.0, 277.0), Vector2i(973.0, 277.0)],
	[Vector2i(216.0, 341.0), Vector2i(354.0, 341.0), Vector2i(480.0, 341.0), Vector2i(613.0, 341.0), Vector2i(743.0, 341.0), Vector2i(872.0, 341.0), Vector2i(998.0, 341.0)],
	[Vector2i(161.0, 390.0), Vector2i(309.0, 390.0), Vector2i(456.0, 390.0), Vector2i(604.0, 390.0), Vector2i(750.0, 390.0), Vector2i(896.0, 390.0), Vector2i(1040.0, 390.0)],
	[Vector2i(96.0, 447.0), Vector2i(267.0, 447.0), Vector2i(436.0, 447.0), Vector2i(596.0, 447.0), Vector2i(758.0, 447.0), Vector2i(926.0, 447.0), Vector2i(1086.0, 447.0)],
	[Vector2i(54.0, 535.0), Vector2i(218.0, 535.0), Vector2i(392.0, 535.0), Vector2i(578.0, 535.0), Vector2i(764.0, 535.0), Vector2i(950.0, 535.0), Vector2i(1130.0, 535.0)]
]

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
