extends Control

#const LEVEL_SELECTOR = preload("res://scenes/screens/menues/level_selector/level_selector.tscn")
#const SETTINGS = preload("res://scenes/screens/menues/settings/Settings.tscn")
const NIVEL1 = preload("res://scenes/nivel1.tscn")

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
	pass

func _on_salir_button_pressed() -> void:
	get_tree().quit()
