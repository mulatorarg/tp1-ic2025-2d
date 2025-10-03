extends Node2D
class_name Nivel2

## Nodo padre de los Marker2d que actúan como contenedor puntos de partida de los enemigos.
@export var nodo_enemigos_puntos: Node2D

## Segundos de espeta entre aparición de enemigo.
@export var espera_entre_enemigos : float = 3.0
## Segundos de espeta entre oleadas de enemigos.
@export var espera_entre_oleadas : float = 2.0

@onready var AoAoScene   = preload("res://components/enemies/aoao.tscn")
@onready var CositoScene = preload("res://components/enemies/cosito.tscn")

@onready var enemigos_timer: Timer = $EnemigosTimer
@onready var enemigos_progress_bar: ProgressBar = $Hud/HBoxContainer/EnemigosProgressBar
@onready var vidas_progress_bar: ProgressBar = $Hud/HBoxContainer/VidasProgressBar
@onready var perder_area: Area2D = $PerderArea
@onready var perdiste_panel: Panel = %PerdistePanel
@onready var ganaste_panel: Panel = %GanastePanel

var enemigos_puntos: Array[Marker2D] ## Puntos de partida de los enemigos.
var oleadas : Array = []
var enemigos_cantidad_instanciadas : int = 0
var vidas_restantes : int = 0
var enemigos_oleda_actual : int = 0 ## Cantidad de ordas de enemigos del nivel.
var enemigos_cantidad_total := 0 ## Cantidad inicial de enemigos.
var enemigos_emitir := 0 ## Enemigo actual a mostrar del array.
var esparando := false

func _ready():
	
	print_rich("[color=green]Iniciando el Nivel 1.[/color]")

	oleadas = [
		[AoAoScene, CositoScene, AoAoScene, CositoScene, AoAoScene], # oleada 1
		[CositoScene, AoAoScene, CositoScene, AoAoScene, CositoScene, AoAoScene, CositoScene], # oleada 2
	]

	perdiste_panel.visible = false

	perder_area.area_entered.connect(_on_perder_area_body_entered)
	enemigos_timer.timeout.connect(_on_EnemyTimer_timeout)
	enemigos_timer.wait_time = espera_entre_enemigos

	enemigos_puntos.clear()
	if nodo_enemigos_puntos:
		for marcador in nodo_enemigos_puntos.get_children():
			if marcador is Marker2D:
				enemigos_puntos.append(marcador)
	
		print_rich("[color=green]Se encontraron %s marcadores de salida de enemigos!![/color]" % enemigos_puntos.size())
		enemigos_timer.start()
	else:
		print_rich("[color=red]No se encontraron puntos de salida de enemigos. No se puede Jugar!![/color]")
	
	for oleada in oleadas:
		enemigos_cantidad_total += oleada.size()

	enemigos_progress_bar.max_value = enemigos_cantidad_total
	enemigos_progress_bar.value = 0

	vidas_progress_bar.max_value = 3
	vidas_progress_bar.value = 3
	vidas_restantes = 3

	if oleadas.size() > 0:
		print_rich("[color=green]Se encontraron %s Oleadas de enemigos.[/color]" % oleadas.size())
		print_rich("[color=green]Se instanciarán %s Enemigos en total.[/color]" % enemigos_cantidad_total)
		enemigos_oleda_actual = 0
	else:
		print_rich("[color=red]Cantidad de Oleadas de enemigos incorrecta. No se puede Jugar!![/color]")


func _on_EnemyTimer_timeout():
	if enemigos_emitir < oleadas[enemigos_oleda_actual].size():
		var enemyScene: PackedScene = oleadas[enemigos_oleda_actual][enemigos_emitir]
		var enemy = enemyScene.instantiate()
		enemy.position = enemigos_puntos.pick_random().global_position
		add_child(enemy)
		enemigos_cantidad_instanciadas += 1
		enemigos_emitir += 1
		enemigos_progress_bar.value = enemigos_cantidad_instanciadas
	else:
		enemigos_timer.stop()
		siguiente_oleada()

##### ARREGLAAAAR
func siguiente_oleada() -> void:
	print("Esperar antes de iniciar la oleada")
	await get_tree().create_timer(espera_entre_oleadas).timeout
	enemigos_emitir = 0
	if oleadas.size() > enemigos_oleda_actual:
		enemigos_oleda_actual += 1
	if enemigos_oleda_actual >= oleadas.size():
		print("LISTO. GANASTE")
		enemigos_timer.stop()
	else:
		print("Empezar oleada: %s." %enemigos_oleda_actual)
		enemigos_timer.start()


func _process(_delta: float) -> void:
	if vidas_restantes < 1:
		print("PERDISTE")
		perdiste_panel.visible = true
		get_tree().paused = true


func _on_perder_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print(body.nombre + " llegó a la choza")
		vidas_progress_bar.value -= 1
		vidas_restantes -= 1
		body.llega_destino()
