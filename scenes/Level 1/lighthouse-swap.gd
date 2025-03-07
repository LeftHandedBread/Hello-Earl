extends SpotLight3D

@onready var downwards_light = $SpotLight3D

func _process(_delta: float) -> void:
	if GameManager.currentLightType == GameManager.Light.RED:
		self.visible = false
		downwards_light.visible = false
	else:
		self.visible = true
		downwards_light.visible = true
