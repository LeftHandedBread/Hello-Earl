extends Node

var is_visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_visibility()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.timeOfDay > .55 and GameManager.timeOfDay < .95:
		if !is_visible:
			enable_visibility()
			is_visible = true
	else:
		if is_visible:
			disable_visibility()
			is_visible = false

func enable_visibility():
	for child in get_all_children(self):
		if child is MeshInstance3D and !child.is_in_group("collider only"):
			child.visible = true
		if child is CollisionShape3D:
			child.set_disabled(false)


func disable_visibility():
	for child in get_all_children(self):
		if child is MeshInstance3D:
			child.visible = false
		if child is CollisionShape3D:
			child.set_disabled(true)


func get_all_children(node: Node) -> Array:
	var all_children = [] 
	for child in node.get_children():
		all_children.append(child)  # Add direct child to the list
		# Recursively add its children (subchildren, etc.)
		all_children += get_all_children(child)     
	return all_children
