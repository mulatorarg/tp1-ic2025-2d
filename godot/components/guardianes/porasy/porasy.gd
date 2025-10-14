extends Area2D
class_name GuardianPorasy

@export var intervalo_ataque : float = 1.5 ## Distancia de Tiempo entre disparos (se mide en segundos).
@export var salud : int = 120 ## Cantidad de Vida inicial.
@export var nombre : String = "Porãsy": ## Nombre del Guardián (la doncella valiente).
	set (value):
		nombre = value
		if nombre.length() > 0:
			label.text = value

@export var recurso_mana := 5 ## Cuanto de maná necesita para instanciar en la celda.
@export var recurso_energia := 5 ## Cuanto de energía necesita para instanciar en la celda.

@onready var DisparoScene = preload("res://components/guardianes/porasy/porasy_disparo.tscn")

@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var sprite: AnimatedSprite2D = $Sprite2D

var salud_actual = 100

func _ready():
	salud_actual = salud
	progress_bar.max_value = salud
	progress_bar.value = salud
	label.text = nombre

	var timer = Timer.new()
	timer.wait_time = intervalo_ataque
	timer.timeout.connect(atacar)
	add_child(timer)
	timer.start()

func atacar():
	sprite.play("attack")
	var disparo = DisparoScene.instantiate()
	disparo.position = position
	disparo.position.x += 20
	disparo.direction = Vector2.RIGHT
	get_parent().add_child(disparo)

func recursos_disponibles():
	return GameManager.dispone_recursos({"mana": recurso_mana, "energia": recurso_energia})
