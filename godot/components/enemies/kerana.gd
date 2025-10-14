extends Node

## Keraná: Boss

@onready var boss: Enemigo = get_parent() as Enemigo

func _ready() -> void:
	boss.salud = 450
	boss.velocidad = 50
	boss.premio_energia = 250
	boss.nombre = "Keraná"
	boss.actualizar_ui()
	if boss.label:
		boss.label.add_theme_color_override("font_color", Color(0.8, 0.3, 0.6))
		boss.label.text = boss.nombre + " (Boss)"
	if boss.progress_bar:
		boss.progress_bar.max_value = boss.salud
		boss.progress_bar.value = boss.salud

## Aura de ralentización: reduce velocidad de proyectiles que entren en su radio
@export var aura_factor := 0.6
@export var aura_damage_factor := 0.85
var _proyectiles_afectados: = {}
var _vfx: Node = null

func _on_aura_area_entered(area: Area2D) -> void:
	# Detecta proyectiles de guardianes por clase conocida o por grupo
	if area is DisparoRubi or area is DisparoPorasy or area is DisparoGuacamayo or area is DisparoTupa or area is DisparoMarangatu:
		if not _proyectiles_afectados.has(area):
			var velocidad_original = 0.0
			var daño_original = null
			if "velocidad" in area:
				velocidad_original = area.velocidad
				area.velocidad *= aura_factor
			if "daño" in area:
				daño_original = area.daño
				area.daño = int(round(area.daño * aura_damage_factor))
			_proyectiles_afectados[area] = {
				"velocidad": velocidad_original,
				"daño": daño_original
			}
			if _vfx == null and boss and boss.has_node("Aura/VFX"):
				_vfx = boss.get_node("Aura/VFX")
			if _vfx and _vfx.has_method("set_highlight"):
				_vfx.set_highlight(true)

func _on_aura_area_exited(area: Area2D) -> void:
	if _proyectiles_afectados.has(area):
		var info = _proyectiles_afectados[area]
		if info.has("velocidad") and info.velocidad != 0.0:
			area.velocidad = info.velocidad
		if info.has("daño") and info.daño != null:
			area.daño = info.daño
		_proyectiles_afectados.erase(area)
		if _proyectiles_afectados.is_empty():
			if _vfx and _vfx.has_method("set_highlight"):
				_vfx.set_highlight(false)
