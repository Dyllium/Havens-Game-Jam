class_name ball extends RigidBody2D

@export var value: int
@export var visibleOnScreenNotifier: VisibleOnScreenNotifier2D

var stuckTime: float = 0
var stuckTimeLimit: float = 1
var stuckThreshold: float = 15
var amountDropped: int = 1
@export var maxAmountDropped: int = 3
var extraMultiply: int = 1
var canTeleport: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value += GameManager.bonusValue
	visibleOnScreenNotifier.screen_exited.connect(on_exit_screen)
	amountDropped = 1
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
