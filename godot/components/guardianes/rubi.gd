extends Area2D

@export var intervalo_ataque : float = 2.0 ## Distancia de Tiempo entre disparos (se mide en segundos).
@export var salud : int = 400 ## Cantidad de Vida inicial.
@export var nombre : String = "Rubi": ## Nombre del Guardian.
	set (value):
		nombre = value
		if nombre.length() > 0:
			label.text = value

@export var recurso_mana := 10 ## Cuanto de maná necesita para instanciar en la celda.
@export var recurso_energia := 10 ## Cuanto de energía necesita para instanciar en la celda.

@onready var GuardianDisparoScene = preload("res://components/guardian_disparo.tscn")

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar

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
	var disparo = GuardianDisparoScene.instantiate()
	disparo.position = position
	disparo.direction = Vector2.RIGHT
	get_parent().add_child(disparo)

func recursos_disponibles():
	return RecursosManager.dispone_recursos({"mana": recurso_mana, "energia": recurso_energia})
