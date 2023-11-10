extends CharacterBody2D


@export var SPEED = 500.0
@export var JUMP_VELOCITY = -1000.0
@export var DECELERATION = 1000;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 800*2


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		velocity.y += JUMP_VELOCITY;
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = SPEED * direction ;
	
	if velocity.x > 0: 
		if velocity.x - DECELERATION*delta < 0:
			velocity.x = 0
		else:
			velocity.x -= DECELERATION * delta;
	if velocity.x < 0: 
		if velocity.x + DECELERATION*delta > 0:
			velocity.x = 0
		else:
			velocity.x += DECELERATION * delta;

	move_and_slide()
