extends Node

var collision_pairs = []

func _ready():
	set_process(true)  # Enable per-frame processing

func _process(delta):
	if collision_pairs.size() > 0:
		print("Active Collision Pairs: ")
		for pair in collision_pairs:
			print(pair[0], " <--> ", pair[1])
		print("Total Pairs: ", collision_pairs.size())
	collision_pairs.clear()  # Reset for next frame

func register_collision(a, b):
	collision_pairs.append([a.name, b.name])
