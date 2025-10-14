extends PanelContainer

var MENU = "res://scenes/menues/main/main.tscn"

@onready var resolution: OptionButton = %Resolution
@onready var screen_mode: OptionButton = %ScreenMode

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var master_slider: HSlider = %MasterSlider

@onready var guardar_button: Button = %GuardarButton
@onready var volver_button: Button = %VolverButton

const RESOLUTIONS = {
	"1920x1080": Vector2i(1920, 1080),
	"1366x768": Vector2i(1366, 768),
	"1280x720": Vector2i(1280, 720),
	"1152x648": Vector2i(1152, 648),
	"640x480": Vector2i(640, 480)
}

enum AudioBus {
	Master = 0,
	SFX = 1,
	Music = 2
}

func _ready():

	resolution.clear()
	for resolution_name in RESOLUTIONS.keys():
		resolution.add_item(resolution_name)
		if get_window().size == RESOLUTIONS[resolution_name]:
			resolution.selected = resolution.item_count - 1

	resolution.item_selected.connect(on_resolution_item_selected)
	screen_mode.item_selected.connect(on_screen_mode_selected)
	master_slider.value_changed.connect(on_master_slider_value_changed)
	music_slider.value_changed.connect(on_music_slider_value_changed)
	sfx_slider.value_changed.connect(on_sfx_slider_value_changed)
	guardar_button.pressed.connect(save_settings)
	volver_button.pressed.connect(volver)

	master_slider.value = AudioServer.get_bus_volume_linear(AudioBus.Master)
	music_slider.value = AudioServer.get_bus_volume_linear(AudioBus.Music)
	sfx_slider.value = AudioServer.get_bus_volume_linear(AudioBus.SFX)

func on_resolution_item_selected(index: int):
	var windows_size: Vector2i = RESOLUTIONS[resolution.get_item_text(index)]
	get_window().size = windows_size
	get_window().move_to_center()
	GameSettings.apply_all()

func on_screen_mode_selected(index: int):
	match index:
		0:
			GameSettings.fullscreen = true
		1:
			GameSettings.fullscreen = false
	
	#GameSettings.apply_all()

func on_master_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.Master, new_value)
	GameSettings.master_volume = new_value
	GameSettings.apply_all()

func on_music_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.Music, new_value)
	GameSettings.music_volume = new_value
	GameSettings.apply_all()

func on_sfx_slider_value_changed(new_value):
	AudioServer.set_bus_volume_linear(AudioBus.SFX, new_value)
	GameSettings.sfx_volume = new_value
	GameSettings.apply_all()

func save_settings():
	GameSettings.save_all()
	get_tree().change_scene_to_file(MENU)

func volver():
	get_tree().change_scene_to_file(MENU)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_settings()
