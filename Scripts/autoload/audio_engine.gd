extends Node

@export var track_a: AudioStream
@export var track_b: AudioStream
@export var track_c: AudioStream
@export var track_d: AudioStream
@export var track_e: AudioStream
@export var track_f: AudioStream
@export var track_g: AudioStream
@export var track_h: AudioStream
@export var track_i: AudioStream
@export var track_j: AudioStream

var audio_player: AudioStreamPlayer
var next_player: AudioStreamPlayer
var tween: Tween
var queue: Array = []
var looping = false
var looping_track: AudioStream = null  # Track that should loop
var is_crossfading = false  # Prevents accidental replays

func _ready():
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(_on_track_finished)

func play_music(track_number: int):
	queue.clear()
	looping = false
	looping_track = null  # Reset looping track
	is_crossfading = false  # Reset crossfade flag

	match track_number:
		1:
			queue.append(track_a)
		2:
			queue.append(track_c)  # Only queue C, never B (B will be handled separately)
			looping = true
			looping_track = track_c  # Only C loops
		3:
			queue.append(track_d)
			queue.append(track_e)
			looping = true
			looping_track = track_e
		4:
			queue.append(track_f)
			queue.append(track_g)
			looping = true
			looping_track = track_g
		5:
			queue.append(track_h)
			queue.append(track_i)
			looping = true
			looping_track = track_i
		6:
			queue.append(track_j)

	if track_number == 2 and audio_player.stream == track_a and audio_player.playing:
		crossfade_to(track_b)  # Smooth crossfade A → B
	else:
		play_next()

func crossfade_to(next_track: AudioStream):
	if is_crossfading:
		return  # Prevent multiple crossfade calls

	is_crossfading = true  # Set flag to prevent duplicate calls

	next_player = AudioStreamPlayer.new()
	add_child(next_player)
	next_player.stream = next_track
	next_player.volume_db = -30  # Start silent
	next_player.play()
	
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(audio_player, "volume_db", -30, 3.0)  # Fade out A (3 sec)
	tween.tween_property(next_player, "volume_db", 0, 4.0)  # Longer fade-in for B (4 sec)

	await tween.finished

	remove_child(audio_player)
	audio_player.queue_free()
	audio_player = next_player
	audio_player.finished.connect(_on_track_finished)

	is_crossfading = false  # Reset flag after transition

	# After B finishes, directly transition to C
	audio_player.finished.connect(_play_c_after_b)

func _play_c_after_b():
	audio_player.finished.disconnect(_play_c_after_b)  # Prevent multiple calls
	audio_player.stream = track_c
	audio_player.play()

func play_next():
	if queue.is_empty():
		return

	var next_track = queue.pop_front()
	audio_player.stream = next_track
	audio_player.play()

func _on_track_finished():
	if looping and queue.is_empty():
		if looping_track:
			audio_player.stream = looping_track
			audio_player.play(0.01)  # Small offset ensures no pause in looping
	else:
		play_next()
