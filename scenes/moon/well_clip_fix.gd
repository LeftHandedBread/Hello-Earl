extends Area3D

@onready var player = $"../Player"
var insideArea = false

func _process(delta: float) -> void:
	if insideArea:
		if !GameManager.flashlightManager.flashlight_on:
				player.position = Vector3(-1.975671, 4.2, -41.87739)

func _on_body_entered(body: Node3D) -> void:
	if GameManager.currentLightType == GameManager.Light.NORMAL:
		insideArea = true

func _on_body_exited(body: Node3D) -> void:
	insideArea = false
