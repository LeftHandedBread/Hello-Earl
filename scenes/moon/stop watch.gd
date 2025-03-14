extends Interactible3D

@onready var wellwatch = $".."
@onready var bodywatch = $"../../Player/Node3D"


func _ready() -> void:
	OnInteract.connect(_interact.bind())
	bodywatch.visible = false

## Override function. Called when OnInteract is fired. Does nothing, since you're supposed to override it
func _interact() -> void:
	bodywatch.visible = true
	wellwatch.queue_free()
