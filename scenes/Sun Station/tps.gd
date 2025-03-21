extends Node3D

@onready var basementDoor = $outhouse/Node3D
@onready var upperDoor = $outhouse2/Node3D
@onready var player = $"../Player"
@onready var tpVec = $outhouse.position - $outhouse2.position

var inBasement = false
var inUpper = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if inBasement and basementDoor.rotation == Vector3.ZERO:
		player.change_state(player.CharacterState.WALKING)
		player.scale = $outhouse2.scale
		player.rotation += Vector3(0, 90, 0)
		player.head.rotation += Vector3(180, 0, 0)
		player.position = Vector3(31.5, 7.037, -8.345)
		player.DEFAULT_SPEED = 1
		player.SPRINT_SPEED = 1.625
		player.CROUCH_SPEED = 0.625
		$"../WorldEnvironment".environment.fog_enabled = true


func _on_basement_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	if !basementDoor.rotation == Vector3.ZERO:
		inBasement = true


func _on_upper_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	if !upperDoor.rotation == Vector3.ZERO:
		inUpper = true

func _on_upper_body_exited(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	inUpper = false
	player.secret(true)


func _on_basement_body_exited(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	inBasement = false
	
