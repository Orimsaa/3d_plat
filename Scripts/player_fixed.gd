extends CharacterBody3D

@export var move_speed : float = 6
@export var jump_force : float = 5

var is_grounded = false
var animation
var gravity = 20.0

func _ready():
	if has_node("Ch14_nonPBR2/AnimationPlayer"):
		animation = get_node("Ch14_nonPBR2/AnimationPlayer")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		if animation:
			animation.play("jump")
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
		if animation and is_on_floor():
			animation.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
		if animation and is_on_floor():
			animation.play("idle")
	
	move_and_slide()
