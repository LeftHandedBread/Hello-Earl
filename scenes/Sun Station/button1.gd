extends Interactible3D

@onready var button = $"../AnimationPlayer"
@onready var buttoncoll = $CollisionShape3D

func _interact() -> void:
	button.play("press")
	buttoncoll.disabled = true
	await button.animation_finished
	$"../../../the cracker/World".queue_free()
	$"../../button 2/Interactible3D".butEna()

func _ready() -> void:
	OnInteract.connect(_interact.bind())

func butEna():
	button.play_backwards("press")
	buttoncoll.disabled = false
