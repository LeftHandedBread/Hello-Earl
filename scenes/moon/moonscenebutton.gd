extends Interactible3D

@onready var button = $".."
@onready var door = $"../../Node3D"
@onready var buttoncoll = $CollisionShape3D
@onready var gravcoll = $"../../Area3D/CollisionShape3D"
@onready var gravfade = $"../../Area3D/AnimationPlayer"

func _interact() -> void:
	button.press()
	door.open()
	buttoncoll.disabled = true
	$"../..".doorcoll()
	gravcoll.disabled = false
	gravfade.play("grav fade")

func _ready() -> void:
	OnInteract.connect(_interact.bind())
