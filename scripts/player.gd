extends CharacterBody2D

@export var speed: float = 150.0
@export var gravity: float = 1000.0
@export var jump_force: float = -300.0

var is_jumping: bool = false
var jump_timer: float = 0.0
@export var min_air_time: float = 0.1  # Minimum time in the air before checking if landed

func _physics_process(delta):
	# Apply gravity to the built-in velocity property
	velocity.y += gravity * delta
	
	# Handle player movement
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$AnimatedSprite2D.flip_h = false
		if is_on_floor() and !is_jumping:
			$AnimatedSprite2D.play("run")
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = true
		if is_on_floor() and !is_jumping:
			$AnimatedSprite2D.play("run")
	else:
		velocity.x = 0
		if is_on_floor() and !is_jumping:
			$AnimatedSprite2D.play("idle")
	
	# Jumping logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true
		jump_timer = 0.0  # Reset the jump timer
		$AnimatedSprite2D.play("jumping")  # Play the jump animation

	# Update jump timer while in the air
	if is_jumping and !is_on_floor():
		jump_timer += delta
		if $AnimatedSprite2D.animation != "jumping":
			$AnimatedSprite2D.play("jumping")

	# Check if the player has landed after the minimum air time
	if is_on_floor():
		if jump_timer > min_air_time:
			is_jumping = false
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")

	# Move and slide the player
	move_and_slide()
