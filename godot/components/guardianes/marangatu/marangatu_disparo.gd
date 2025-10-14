extends Area2D
class_name DisparoMarangatu

@export var velocidad := 280
@export var velocidad_rotacion := 3
@export var daño := 40

var direction = Vector2.RIGHT

func _process(delta):
	position += direction * velocidad * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("pantalla"):
		queue_free()
		return
	if area.has_method("le_hacen_daño"):
		area.le_hacen_daño(daño)
		queue_free()
