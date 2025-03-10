extends SpotLight3D

@onready var downwards_light = $OmniLight3D
@onready var collision = $Area3D
@onready var coll4plats = $Area3D2

func _process(_delta: float) -> void:
	pass

func flipper(depot):
	if depot == 1:
		downwards_light.light_color = ("ffffee")
		self.light_color = ("ffffee")
		collision.set_collision_mask_value(1, false)
		collision.set_collision_mask_value(2, true)
		collision.set_collision_layer_value(1, false)
		collision.set_collision_layer_value(2, true)
		
		coll4plats.set_collision_mask_value(1, false)
		coll4plats.set_collision_mask_value(2, true)
		coll4plats.set_collision_layer_value(1, false)
		coll4plats.set_collision_layer_value(2, true)
		
	if depot == 2:
		downwards_light.light_color = ("ff0000")
		self.light_color = ("ff0000")
		collision.set_collision_mask_value(1, true)
		collision.set_collision_mask_value(2, false)
		collision.set_collision_layer_value(1, true)
		collision.set_collision_layer_value(2, false)
		
		coll4plats.set_collision_mask_value(1, true)
		coll4plats.set_collision_mask_value(2, false)
		coll4plats.set_collision_layer_value(1, true)
		coll4plats.set_collision_layer_value(2, false)
