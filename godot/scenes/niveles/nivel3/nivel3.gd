@tool
extends Nivel

func _ready():
	nivel_numero = 3
	nivel_nombre = "Ribera del Paraná"
	oleadas = [
		[AoAoScene, MboiTuiScene],
		[MonaiScene, YveraScene, MboiTuiScene],
		[TejuJaguaScene, AoAoScene],
		[KeranaScene],
	]
	super()
