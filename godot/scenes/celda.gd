extends Panel  
## Celda individual de la grilla de cada nivel.
class_name Celda

@export var row: int = -1 ## Fila que representa en la grilla.
@export var col: int = -1 ## Columna que representa en la grilla.

@onready var grid: Grilla = $".." ## El padre debe ser una Grilla

func _can_drop_data(_pos, data):
	#print(_pos, data)
	return data.costo <= RecursosManager.energia

func _drop_data(_pos, data):
	if grid.is_celda_disponible(row, col):
		RecursosManager.energia -= data.costo
		grid.insertar_guardian(data.escena, row, col)
