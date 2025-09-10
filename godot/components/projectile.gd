extends Area2D

@export var speed := 200
@export var damage := 50
var direction = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
