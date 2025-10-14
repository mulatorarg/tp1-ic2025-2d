@tool
extends Nivel

func _ready():
	nivel_numero = 4
	nivel_nombre = "Monte chaqueño"
	oleadas = [
		[JasyJatereScene, MboiTuiScene],
		[KurupiScene, AoAoScene],
		[TejuJaguaScene, JasyJatereScene, AoAoScene],
		[TauScene],
	]
	super()
