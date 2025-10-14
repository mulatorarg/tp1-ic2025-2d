extends Grilla

func _ready() -> void:
	# para saber las position de los paneles que actuan como celda
	#mostrar_posiciones()
	grilla_posiciones = [
		[Vector2i(299.0, 228.0), Vector2i(405.0, 228.0), Vector2i(511.0, 228.0), Vector2i(617.0, 228.0), Vector2i(723.0, 228.0), Vector2i(827.0, 228.0), Vector2i(928.0, 228.0), Vector2i(1035.0, 228.0)],
		[Vector2i(270.0, 280.0), Vector2i(390.0, 280.0), Vector2i(505.0, 280.0), Vector2i(615.0, 280.0), Vector2i(725.0, 280.0), Vector2i(835.0, 281.0), Vector2i(945.0, 280.0), Vector2i(1055.0, 280.0)],
		[Vector2i(246.0, 341.0), Vector2i(367.0, 341.0), Vector2i(490.0, 341.0), Vector2i(610.0, 341.0), Vector2i(730.0, 341.0), Vector2i(845.0, 341.0), Vector2i(965.0, 341.0), Vector2i(1080.0, 341.0)],
		[Vector2i(200.0, 400.0), Vector2i(340.0, 400.0), Vector2i(475.0, 400.0), Vector2i(605.0, 400.0), Vector2i(733.0, 400.0), Vector2i(857.0, 400.0), Vector2i(987.0, 400.0), Vector2i(1107.0, 400.0)],
		[Vector2i(185.0, 475.0), Vector2i(315.0, 475.0), Vector2i(455.0, 475.0), Vector2i(595.0, 475.0), Vector2i(735.0, 475.0), Vector2i(875.0, 475.0), Vector2i(1009.0, 475.0), Vector2i(1140.0, 475.0)]
	]
