extends Interactible3D

@onready var button = $"../AnimationPlayer"
@onready var buttoncoll = $CollisionShape3D

func _interact() -> void:
	button.play("press")
	buttoncoll.disabled = true
	await button.animation_finished
	$"../../..".goodbye()

func _ready() -> void:
	OnInteract.connect(_interact.bind())
	button.play("press")

func butEna():
	button.play_backwards("press")
	buttoncoll.disabled = false
