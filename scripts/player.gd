extends CharacterBody2D  # Ensure this script is attached to a CharacterBody2D node

@export var speed: float = 150.0
@export var gravity: float = 1000.0
@export var jump_force: float = -300.0
@export var min_air_time: float = 0.1  # Minimum time in the air before checking if landed

var is_jumping: bool = false
var jump_timer: float = 0.0

func _physics_process(delta):
	# Apply gravity to the built-in velocity property
	velocity.y += gravity * delta
	
	var is_moving = false
	
	# Handle horizontal movement and animations
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		$AnimatedSprite2D.flip_h = false
		is_moving = true
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		$AnimatedSprite2D.flip_h = true
		is_moving = true
	else:
		velocity.x = 0
	
	# Update animation only if on the ground and not jumping
	if is_on_floor() and !is_jumping:
		if is_moving:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true
		jump_timer = 0.0  # Reset the jump timer
		$AnimatedSprite2D.play("jumping")  # Play the jump animation

	# Update jump timer and ensure jump animation continues in the air
	if is_jumping:
		jump_timer += delta
		if !is_on_floor() and $AnimatedSprite2D.animation != "jumping":
			$AnimatedSprite2D.play("jumping")
	
	# Reset jump state after landing
	if is_on_floor() and jump_timer > min_air_time:
		is_jumping = false
	
	# Move the player
	move_and_slide()
