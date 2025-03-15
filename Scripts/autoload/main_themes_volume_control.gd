extends AudioStreamPlayer

@onready var player := $"."
@onready var fade := get_node("AnimationPlayer")

@onready var minemu := $minemu
@onready var minemuFade :=$minemu/AnimationPlayer

var faded = false

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
		print("mainthemes fading up")
		player.set("parameter/stream_paused", false)
		fade.play("fade volume")
		faded = false
	
func down():
	if !fin and !faded:
		print("mainthemes fading down")
		fade.play_backwards("fade volume")
		faded = true
		await fade.animation_finished
		player.set("parameter/stream_paused", true)
