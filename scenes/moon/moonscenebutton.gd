extends Interactible3D

@onready var button = $".."
@onready var door = $"../../Node3D"
@onready var buttoncoll = $CollisionShape3D

func _interact() -> void:
	button.press()
	door.open()
	buttoncoll.disabled = true
	$"../..".doorcoll()

func _ready() -> void:
	OnInteract.connect(_interact.bind())
