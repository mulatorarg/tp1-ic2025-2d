@tool
extends Nivel

func _ready():
	nivel_numero = 2
	nivel_nombre = "Los Esteros del Iberá"
	oleadas = [
		[YveraScene, AoAoScene], # oleada 1
		[MonaiScene, AoAoScene, YveraScene], # oleada 2
		[MonaiScene, AoAoScene, MonaiScene, AoAoScene, YveraScene, AoAoScene, MonaiScene], # oleada 3
		[MonaiScene, LobisonScene, AoAoScene], # oleada 4 (introduce Lobisón)
	]
	super()
