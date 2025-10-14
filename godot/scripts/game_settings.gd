extends Node

const SETTINGS_PATH := "user://settings.cfg"

enum AudioBus {
	Master = 0,
	SFX = 1,
	Music = 2
}

var master_volume: float = 0.8
var sfx_volume: float = 0.7
var music_volume: float = 0.6
var resolution: Vector2i = Vector2i(1366, 768)
var fullscreen: bool = true

# Cargar desde disco al inicio
func _ready():
	#load_all()
	#apply_all()
	pass

func load_all() -> void:
	var cfg = ConfigFile.new()
	if cfg.load(SETTINGS_PATH) != OK:
		return

	# Video
	#resolution = Vector2i(
	#	int(cfg.get_value("video", "width", resolution.x)),
	#	int(cfg.get_value("video", "height", resolution.y))
	#)
	#fullscreen = bool(cfg.get_value("video", "fullscreen", fullscreen))

	# Audio
	master_volume = float(cfg.get_value("audio", "master", master_volume))
	sfx_volume = float(cfg.get_value("audio", "sfx", sfx_volume))
	music_volume = float(cfg.get_value("audio", "music", music_volume))

func save_all() -> void:
	var cfg = ConfigFile.new()

	# Video
	#cfg.set_value("video", "width", resolution.x)
	#cfg.set_value("video", "height", resolution.y)
	#cfg.set_value("video", "fullscreen", fullscreen)

	# Audio
	cfg.set_value("audio", "master", master_volume)
	cfg.set_value("audio", "sfx", sfx_volume)
	cfg.set_value("audio", "music", music_volume)

	cfg.save(SETTINGS_PATH)

func apply_all() -> void:
	# Video
	#DisplayServer.window_set_size(resolution)

	#if fullscreen:
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	#else:
	#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	# Audio
	AudioServer.set_bus_volume_linear(AudioBus.Master, master_volume)
	AudioServer.set_bus_volume_linear(AudioBus.SFX, sfx_volume)
	AudioServer.set_bus_volume_linear(AudioBus.Music, music_volume)
