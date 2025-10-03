extends Grilla

func _ready() -> void:
	# para saber las position de los paneles que actuan como celda
	#mostrar_posiciones()
	grilla_posiciones = [
		[Vector2i(267.0, 277.0), Vector2i(388.0, 277.0), Vector2i(508.0, 277.0), Vector2i(618.0, 277.0), Vector2i(736.0, 277.0), Vector2i(857.0, 277.0), Vector2i(973.0, 277.0)],
		[Vector2i(216.0, 341.0), Vector2i(354.0, 341.0), Vector2i(480.0, 341.0), Vector2i(613.0, 341.0), Vector2i(743.0, 341.0), Vector2i(872.0, 341.0), Vector2i(998.0, 341.0)],
		[Vector2i(161.0, 390.0), Vector2i(309.0, 390.0), Vector2i(456.0, 390.0), Vector2i(604.0, 390.0), Vector2i(750.0, 390.0), Vector2i(896.0, 390.0), Vector2i(1040.0, 390.0)],
		[Vector2i(96.0, 447.0), Vector2i(267.0, 447.0), Vector2i(436.0, 447.0), Vector2i(596.0, 447.0), Vector2i(758.0, 447.0), Vector2i(926.0, 447.0), Vector2i(1086.0, 447.0)],
		[Vector2i(54.0, 535.0), Vector2i(218.0, 535.0), Vector2i(392.0, 535.0), Vector2i(578.0, 535.0), Vector2i(764.0, 535.0), Vector2i(950.0, 535.0), Vector2i(1130.0, 535.0)]
	]
