extends Node2D
## Pantalla principal. Prueba de conceptos de arte y jugabilidad. Ponele...

@export_group("Grilla")
@export var grilla_columnas := 6 ## Columnas de la grilla.
@export var grilla_filas := 5 ## Filas de la grilla.
@export var grilla_celda_tamaño := Vector2(128, 128) ## Tamaño de los sprite de la grilla.
@export_group("Enemigos")
@export var enemigos_maximos := 8 ## Cantidad inicial de enemigos.
@export var enemigos_puntos: Array[Marker2D] ## Puntos de partida de los enemigos.

@onready var TileScene = preload("res://components/tile.tscn")
@onready var KalaScene = preload("res://components/enemies/kala.tscn")
@onready var enemy_timer: Timer = $EnemyTimer
@onready var enemies_progress_bar: ProgressBar = $Hud/HBoxContainer/EnemiesProgressBar
@onready var vidas_progress_bar: ProgressBar = $Hud/HBoxContainer/VidasProgressBar
@onready var lost_area: Area2D = $LostArea
@onready var perdiste_label: Label = $Hud/PerdisteLabel

var enemigos_cantidad_instanciadas := 0
var vidas_restantes := 0

func _ready():
	perdiste_label.visible = false
	lost_area.area_entered.connect(_on_lost_area_body_entered)
	enemies_progress_bar.max_value = enemigos_maximos
	enemies_progress_bar.value = 0
	vidas_progress_bar.max_value = enemigos_maximos
	vidas_progress_bar.value = enemigos_maximos
	vidas_restantes = enemigos_maximos
	enemy_timer.timeout.connect(_on_EnemyTimer_timeout)
	if enemigos_puntos.size() > 0:
		enemy_timer.start()
		print_rich("[color=green]Se cargaron los marcadores de salida de los enemigos[/red]")
	else:
		print_rich("[color=red]Faltan cargar los marcadores de salida de los enemigos[/red]")

func _on_EnemyTimer_timeout():
	if enemigos_cantidad_instanciadas < enemigos_maximos:
		var enemy = KalaScene.instantiate()
		enemy.position = enemigos_puntos.pick_random().global_position
		add_child(enemy)
		enemigos_cantidad_instanciadas += 1
		enemies_progress_bar.value = enemigos_cantidad_instanciadas
	else:
		enemy_timer.stop()

func _process(_delta: float) -> void:
	if vidas_restantes <= 0:
		print("PERDISTE")
		perdiste_label.visible = true
		get_tree().paused = true

func _on_lost_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print("enemigo llegó a la choza")
		vidas_progress_bar.value -= 1
		vidas_restantes -= 1
		body.queue_free()
