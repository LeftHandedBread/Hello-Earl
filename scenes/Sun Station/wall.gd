extends Node3D

func _ready() -> void:
	$StaticBody3D/CollisionShape3D.disabled = true
	for mesh in $".".get_children():
		if mesh is MeshInstance3D:
			mesh.visible = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		for mesh in $".".get_children():
			if mesh is MeshInstance3D:
				mesh.visible = true
		$StaticBody3D/CollisionShape3D.call_deferred("set", "disabled", false)
