extends Area2D

@export var health := 200

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
