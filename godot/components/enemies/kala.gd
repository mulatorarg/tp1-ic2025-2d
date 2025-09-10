extends Area2D

@export var speed := 40
@export var health := 100

func _process(delta):
	position.x -= speed * delta
	if position.x <= 0:
		print("¡Ao Ao llegó a la aldea! Game Over")
		get_tree().paused = true

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
