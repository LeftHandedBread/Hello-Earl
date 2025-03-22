extends Interactible3D

@onready var button = $"../AnimationPlayer"
@onready var buttoncoll = $CollisionShape3D

func _interact() -> void:
	button.play("press")
	buttoncoll.disabled = true
	await button.animation_finished
	$"../../../the cracker/Icosphere".queue_free()
	$"../../button 3/Interactible3D".butEna()

func _ready() -> void:
	OnInteract.connect(_interact.bind())
	button.play("press")

func butEna():
	button.play_backwards("press")
	buttoncoll.disabled = false
