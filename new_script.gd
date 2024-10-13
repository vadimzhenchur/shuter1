extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var anima_player = $player_17_4/AnimationPlayer

@onready var bullet_gun = load("res://bullet.tscn")
@onready var ray = $RayCast3D

var GUN = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anima_player.play("jump_001")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

var rot_y = 0.0
var rot_x = 0.0
var rot = 0.1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	
	if event is  InputEventMouseMotion:
		rot_y -= event.relative.x * rot
		rot_x -= event.relative.y * rot
		transform.basis = Basis(Vector3(0,1,0), rot_y)
		
	if Input.is_action_just_pressed("mouse_change"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_just_pressed("get_gun"):
		anima_player.play("get_gun")
		GUN = true
		
	if Input.is_action_just_pressed("shoot") and GUN == true:
		var inst = bullet_gun.instantiate()
		inst.position = ray.global_position
		#inst.transform.basis = ray.global_transform.basis
		get_tree().get_root().add_child(inst)
	

