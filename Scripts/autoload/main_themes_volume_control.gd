extends AudioStreamPlayer

@onready var player := $"."
@onready var fade := get_node("AnimationPlayer")
var fin = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func finale():
	set("parameters/switch_to_clip", "end")
	fin = true

func up():
	if player.get("volume_db") != 0 and !fin:
		fade.play("fade volume")
	
func down():
	if !fin:
		fade.play_backwards("fade volume")
