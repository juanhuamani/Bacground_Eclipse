extends Area2D

export var velocidad : int = 400

func _ready():
	$Sprite.playing = true

func _process(delta):
	global_position.x += velocidad * delta

func _on_Disparo_area_exited(area):
	queue_free()

func _on_Disparo_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()

