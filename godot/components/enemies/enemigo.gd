@tool
extends Area2D
class_name Enemigo

@onready var gpu_particles_2d_1: GPUParticles2D = $GPUParticles2D1
@onready var gpu_particles_2d_2: GPUParticles2D = $GPUParticles2D2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar

@export var velocidad : int = 50 ## Velocidad en que se mueve.
@export var salud : int = 50 ## Cantidad de Vida inicial.
@export var premio_energia : int = 50 ## Premio de Energía que da al matarlo.
@export var nombre : String = "Enemigo": ## Nombre del Enemigo.
	set(new_nombre):
		nombre = new_nombre
		if label:
			label.text = new_nombre

@export var textura: Texture2D ## Textura del enemigo

var salud_actual = 50

func _ready() -> void:
	actualizar_ui()

func actualizar_ui() -> void:
	salud_actual = salud
	progress_bar.max_value = salud
	progress_bar.value = salud
	label.text = nombre
	sprite_2d.texture = textura

func _process(delta):
	position.x -= velocidad * delta

func le_hacen_daño(cantidad):
	salud_actual -= cantidad
	progress_bar.value = clamp(salud_actual, 0, salud)
	if salud_actual <= 0:
		GameManager.energia += premio_energia
		animation_player.play("morir")
		collision_shape_2d.visible = false
		label.visible = false
		progress_bar.visible = false
		gpu_particles_2d_1.one_shot = true
		gpu_particles_2d_1.restart()
		await gpu_particles_2d_1.finished
		queue_free()

func llega_destino():
	animation_player.play("ganar")
	gpu_particles_2d_2.one_shot = true
	gpu_particles_2d_2.restart()
	await gpu_particles_2d_2.finished
	queue_free()
