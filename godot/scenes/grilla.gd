extends Control
## Grilla.
class_name Grilla

@export var grilla_columnas := 7 ## Columnas de la grilla.
@export var grilla_filas := 6 ## Filas de la grilla.
@export var grilla_celda_tamaño := Vector2(128, 180) ## Tamaño de los sprite de la grilla.

var grilla_posiciones: Array = [
	[Vector2(304, 226), Vector2(408, 226), Vector2(520, 226), Vector2(626, 226), Vector2(728, 226), Vector2(832, 226), Vector2(936, 226)],
	[Vector2(280, 282), Vector2(392, 282), Vector2(512, 282), Vector2(620, 282), Vector2(736, 282), Vector2(843, 282), Vector2(960, 282)],
	[Vector2(248, 344), Vector2(368, 344), Vector2(496, 344), Vector2(616, 344), Vector2(736, 344), Vector2(856, 344), Vector2(976, 344)],
	[Vector2(216, 408), Vector2(336, 408), Vector2(480, 408), Vector2(608, 408), Vector2(739, 408), Vector2(865, 408), Vector2(999, 408)],
	[Vector2(176, 480), Vector2(315, 480), Vector2(456, 480), Vector2(600, 480), Vector2(744, 480), Vector2(880, 480), Vector2(1016, 480)],
	[Vector2(128, 568), Vector2(286, 568), Vector2(432, 568), Vector2(592, 568), Vector2(744, 568), Vector2(896, 568), Vector2(1040, 568)],
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
