class_name ball extends RigidBody2D

@export var value: int
@export var visibleOnScreenNotifier: VisibleOnScreenNotifier2D
@export var maxAmountDropped: int = 3
@export var randomColor: bool = true
const HAVEN_BALL_COLLIDING = preload("uid://cid0u480e0xiv")
@export var audio_stream_player_2d: AudioStreamPlayer2D

const popupScene = preload("res://Scenes/popup_text.tscn")

var stuckTime: float = 0
var stuckTimeLimit: float = 1
var stuckThreshold: float = 15
var amountDropped: int = 1
var extraMultiply: int = 1
var canTeleport: bool = true



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	audio_stream_player_2d.stream = HAVEN_BALL_COLLIDING
	audio_stream_player_2d.volume_db = -0.5
	max_contacts_reported = 50
	self.body_entered.connect(_on_body_entered)
	value += GameManager.bonusValue
	visibleOnScreenNotifier.screen_exited.connect(on_exit_screen)
	amountDropped = 1
	if randomColor:
		modulate = Color.from_rgba8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255), 255)
	apply_central_impulse(Vector2(randf_range(-50,50), 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.length() < stuckThreshold:
		stuckTime += delta
	else:
		stuckTime = 0
	if stuckTime > stuckTimeLimit:
		unstick_ball()
	
	extraMultiply = amountDropped
func unstick_ball():
	global_position.y = 20
	global_position.x = 225
	apply_central_impulse(Vector2(randf_range(-15,15), 0))
	stuckTime = 0

func on_exit_screen() -> void:
	queue_free()

func _on_body_entered(body: Node):
	audio_stream_player_2d.pitch_scale = randf_range(1.4,1.6)
	audio_stream_player_2d.play()
	if body is peg:
		if body.value > 0:
			value += body.value
			var popup = popupScene.instantiate()
			popup.text = "+" + str(int(body.value))
			popup.global_position = body.global_position + Vector2(randf_range(-20,20), -20)
			get_tree().current_scene.add_child(popup)
