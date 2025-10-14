extends Control

const NIVEL1 = preload("res://scenes/niveles/nivel1/nivel1.tscn")
const SETTINGS = preload("uid://muq20cilkvqh")

@onready var comenzar_button: Button = %ComenzarButton
@onready var opciones_button: Button = %OpcionesButton
@onready var salir_button: Button = %SalirButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	comenzar_button.pressed.connect(_on_comenzar_button_pressed)
	opciones_button.pressed.connect(_on_opciones_button_pressed)
	salir_button.pressed.connect(_on_salir_button_pressed)

func _on_comenzar_button_pressed() -> void:
	get_tree().change_scene_to_packed(NIVEL1)

func _on_opciones_button_pressed() -> void:
	get_tree().change_scene_to_packed(SETTINGS)

func _on_salir_button_pressed() -> void:
	get_tree().quit()
