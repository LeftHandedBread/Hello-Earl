extends CanvasLayer

@onready var ani = $AnimationPlayer
@onready var timer = $Timer

var lefty = false
var didit = false
var first = true
var rmbvis = false
var rmbCount = 0

func _process(delta: float) -> void:
	if lefty:
		if !didit and GameManager.flashlightManager.flashlight_on:
			didit = true
		if didit:
			if timer.time_left <= 0:
				if first:
					timer.start()
					first = false
					return
				ani.play_backwards("LMB")
				lefty = false
			

func LMB():
	if rmbCount < 4:
		await ani.animation_finished
	ani.play("LMB")
	lefty = true

func RMBin():
	if !rmbvis and rmbCount < 4:
		ani.play("RMB")
		rmbvis = true

func RMBout():
	if rmbvis:
		ani.play_backwards("RMB")
		rmbvis = false
