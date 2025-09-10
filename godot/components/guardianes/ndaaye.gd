extends Area2D

@export var attack_interval := 2.0
@onready var ProjectileScene = preload("res://components/projectile.tscn")

func _ready():
	var timer = Timer.new()
	timer.wait_time = attack_interval
	timer.timeout.connect(shoot)
	add_child(timer)
	timer.start()

func shoot():
	var arrow = ProjectileScene.instantiate()
	arrow.position = position
	arrow.direction = Vector2.RIGHT
	get_parent().add_child(arrow)
