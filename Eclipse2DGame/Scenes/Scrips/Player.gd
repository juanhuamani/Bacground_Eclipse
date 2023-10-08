extends KinematicBody2D

const DISPARO = preload("res://Scenes//Disparo.tscn")
var tiempoHastaDisparo = 0.0
var tiiempoPorCadaDisparo = 0.6

export(int) var JUMP_FORCE = -250
export(int) var JUMP_RELEASE_FORCE = -10
export(int) var MAX_SPEED = 100
export(int) var ACCELERATION = 20
export(int) var FRICION = 10
export(int) var GRAVITY = 5
export(int) var ADDITIONAL_FALL_GRAVITY = 10

var velocity = Vector2.ZERO; 

onready var sprite = $AnimPlayer/Sprite
onready var animTree = $AnimPlayer/AnimationTree
onready var animTreePlayback = animTree.get("parameters/playback")

func _ready():
	animTree.active = true

func _physics_process(delta):
	tiempoHastaDisparo += delta
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		apply_friction()
	else:
		apply_acceleration(input.x)
	
	if is_on_floor():
		
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:				
		#animPlayer.play("Jump")
		animTreePlayback.travel("Jump")
		# can't release many consecutive jumps
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:			
			velocity.y = JUMP_RELEASE_FORCE			
		
		# fast fell
		if velocity.y > 10:			
			velocity.y += ADDITIONAL_FALL_GRAVITY
		
	if Input.is_action_just_pressed("Attack"):
		attack_player()
		
	velocity = move_and_slide(velocity, Vector2.UP)
		
	if Input.is_key_pressed(KEY_SPACE):
		disparar()

func apply_gravity():
	velocity.y += GRAVITY
	
func apply_friction():	
	velocity.x = move_toward(velocity.x, 0, FRICION)
	animTreePlayback.travel("Idle")

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)	
	# amount > 0, player mira a la derecha, else mira a la izquierda
	if amount > 0:			
			sprite.flip_h = false
			#animPlayer.play("Walk")
			animTreePlayback.travel("Walk")
	elif amount < 0:
			sprite.flip_h = true
			#animPlayer.play("Walk")
			animTreePlayback.travel("Walk")

func attack_player():
	animTreePlayback.travel("Attack")

func disparar():
	attack_player()
	$Timer.start(5)
	_on_Timer_timeout()

func _on_Timer_timeout():
	if tiempoHastaDisparo >= tiiempoPorCadaDisparo:
		tiempoHastaDisparo = 0.0
		var disparo = DISPARO.instance()
		if sprite.flip_h:
			disparo.scale.x = -1
			disparo.position= position - Vector2(20,3)
			disparo.velocidad=-400
			get_parent().add_child(disparo)	
		else:
			disparo.scale.x = 1
			disparo.position= position - Vector2(-10,3)
			disparo.velocidad=400
			get_parent().add_child(disparo)
		$Timer.is_stopped()
