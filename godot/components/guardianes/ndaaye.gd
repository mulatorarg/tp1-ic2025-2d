extends Area2D

@export var intervalo_ataque := 2.0 ## Distancia de Tiempo de disparo (en segundos).
@export var salud := 100 ## Cantidad de Vida inicial.
@export var nombre := "AoAo" ## Nombre del Guardian.

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
