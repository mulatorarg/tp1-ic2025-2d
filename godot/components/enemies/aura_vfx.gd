extends Node2D

@export var color: Color = Color(0.8, 0.3, 0.6, 0.15)
@export var tint: Color = Color(0.8, 0.3, 0.6, 1.0)
@export var base_alpha: float = 0.15
@export var pulse_amplitude: float = 0.1
@export var pulse_speed: float = 1.2
@export var ring_amp: float = 0.25
@export var ring_speed: float = 0.6
@export var ring_freq: float = 1.0
@export var ring_width: float = 0.15

var _sprite: Sprite2D
var _mat: ShaderMaterial
var _highlight: float = 0.0
var _cached_radius: float = -1.0

func _ready():
	# Crea un Sprite2D con un círculo procedural grande (Texture2D circular simple)
	_sprite = Sprite2D.new()
	_sprite.texture = _make_circle_texture(256)
	_mat = ShaderMaterial.new()
	_mat.shader = load("res://components/enemies/aura_vfx_shader.tres")
	_sprite.material = _mat
	add_child(_sprite)
	_update_material()
	_update_scale_to_aura()

func set_highlight(active: bool) -> void:
	_highlight = 1.0 if active else 0.0
	_update_material()

func _update_material():
	if not _mat:
		return
	_mat.set_shader_parameter("tint", tint)
	_mat.set_shader_parameter("base_alpha", base_alpha)
	_mat.set_shader_parameter("pulse_amp", pulse_amplitude)
	_mat.set_shader_parameter("pulse_speed", pulse_speed)
	_mat.set_shader_parameter("highlight", _highlight)
	_mat.set_shader_parameter("ring_amp", ring_amp)
	_mat.set_shader_parameter("ring_speed", ring_speed)
	_mat.set_shader_parameter("ring_freq", ring_freq)
	_mat.set_shader_parameter("ring_width", ring_width)

func refresh_radius():
	_cached_radius = -1.0
	_update_scale_to_aura()

func _update_scale_to_aura():
	var aura := get_parent()
	if aura and aura.has_node("CollisionShape2D"):
		var cs: CollisionShape2D = aura.get_node("CollisionShape2D")
		var radius := 100.0
		if cs.shape is RectangleShape2D:
			var rect: RectangleShape2D = cs.shape
			radius = max(rect.size.x * cs.scale.x, rect.size.y * cs.scale.y) * 0.5
		if is_equal_approx(radius, _cached_radius):
			return
		_cached_radius = radius
		# La textura es de 256 px de diámetro; ajustamos el scale al radio deseado
		var diameter_px := 256.0
		var new_scale := (radius * 2.0) / diameter_px
		_sprite.scale = Vector2(new_scale, new_scale)

func _make_circle_texture(size: int) -> ImageTexture:
	var img := Image.create_empty(size, size, false, Image.FORMAT_RGBA8)
	#img.lock()
	var center := Vector2(size * 0.5, size * 0.5)
	var r := float(size) * 0.5
	for y in size:
		for x in size:
			var p := Vector2(x, y)
			var d := p.distance_to(center)
			var new_alpha : float = 1.0 - clamp((d - r * 0.85) / (r * 0.15), 0.0, 1.0)
			var col := Color(1, 1, 1, new_alpha)
			img.set_pixel(x, y, col)
	#img.unlock()
	var tex := ImageTexture.create_from_image(img)
	return tex
