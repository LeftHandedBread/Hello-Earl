extends Node3D

@onready var timer = $"../flipperfade"

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

func _process(_delta: float) -> void:
	if GameManager.isUpsideDown:
		flipper(false)
		for area in self.get_children():
			if area is Area3D:
				for coll in area.get_children():
					if coll is CollisionShape3D:
						coll.disabled = false
			if area is StaticBody3D:
				for coll in area.get_children():
					coll.disabled = false
	
	else:
		flipper(true)
		for area in self.get_children():
			if area is Area3D:
				for coll in area.get_children():
					if coll is CollisionShape3D:
						coll.disabled = true
			if area is StaticBody3D:
				for coll in area.get_children():
					coll.disabled = true
	

func flipper(normal):
	if !normal and GameManager.player.feltGrav == Vector3(0, 9.8, 0):
		if GameManager.player.body.position >= Vector3(0, .95, 0):
			return
		if timer.time_left <= 0:
			timer.start()
		GameManager.player.body.position = Vector3(0, 1 - (timer.time_left / timer.wait_time), 0)
	else:
		if !GameManager.player.body.position <= Vector3(0, 0.05, 0):
			if timer.time_left <= 0:
				timer.start()
		GameManager.player.body.position = Vector3(0, timer.time_left / timer.wait_time, 0)
