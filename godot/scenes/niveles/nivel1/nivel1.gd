@tool
extends Nivel

func _ready():
	nivel_numero = 1
	nivel_nombre = "Campo del Cielo"
	oleadas = [
		[AoAoScene, AoAoScene, YveraScene, KeranaScene ], # oleada 1
		[MonaiScene, AoAoScene, YveraScene, KeranaScene], # oleada 2
	]
	super()
	
