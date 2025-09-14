extends CanvasLayer
class_name HUD

@onready var mana_label: Label = $HBoxContainer/ManaLabel
@onready var energia_label: Label = $HBoxContainer/EnergiaLabel
@onready var enemigos_progress_bar: ProgressBar = $HBoxContainer/EnemigosProgressBar
@onready var vidas_progress_bar: ProgressBar = $HBoxContainer/VidasProgressBar

func _ready() -> void:
	GameManager.recursos_changed.connect(actualizar_ui)
	actualizar_ui()
	
func actualizar_ui()->void:
	energia_label.text = str(GameManager.energia)
	mana_label.text = str(GameManager.mana)
