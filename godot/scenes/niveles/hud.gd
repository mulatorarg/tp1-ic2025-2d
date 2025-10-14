extends CanvasLayer
class_name HUD

@onready var mana_label: Label = $HBoxContainer/ManaLabel
@onready var energia_label: Label = $HBoxContainer/EnergiaLabel
@onready var enemigos_progress_bar: ProgressBar = $HBoxContainer/EnemigosProgressBar
@onready var vidas_progress_bar: ProgressBar = $HBoxContainer/VidasProgressBar
@onready var salir_button: Button = %SalirButton
@onready var nivel_label: Label = %NivelLabel
@onready var ganaste_panel: Panel = %GanastePanel
@onready var perdiste_panel: Panel = %PerdistePanel
@onready var oleada_label: Label = %OleadaLabel
@onready var enemigos_label_2: Label = %EnemigosLabel2

func _ready() -> void:
	salir_button.pressed.connect(salir)
	GameManager.recursos_changed.connect(actualizar_ui)
	actualizar_ui()
	
func actualizar_ui() -> void:
	energia_label.text = str(GameManager.energia)
	mana_label.text = str(GameManager.mana)
	oleada_label.text = "Oleada %s de %s." % [GameManager.oleada_actual + 1, GameManager.oleadas_totales]
	enemigos_label_2.text = "Enemigos %s de %s." % [GameManager.enemigos_actual, GameManager.enemigos_totales]

func salir() -> void:
	get_tree().quit()

func nombre_nivel(nuevo_nombre: String) -> void:
	nivel_label.text = nuevo_nombre

func mostrar_ganaste() -> void:
	ganaste_panel.visible = true
func ocultar_ganaste() -> void:
	ganaste_panel.visible = false

func mostrar_perdiste() -> void:
	perdiste_panel.visible = true
func ocultar_perdiste() -> void:
	perdiste_panel.visible = false
