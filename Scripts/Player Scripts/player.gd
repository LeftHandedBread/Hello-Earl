class_name PlayerCharacter
extends CharacterBody3D

enum CharacterState {
	WALKING = 0,
	CROUCHING = 1,
	SPRINTING = 2
}

# Node references
@onready var head := $head
@onready var plrGUI := $PlayerGUI
@onready var InteractRaycast := $head/RayCast3D
@onready var camera := $head/Camera3D
@onready var animator := $AnimationPlayer

# State variables
var currentBody : Interactible3D = null
var currentState : CharacterState = CharacterState.WALKING
@onready var SPEED = DEFAULT_SPEED 

# Movement settings
@export var DEFAULT_SPEED := 4.5  # Feels closer to HL2
@export var SPRINT_SPEED := 7.0
@export var CROUCH_SPEED := 2.5
@export var JUMP_VELOCITY := 4.5  
@export var AIR_ACCELERATION := 15.0  
@export var GROUND_ACCELERATION := 50.0  
@export var FRICTION := 8.0  
@export var GRAVITY := 20.0  # Stronger gravity for a more grounded feel
@export var mouse_sensitivity := 0.1

var wish_dir := Vector3.ZERO
var inputEnabled := true  
var aimlookEnabled := true  
var interactionsEnabled := true  
var is_sprinting := false

# Character state handling (moved up to fix error)
func change_state(state : CharacterState):
	match state:
		CharacterState.CROUCHING:
			animator.play("crouch")
			SPEED = CROUCH_SPEED
		CharacterState.WALKING:
			if currentState == CharacterState.CROUCHING:
				animator.play_backwards("crouch")
			SPEED = DEFAULT_SPEED
		CharacterState.SPRINTING:
			if currentState == CharacterState.CROUCHING:
				animator.play_backwards("crouch")
			SPEED = SPRINT_SPEED
	currentState = state

func _ready():
	$MeshInstance3D.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player = self
	change_state(CharacterState.WALKING)  # Now this works correctly

func _physics_process(delta: float) -> void:
	if !inputEnabled:
		return
	
	apply_gravity(delta)
	process_movement(delta)
	move_and_slide()
	
	_process_interact()
	_handle_states()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

func process_movement(delta):
	var input_dir = Vector3.ZERO
	input_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_dir.z = Input.get_action_strength("down") - Input.get_action_strength("up")

	is_sprinting = Input.is_action_pressed("sprint")

	# Get direction relative to camera
	var basis = global_transform.basis
	wish_dir = (basis.x * input_dir.x + basis.z * input_dir.z).normalized()

	var target_speed = SPRINT_SPEED if is_sprinting else DEFAULT_SPEED

	if is_on_floor():
		apply_friction(delta)
		accelerate(wish_dir, target_speed, GROUND_ACCELERATION, delta)
		if Input.is_action_just_pressed("jump"):
			jump()
	else:
		accelerate(wish_dir, target_speed, AIR_ACCELERATION, delta)

func accelerate(wishdir: Vector3, target_speed: float, acceleration: float, delta: float):
	var speed = velocity.length()
	var add_speed = target_speed - speed
	if add_speed <= 0:
		return
	
	var accel_amount = min(acceleration * delta * target_speed, add_speed)
	velocity += wishdir * accel_amount

func apply_friction(delta):
	if velocity.length() > 0:
		var drop = velocity.length() * FRICTION * delta
		velocity = velocity.normalized() * max(velocity.length() - drop, 0)

func jump():
	velocity.y = JUMP_VELOCITY

# Interaction system
func _process_interact():
	if !interactionsEnabled:
		return
	
	if not InteractRaycast.is_colliding():
		plrGUI.update_text("")
		return
	
	var collider = InteractRaycast.get_collider()
	
	if not collider is Interactible3D:
		plrGUI.update_text("")
		return
	
	if collider == currentBody and not Input.is_action_just_pressed("interact"):
		plrGUI.update_text(currentBody.InteractText)
		return
	
	currentBody = collider
	plrGUI.update_text(currentBody.InteractText)
	
	if Input.is_action_just_pressed("interact") && currentBody.CanInteract:
		currentBody.OnInteract.emit()

# Mouse look system
func _unhandled_input(event : InputEvent):
	if !aimlookEnabled:
		return
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouseInput : Vector2
		if !GameManager.isUpsideDown: 
			mouseInput.x += event.relative.x
			mouseInput.y += event.relative.y
			self.rotation_degrees.y -= mouseInput.x * mouse_sensitivity
			head.rotation_degrees.x -= mouseInput.y * mouse_sensitivity
		else:
			mouseInput.x -= event.relative.x
			mouseInput.y += event.relative.y
			self.rotation_degrees.y -= mouseInput.x * mouse_sensitivity
			head.rotation_degrees.x -= mouseInput.y * mouse_sensitivity

	var head_x_rot = fposmod(head.rotation_degrees.x, 360)
	GameManager.isUpsideDown = head_x_rot > 100 and head_x_rot < 260

# Handles crouching, sprinting, walking
func _handle_states():
	if Input.is_action_pressed("crouch"):
		if currentState != CharacterState.CROUCHING:
			change_state(CharacterState.CROUCHING)
			return
	elif Input.is_action_pressed("sprint"):
		if currentState != CharacterState.SPRINTING:
			change_state(CharacterState.SPRINTING)
			return
	else:
		if currentState != CharacterState.WALKING:
			change_state(CharacterState.WALKING)

# Sitting system
var is_sitting = false
var can_sit = true
var original_parent = null  
var original_rotation : Quaternion
var original_position : Vector3

func sit(seat: Node3D):
	if is_sitting:
		return

	inputEnabled = false
	interactionsEnabled = true
	is_sitting = true
	original_parent = get_parent()
	reparent(seat)
	global_transform = seat.global_transform

func stand_up():
	if not is_sitting:
		return

	is_sitting = false
	reparent(original_parent)
	inputEnabled = true
	interactionsEnabled = true

func reset_shoe_effects():
	JUMP_VELOCITY = 300.0
	DEFAULT_SPEED = 320.0
	SPRINT_SPEED = 450.0
