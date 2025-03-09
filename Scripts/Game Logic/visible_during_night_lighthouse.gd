##This script seemed like it was made to through on anything, but for some reason assumed it was
##specific to only the lighthouse. i may have un generiscized it. my bad



extends Node

@onready var fader = $AnimationPlayer

var is_visible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_visibility()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GameManager.timeOfDay > .53 and GameManager.timeOfDay < 1:
		if !is_visible:
			enable_visibility()
			is_visible = true
	else:
		if is_visible:
			disable_visibility()
			is_visible = false

func enable_visibility():
	fader.play("fade")
	for child in get_all_children(self):
		if child is CollisionShape3D:
			child.set_disabled(false)


func disable_visibility():
	fader.play_backwards("fade")
	for child in get_all_children(self):
		if child is CollisionShape3D:
			child.set_disabled(true)


func get_all_children(node: Node) -> Array:
	var all_children = [] 
	for child in node.get_children():
		all_children.append(child)  # Add direct child to the list
		# Recursively add its children (subchildren, etc.)
		all_children += get_all_children(child)     
	return all_children
