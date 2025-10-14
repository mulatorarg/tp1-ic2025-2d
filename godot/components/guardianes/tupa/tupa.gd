extends Area2D
class_name GuardianTupa

@export var intervalo_ataque : float = 3.0
@export var salud : int = 260
@export var nombre : String = "Tupã":
	set (value):
		nombre = value
		if nombre.length() > 0 and label:
			label.text = value

@export var recurso_mana := 12
@export var recurso_energia := 16

@onready var DisparoScene = preload("res://components/guardianes/tupa/tupa_disparo.tscn")

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
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
	if sprite:
		sprite.play("attack")
	var disparo = DisparoScene.instantiate()
	disparo.position = position + Vector2(20, 0)
	disparo.direction = Vector2.RIGHT
	get_parent().add_child(disparo)

func recursos_disponibles():
	return GameManager.dispone_recursos({"mana": recurso_mana, "energia": recurso_energia})
