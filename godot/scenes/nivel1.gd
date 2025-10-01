extends Node2D
## Pantalla principal. Prueba de conceptos de arte y jugabilidad. Ponele...
class_name Nivel1

@export var enemigos_maximos := 8 ## Cantidad inicial de enemigos.
@export var enemigos_puntos: Array[Marker2D] ## Puntos de partida de los enemigos.
@export_range(1, 10)  var enemigos_oledas := 2 ## Cantidad de ordas de enemigos del nivel.

@onready var AoAoScene   = preload("res://components/enemies/aoao.tscn")
@onready var CositoScene = preload("res://components/enemies/cosito.tscn")

@onready var enemigos_timer: Timer = $EnemigosTimer
@onready var enemigos_progress_bar: ProgressBar = $Hud/HBoxContainer/EnemigosProgressBar
@onready var vidas_progress_bar: ProgressBar = $Hud/HBoxContainer/VidasProgressBar
@onready var perder_area: Area2D = $PerderArea
@onready var perdiste_panel: Panel = $Hud/PerdistePanel

@export var oleadas : Dictionary = {}

var enemigos_cantidad_instanciadas := 0
var vidas_restantes := 0

func _ready():

	oleadas = {
		0: [AoAoScene, AoAoScene, CositoScene, AoAoScene], # oleada 1
		1: [AoAoScene, CositoScene, AoAoScene, CositoScene, AoAoScene, CositoScene], # oleada 2
	}

	perdiste_panel.visible = false
	perder_area.area_entered.connect(_on_perder_area_body_entered)
	enemigos_progress_bar.max_value = enemigos_maximos
	enemigos_progress_bar.value = 0
	vidas_progress_bar.max_value = enemigos_maximos
	vidas_progress_bar.value = enemigos_maximos
	vidas_restantes = enemigos_maximos
	enemigos_timer.timeout.connect(_on_EnemyTimer_timeout)

	if enemigos_puntos.size() > 0:
		enemigos_timer.start()
		print_rich("[color=green]Se cargaron los marcadores de salida de los enemigos.[/color]")
	else:
		print_rich("[color=red]Faltan cargar los marcadores de salida de los enemigos.[/color]")

	enemigos_oledas = 1

func _on_EnemyTimer_timeout():
	if enemigos_cantidad_instanciadas < enemigos_maximos:
		var enemy = AoAoScene.instantiate()
		enemy.position = enemigos_puntos.pick_random().global_position
		add_child(enemy)
		enemigos_cantidad_instanciadas += 1
		enemigos_progress_bar.value = enemigos_cantidad_instanciadas
	else:
		enemigos_timer.stop()

func _process(_delta: float) -> void:
	if vidas_restantes <= 0:
		print("PERDISTE")
		perdiste_panel.visible = true
		get_tree().paused = true

func _on_perder_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print(body.nombre + " llegó a la choza")
		vidas_progress_bar.value -= 1
		vidas_restantes -= 1
		body.llega_destino()
