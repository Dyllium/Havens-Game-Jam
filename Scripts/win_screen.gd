extends Node2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	audio_stream_player_2d_2.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
