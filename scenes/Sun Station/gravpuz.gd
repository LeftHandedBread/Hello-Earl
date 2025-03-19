extends Node3D

func _ready() -> void:
	for area in self.get_children():
		if area is Area3D:
			area.gravity_space_override = Area3D.SPACE_OVERRIDE_COMBINE_REPLACE
			area.gravity_direction = Vector3(0,1,0)
			for coll in area.get_children():
				if coll is CollisionShape3D:
					coll.disabled = true
		if area is StaticBody3D:
			area.set_collision_layer_value(1, false)
			area.set_collision_layer_value(5, true)
			for coll in area.get_children():
				coll.disabled = true

func _process(delta: float) -> void:
	if GameManager.isUpsideDown:
		for area in self.get_children():
			if area is Area3D:
				for coll in area.get_children():
					if coll is CollisionShape3D:
						coll.disabled = false
			if area is StaticBody3D:
				for coll in area.get_children():
					coll.disabled = false
	
	else:
		for area in self.get_children():
			if area is Area3D:
				for coll in area.get_children():
					if coll is CollisionShape3D:
						coll.disabled = true
			if area is StaticBody3D:
				for coll in area.get_children():
					coll.disabled = true
	
