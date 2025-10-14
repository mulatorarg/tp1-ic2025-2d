extends Enemigo

## Sombra: esbirro invocado por Taú

func _ready() -> void:
	salud = 80
	velocidad = 90
	premio_energia = 20
	nombre = "Sombra"
	actualizar_ui()
	if label:
		label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.9))
	if progress_bar:
		progress_bar.max_value = salud
		progress_bar.value = salud
