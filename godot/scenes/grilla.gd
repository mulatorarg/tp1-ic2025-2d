extends Control
## Grilla.
class_name Grilla

@export var grilla_columnas := 7 ## Columnas de la grilla.
@export var grilla_filas := 6 ## Filas de la grilla.
@export var grilla_celda_tamaño := Vector2(128, 180) ## Tamaño de los sprite de la grilla.

var grilla_posiciones: Array = [
	[Vector2(201, 308), Vector2(332, 308), Vector2(455, 308), Vector2(576, 308), Vector2(701, 308), Vector2(818, 308), Vector2(944, 308)],
	[Vector2(178, 372), Vector2(316, 372), Vector2(442, 372), Vector2(575, 372), Vector2(705, 372), Vector2(834, 372), Vector2(960, 372)],
	[Vector2(148, 440), Vector2(296, 440), Vector2(431, 440), Vector2(571, 440), Vector2(708, 440), Vector2(844, 440), Vector2(981, 440)],
	[Vector2(117, 518), Vector2(272, 518), Vector2(418, 518), Vector2(563, 518), Vector2(711, 518), Vector2(861, 518), Vector2(1007, 518)],
	[Vector2(92, 600), Vector2(245, 600), Vector2(403, 600), Vector2(560, 600), Vector2(717, 600), Vector2(873, 600), Vector2(1027, 600)]
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
