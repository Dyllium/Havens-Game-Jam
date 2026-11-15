extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const popupScene = preload("res://Scenes/popup_text.tscn")

@export var balls: Array[PackedScene]
var ballPrice: Array[int] = [10,20]

var type: int = 0
var maxSpawn: int = 1
var amountSpawned: int = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePosX = get_global_mouse_position().x
	global_position.x = clamp(mousePosX, 24, 420)
	#setBallType()

	
	if Input.is_action_just_pressed("spawn") and mousePosX < 420 and GameManager.score >= ballPrice[type]:
		GameManager.score -= ballPrice[type]
		var ballScene = balls[type].instantiate()
		ballScene.global_position.x = global_position.x 
		ballScene.maxAmountDropped += GameManager.bonusBounceBack
		amountSpawned += 1
		var popup = popupScene.instantiate()
		popup.text = "-" + str(int(ballPrice[type]))
		popup.global_position = global_position + Vector2(randf_range(-20,20), -20)
		get_tree().current_scene.add_child(popup)
		get_tree().get_root().add_child(ballScene)
		audio_stream_player_2d.pitch_scale = randf_range(1.4,1.6)
		audio_stream_player_2d.play()
		
	elif Input.is_action_just_pressed("spawn") and mousePosX < 420 and GameManager.score <= ballPrice[type]:
		var popup = popupScene.instantiate()
		popup.text = "You Broke"
		popup.global_position = get_global_mouse_position() + Vector2(randf_range(-20,20), -20)
		get_tree().current_scene.add_child(popup)



func setBallType() -> void:
	if Input.is_action_just_pressed("typeLeft"):
		type = wrapi(type - 1,0,balls.size())
	if Input.is_action_just_pressed("typeRight"):
		type = wrapi(type + 1,0,balls.size())
		
	
