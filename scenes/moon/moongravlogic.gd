extends Area3D

@onready var gravcoll = $"../CollisionShape3D"

var ohbaby = false

func _ready():
	connect("body_entered", Callable(self, "_on_area_entered"))
	connect("body_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(body):
	if GameManager.currentLightType == GameManager.Light.NORMAL and ohbaby:
		gravcoll.disabled = true
		GameManager.sungrav = true

func moongrav():
	ohbaby = true
