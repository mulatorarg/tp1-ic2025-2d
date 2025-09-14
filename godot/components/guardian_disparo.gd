extends Area2D
class_name GuardianDisparo

@export var velocidad := 300
@export var velocidad_rotacion := 3
@export var daño := 50

var direction = Vector2.RIGHT

func _process(delta):
	position += direction * velocidad * delta
	rotation += velocidad_rotacion * delta

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("le_hacen_daño"):
		area.le_hacen_daño(daño)
		queue_free()
	else:
		print(area.name + " No tiene le_hacen_daño")
