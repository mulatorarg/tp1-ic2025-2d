@tool
extends Node2D
class_name Nivel

## Script base para todos los niveles del juego.
## Maneja la instanciación de oleadas de enemigos y detecta condiciones de victoria/derrota
## 
## LÓGICA DE VICTORIA/DERROTA:
##
## * Victoria: Se instancian todos los enemigos y menos de 3 llegan a la choza
## * Derrota: 3 o más enemigos llegan a la choza
##
## Los niveles heredan de esta clase y solo necesitan configurar:
## * nivel_numero: Número del nivel
## * nivel_nombre: Nombre descriptivo del nivel  
## * oleadas: Array de arrays con las escenas de enemigos por oleada
## * proximo_nivel: string con la path al siguiente nivel.

@export_group("Oleadas")
## Nodo padre de los Marker2d que actúan como contenedor puntos de partida de los enemigos.
@export var nodo_enemigos_puntos: Node2D
## Segundos de espera entre aparición de enemigo.
@export var espera_entre_enemigos : float = 3.0
## Segundos de espera entre oleadas de enemigos.
@export var espera_entre_oleadas : float = 2.0

## Array de oleadas de enemigos. Cada oleada es un array de PackedScenes de enemigos
## Ejemplo: [[AoAoScene, MonaiScene], [MonaiScene, AoAoScene, AoAoScene]]
var oleadas : Array = []

@export_group("Datos del Nivel")
@export var nivel_numero: int = 0
@export var nivel_nombre: String = ""

@export_group("Enemigos")
@export var AoAoScene = preload("res://components/enemies/aoao.tscn")
@export var JasyJatereScene = preload("res://components/enemies/jasy_jatere.tscn")
@export var KurupiScene = preload("res://components/enemies/kurupi.tscn")
@export var LobisonScene = preload("res://components/enemies/lobison.tscn")
@export var MboiTuiScene = preload("res://components/enemies/mboi_tui.tscn")
@export var MonaiScene = preload("res://components/enemies/monai.tscn")
@export var TejuJaguaScene = preload("res://components/enemies/teju_jagua.tscn")
@export var YveraScene = preload("res://components/enemies/yvera.tscn")
@export var TauScene = preload("res://components/enemies/tau.tscn")
@export var KeranaScene = preload("res://components/enemies/kerana.tscn")

@export_group("Otros")
## Ruta al siguiente nivel que se carga al ganar
@export var proximo_nivel : String

@onready var enemigos_timer: Timer = $EnemigosTimer
@onready var enemigos_progress_bar: ProgressBar = $Hud/HBoxContainer/EnemigosProgressBar
@onready var vidas_progress_bar: ProgressBar = $Hud/HBoxContainer/VidasProgressBar
@onready var perder_area: Area2D = $PerderArea
@onready var hud: HUD = $Hud

## Puntos de partida de los enemigos (Marker2D nodes)
var enemigos_puntos: Array[Marker2D]

## VARIABLES DE CONTROL DE OLEADAS
var enemigos_cantidad_instanciadas : int = 0 ## Total de enemigos que han sido instanciados hasta ahora
var enemigos_oleda_actual : int = 0 ## Índice de la oleada actual (0-based)
var enemigos_cantidad_total := 0 ## Cantidad total de enemigos en todas las oleadas
var enemigos_index_emitir := 0 ## Índice del próximo enemigo a instanciar en la oleada actual

## VARIABLES DE ESTADO DEL NIVEL
var todas_oleadas_instanciadas := false ## Flag que indica si todas las oleadas han sido instanciadas
var nivel_terminado := false ## Flag para evitar múltiples verificaciones de fin de nivel


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []

	if not nodo_enemigos_puntos:
		warnings.append("Faltan nodos Marker2D de salida de enemigos.")
	else:
		if not nodo_enemigos_puntos.get_children().any(func(child): return child is Marker2D):
			warnings.append("El nodo de Posiciones de enemigos debe tener al menos un nodo Marker2D.")

	return warnings


func _ready():

	if Engine.is_editor_hint():
		return

	print_rich("[color=green]Iniciando [/color] [color=orange]Nivel %s - %s[/color]." % [nivel_numero, nivel_nombre])
	hud.nombre_nivel("Nivel %s - %s" % [nivel_numero, nivel_nombre])

	perder_area.area_entered.connect(_on_perder_area_body_entered)
	enemigos_timer.timeout.connect(_on_EnemyTimer_timeout)
	enemigos_timer.wait_time = espera_entre_enemigos
	
	# Conectar señales del GameManager para detectar eventos de enemigos
	GameManager.enemigo_eliminado.connect(_on_enemigo_eliminado)
	GameManager.enemigo_llego_choza.connect(_on_enemigo_llego_choza)
	
	# Reiniciar contadores de enemigos al iniciar el nivel
	GameManager.reiniciar_contadores_enemigos()

	enemigos_puntos.clear()
	if nodo_enemigos_puntos:
		for marcador in nodo_enemigos_puntos.get_children():
			if marcador is Marker2D:
				enemigos_puntos.append(marcador)

		print_rich("[color=green]Se encontraron %s marcadores de salida de enemigos!![/color]" % enemigos_puntos.size())
	else:
		print_rich("[color=red]No se encontraron puntos de salida de enemigos. No se puede Jugar!![/color]")
		return

	for oleada in oleadas:
		enemigos_cantidad_total += oleada.size()

	enemigos_progress_bar.max_value = enemigos_cantidad_total
	enemigos_progress_bar.value = 0
	GameManager.enemigos_totales = enemigos_cantidad_total

	# Configurar barra de vidas del HUD (3 vidas fijas para derrota)
	vidas_progress_bar.max_value = 3
	vidas_progress_bar.value = 3

	if oleadas.size() > 0:
		print_rich("[color=green]Se encontraron %s Oleadas de enemigos.[/color]" % oleadas.size())
		print_rich("[color=green]Se instanciarán %s Enemigos en total.[/color]" % enemigos_cantidad_total)
		enemigos_oleda_actual = 0
		GameManager.oleada_actual = 0
		GameManager.oleadas_totales = oleadas.size()
	else:
		print_rich("[color=red]Cantidad de Oleadas de enemigos incorrecta. No se puede Jugar!![/color]")
		return

	enemigos_timer.start()


