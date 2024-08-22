extends CharacterBody2D

@export var speed: float = 150.0
@export var gravity: float = 1000.0
@export var jump_force: float = -300.0

func _physics_process(delta):
	# Apply gravity to the built-in velocity property
	velocity.y += gravity * delta
	
	# Handle player movement
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("idle")
	
	# Jumping logic (now roll)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	# Ensure roll animation continues mid-air
	if !is_on_floor():
		$AnimatedSprite2D.play("jumping")
	
	# Move and slide the player
	move_and_slide()
