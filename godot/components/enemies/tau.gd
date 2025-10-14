extends Node

## Taú: Boss enemigo principal

const SombraScene := preload("res://components/enemies/sombra.tscn")
@onready var boss: Enemigo = get_parent() as Enemigo
var _invocador: Timer
@export var spawn_interval := 6.0
@export var max_minions := 4

func _ready() -> void:
	boss.salud = 600
	boss.velocidad = 60
	boss.premio_energia = 300
	boss.nombre = "Taú"
	boss.actualizar_ui()
	# Estilos boss
	if boss.label:
		boss.label.add_theme_color_override("font_color", Color(0.9, 0.2, 0.2))
		boss.label.text = boss.nombre + " (Boss)"
	if boss.progress_bar:
		boss.progress_bar.max_value = boss.salud
		boss.progress_bar.value = boss.salud
	# Timer de invocación
	_invocador = Timer.new()
	_invocador.wait_time = spawn_interval
	_invocador.autostart = true
	_invocador.one_shot = false
	add_child(_invocador)
	_invocador.timeout.connect(_invocar_sombra)

func _invocar_sombra():
	if not is_inside_tree():
		return
	if Engine.is_editor_hint():
		return
	# Respetar límite de minions vivos
	var parent = get_parent().get_parent()
	var vivos = 0
	if parent:
		for c in parent.get_children():
			if c is Enemigo and c.nombre == "Sombra":
				vivos += 1
				if vivos >= max_minions:
					return
	var sombra = SombraScene.instantiate()
	# Invoca a la derecha del boss, con ligera variación vertical
	sombra.position = boss.position + Vector2(30, randf_range(-20, 20))
	# Agregar al mismo padre del boss (contenedor de enemigos)
	get_parent().get_parent().add_child(sombra)