func _on_EnemyTimer_timeout():
	# Instancia secuencial de enemigos por oleada
	print("enemigos_oleda_actual: %s de oleadas: %s " % [enemigos_oleda_actual, oleadas.size()])

	if enemigos_oleda_actual >= oleadas.size():
		# Ya no hay más oleadas para emitir
		enemigos_timer.stop()
		todas_oleadas_instanciadas = true
		print_rich("[color=yellow]Todas las oleadas han sido instanciadas. Esperando que terminen los combates...[/color]")
		# Forzar verificación por si ya no quedan enemigos vivos
		verificar_condiciones_nivel()
		return

	if enemigos_index_emitir < oleadas[enemigos_oleda_actual].size():
		var enemyScene: PackedScene = oleadas[enemigos_oleda_actual][enemigos_index_emitir]
		var enemy = enemyScene.instantiate()
		enemy.position = enemigos_puntos.pick_random().global_position
		add_child(enemy)
		enemigos_cantidad_instanciadas += 1
		enemigos_index_emitir += 1
		enemigos_progress_bar.value = enemigos_cantidad_instanciadas
		GameManager.enemigos_actual = enemigos_cantidad_instanciadas
		return

	# Si ya se emitieron todos los enemigos de la oleada actual, pasar a la siguiente oleada
	enemigos_timer.stop()
	siguiente_oleada()

func siguiente_oleada() -> void:
	print("Esperar antes de iniciar la siguiente oleada")
	await get_tree().create_timer(espera_entre_oleadas).timeout
	enemigos_index_emitir = 0

	# Avanzar índice de oleada
	if oleadas.size() > enemigos_oleda_actual:
		enemigos_oleda_actual += 1
		GameManager.oleada_actual = enemigos_oleda_actual

	# Si no hay más oleadas, marcar como completo
	if enemigos_oleda_actual >= oleadas.size():
		todas_oleadas_instanciadas = true
		print_rich("[color=yellow]Todas las oleadas han sido instanciadas. Esperando que terminen los combates...[/color]")
		# Verificar por si el tablero ya quedó limpio
		verificar_condiciones_nivel()
		return

	print("Empezar oleada: %s." % enemigos_oleda_actual)
	enemigos_timer.start()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return


## Función llamada cuando un enemigo muere (eliminado por el jugador)
func _on_enemigo_eliminado():
	# Verificar condiciones de victoria solo si todas las oleadas han sido instanciadas
	if todas_oleadas_instanciadas and not nivel_terminado:
		verificar_condiciones_nivel()


## Función llamada cuando un enemigo llega a la choza
func _on_enemigo_llego_choza():
	# Verificar condiciones de derrota
	if GameManager.enemigos_llegaron_choza >= 3 and not nivel_terminado:
		nivel_terminado = true
		perder_nivel()
	# También verificar condiciones de victoria si todas las oleadas han sido instanciadas
	elif todas_oleadas_instanciadas and not nivel_terminado:
		verificar_condiciones_nivel()


# Verificar si se cumplen las condiciones para ganar o perder el nivel
func verificar_condiciones_nivel():
	var total_procesados = GameManager.enemigos_eliminados + GameManager.enemigos_llegaron_choza
	
	print_rich("[color=cyan]Resultados: Eliminados: %s, Llegaron: %s, Total: %s/%s[/color]" % 
		[GameManager.enemigos_eliminados, GameManager.enemigos_llegaron_choza, total_procesados, enemigos_cantidad_total])
	
	# Si todos los enemigos han sido procesados (eliminados o llegaron a la choza)
	if total_procesados >= enemigos_cantidad_total:
		if GameManager.enemigos_llegaron_choza < 3:
			# Victoria: menos de 3 enemigos llegaron a la choza
			nivel_terminado = true
			ganar_nivel()
		else:
			# Derrota: 3 o más enemigos llegaron a la choza
			nivel_terminado = true
			perder_nivel()


func ganar_nivel():
	enemigos_timer.stop()
	hud.mostrar_ganaste()
	print_rich("[color=green]¡VICTORIA! Has completado el nivel exitosamente.[/color]")
	print_rich("[color=green]Enemigos eliminados: %s, Enemigos que llegaron: %s[/color]" % 
		[GameManager.enemigos_eliminados, GameManager.enemigos_llegaron_choza])
	await get_tree().create_timer(espera_entre_oleadas).timeout
	get_tree().change_scene_to_file(proximo_nivel)


func perder_nivel():
	enemigos_timer.stop()
	hud.mostrar_perdiste()
	print_rich("[color=red]¡DERROTA! Demasiados enemigos llegaron a la choza.[/color]")
	print_rich("[color=red]Enemigos eliminados: %s, Enemigos que llegaron: %s[/color]" % 
		[GameManager.enemigos_eliminados, GameManager.enemigos_llegaron_choza])
	get_tree().paused = true


func _on_perder_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		print(body.nombre + " llegó a la choza")
		vidas_progress_bar.value -= 1
		body.llega_destino()
