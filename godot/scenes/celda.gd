extends Panel  
## Celda individual de la grilla de cada nivel.
class_name Celda

@export var row: int ## Fila que representa en la grilla.
@export var col: int ## Columna que representa en la grilla.

@onready var grid: Grilla = $".." ## El padre debe ser una Grilla

func _can_drop_data(_pos, data):
	#print(_pos, data)
	return data is PackedScene

func _drop_data(_pos, data):
	#print(_pos)
	print(grid.is_celda_disponible(row, col))
	if grid.is_celda_disponible(row, col):
		grid.insertar_guardian(data, row, col)
