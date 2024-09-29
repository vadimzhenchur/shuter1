extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var start_pos = position
@export var path_lenght = 10


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


var is_rotate = false
var rotate_angle = 0
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if  start_pos.distance_to(position) >= path_lenght/2:
		is_rotate= true
		
	var direction = (transform.basis * Vector3.FORWARD ).normalized()
	if is_rotate == true:
		rotate_y(0.1)
		rotate_angle += 0.1
		if rotate_angle >= deg_to_rad(180):
			is_rotate = false
			rotate_angle = 0
		else:
			direction = 0



	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
