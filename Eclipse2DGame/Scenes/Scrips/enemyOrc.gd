extends KinematicBody2D

var is_moving_left = true

var gravity = 10
var velocity = Vector2(0, 0)

var speed = 32 # pixels per second

onready var sprite = $Node2D/Sprite
onready var animPlayer = $AnimationPlayer

func _ready():
	start_walk()
	
func _physics_process(delta):
	if animPlayer.current_animation == "Attack":
		return
			
	move_character()
	detect_turn_around()
	
func move_character():	
	velocity.x = -speed if is_moving_left else speed
	
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
		
func 	hit():
	$AttackDetector.monitoring = true
	
func end_hit():
	$AttackDetector.monitoring = false
	
func start_walk():
	animPlayer.play("Walk")


func _on_PlayerDetector_body_entered(body):
	animPlayer.play("Attack")


func _on_AttackDetector_body_entered(body):
	get_tree().reload_current_scene()
