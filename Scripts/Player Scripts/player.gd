class_name PlayerCharacter
extends CharacterBody3D

enum CharacterState {
	WALKING = 0,
	CROUCHING = 1,
	SPRINTING = 2
}

# All of the actually important stuff
@onready var head := $head
@onready var plrGUI := $PlayerGUI
@onready var InteractRaycast := $head/RayCast3D
@onready var camera := $head/Camera3D
@onready var animator := $AnimationPlayer
var currentBody : Interactible3D = null
var currentState : CharacterState = CharacterState.WALKING
@onready var SPEED = DEFAULT_SPEED # DEFAULT_SPEED doesn't load until _ready(), so we have to use @onready (you could also just move SPEED a bit to the bottom)

# Options
@export var DEFAULT_SPEED := 4
@export var SPRINT_SPEED := 7.5
@export var JUMP_VELOCITY := 7.5
@export var mouse_sensitivity := 0.1
@export var CROUCH_SPEED := 2.5
@export var GROUND_FRICTION := 10
@export var AIR_FRICTION := 0.5
@export var GRAVITY_MULTIPLIER := 2
var inputEnabled := true # can the player move?
var aimlookEnabled := true # can the player look around?
var interactionsEnabled := true # can the player interact with Interactibles3D?


#region Main control flow 

func _ready():
	$MeshInstance3D.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player = self
	change_state(CharacterState.WALKING)
	MusicTheme.minemuFade.play("wind fade")

func _physics_process(delta: float) -> void:
	if !inputEnabled:
		return
	
	up_direction = -get_gravity().normalized()
	#print(up_direction)
	
	# Apply gravity if in the air
	if not is_on_floor():
		velocity += get_gravity() * GRAVITY_MULTIPLIER * delta
	
	
	
	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$jump.pitch_scale = randf() * 0.2 + 0.8
		$jump.play()
	
	# Get movement input
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if !GameManager.isUpsideDown :
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		$CollisionShape3D2.position = Vector3(0, -0.53, -0.321)
	elif GameManager.isUpsideDown :
		direction = (transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()
		$CollisionShape3D2.position = Vector3(0, -0.53, 0.321)
	
	#tryna disable movement when flying into sun
	if GameManager.sungrav:
		direction = (transform.basis * Vector3.ZERO)

	# Movement
	if direction != Vector3.ZERO:
		# Accelerate towards movement direction
		velocity.x = lerp(velocity.x, direction.x * SPEED, 0.1)  # Adjust 0.1 for smoothness
		velocity.z = lerp(velocity.z, direction.z * SPEED, 0.1)  # Adjust 0.1 for smoothness
	else:
		# Apply friction to gradually stop movement
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, GROUND_FRICTION * delta)
			velocity.z = move_toward(velocity.z, 0, GROUND_FRICTION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_FRICTION * delta)
			velocity.z = move_toward(velocity.z, 0, AIR_FRICTION * delta)
	if GameManager.characterShoes == GameManager.Shoes.NONE:
		reset_shoe_effects()
	elif GameManager.characterShoes == GameManager.Shoes.COKE:
		reset_shoe_effects()
		JUMP_VELOCITY = 17
	elif GameManager.characterShoes == GameManager.Shoes.NICOTINE:
		reset_shoe_effects()
		DEFAULT_SPEED = 5
		SPRINT_SPEED = 12
	elif GameManager.characterShoes == GameManager.Shoes.LEAD:
		reset_shoe_effects()
		DEFAULT_SPEED = .01
		SPRINT_SPEED = .01
	
	
	if velocity.length() != 0 and is_on_floor():
		if $Timer.time_left <= 0:
			
			$stepping.pitch_scale = randf() * 0.2 + 0.8
			$stepping.volume_db = randf() * 2.0 - 5.0
			$stepping.play()
			if currentState == CharacterState.WALKING:
				$Timer.start(randf() * 0.1 + 0.4)
			if currentState == CharacterState.SPRINTING:
				$Timer.start(randf() * 0.1 + 0.2)
			if currentState == CharacterState.CROUCHING:
				$Timer.start(randf() * 0.1 + 0.75)
	
	
	# All of the other processing functions go here
	_process_interact()
	_handle_states()
	
	move_and_slide()
#endregion

#region Processing input

func _process_interact():
	if !interactionsEnabled:
		return
	
	# Check if the raycast detects a collision
	if not InteractRaycast.is_colliding():
		plrGUI.update_text("")
		Hud.RMBout()
		return
	
	# Get the collider hit by the RayCast
	var collider = InteractRaycast.get_collider()
	var sign = false
	
	# Ensure the collider is an interactable object
	if not collider is Interactible3D:
		plrGUI.update_text("")
		Hud.RMBout()
		return
	
	if collider.get_parent().name == "sign":
		sign = true
	
	if collider == currentBody and not Input.is_action_just_pressed("interact"): # This is a bit hacky imo, but works
		plrGUI.update_text(currentBody.InteractText)
		if !sign:
			Hud.RMBin()
		return
	
	currentBody = collider
	plrGUI.update_text(currentBody.InteractText)
	if !sign:
		Hud.RMBin()
	if Input.is_action_just_pressed("interact") && currentBody.CanInteract:
		if !sign:
			Hud.rmbCount += 1
		currentBody.OnInteract.emit()


# Handles the mouse 🐁🐁🐁🐁🐁🐁🐁🐁
func _unhandled_input(event : InputEvent):
	if !aimlookEnabled:
		return
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouseInput : Vector2
		if !GameManager.isUpsideDown : 
			mouseInput.x += event.relative.x
			mouseInput.y += event.relative.y
			self.rotation_degrees.y -= mouseInput.x * mouse_sensitivity
			head.rotation_degrees.x -= mouseInput.y * mouse_sensitivity
		elif GameManager.isUpsideDown:
			mouseInput.x -= event.relative.x
			mouseInput.y += event.relative.y
			self.rotation_degrees.y -= mouseInput.x * mouse_sensitivity
			head.rotation_degrees.x -= mouseInput.y * mouse_sensitivity
	
	
	var head_x_rot = fposmod(head.rotation_degrees.x, 360)
	if !GameManager.isUpsideDown:
		if head_x_rot > 100 and head_x_rot < 260 :
			GameManager.isUpsideDown = true
		else :
			GameManager.isUpsideDown = false
	else:
		if head_x_rot > 80 and head_x_rot < 280 :
			GameManager.isUpsideDown = true
		else :
			GameManager.isUpsideDown = false
#endregion

#region Processing Character States

## Handles the input for character state changing. 
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
	

## Handles the state changing itself. This function must be fired only once, and not run every single frame. 
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
	
var is_sitting = false
var can_sit = true
var original_parent = null  # Store original parent
var original_rotation : Quaternion
var original_position : Vector3


func sit(seat: Node3D):
	if is_sitting:
		return

	# Disable movement
	inputEnabled = false
	interactionsEnabled = true
	is_sitting = true
	original_parent = get_parent()
	# Attach player to seat to inherit movement
	reparent(seat)
	# Align rotation and position
	global_transform = seat.global_transform


func stand_up():
	if not is_sitting:
		return

	is_sitting = false
	
	# Reattach player to the original parent (scene root or wherever it was)
	reparent(original_parent)

	# Re-enable movement
	inputEnabled = true
	interactionsEnabled = true


func reset_shoe_effects():
	JUMP_VELOCITY = 7.5
	DEFAULT_SPEED = 4
	SPRINT_SPEED = 7.5

#endregion
