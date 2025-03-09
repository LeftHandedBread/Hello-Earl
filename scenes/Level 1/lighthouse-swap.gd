extends SpotLight3D

@onready var downwards_light = $OmniLight3D
@onready var collision = $Area3D

func _process(_delta: float) -> void:
	if GameManager.currentLightType == GameManager.Light.RED:
		downwards_light.visible = false
		self.light_color = ("ffffee")
		collision.set_collision_mask_value(1, false)
		collision.set_collision_mask_value(2, true)
		collision.set_collision_layer_value(1, false)
		collision.set_collision_layer_value(2, true)
	else:
		self.visible = true
		downwards_light.visible = true
		self.light_color = ("ff0000")
		collision.set_collision_mask_value(1, true)
		collision.set_collision_mask_value(2, false)
		collision.set_collision_layer_value(1, true)
		collision.set_collision_layer_value(2, false)
