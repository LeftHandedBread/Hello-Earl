extends Node3D

func apply(k):
	if k:
		for mesh in $".".get_children():
			if mesh is MeshInstance3D:
				mesh.visible = true
		
	else:
		for mesh in $".".get_children():
			if mesh is MeshInstance3D:
				mesh.visible = false
		
