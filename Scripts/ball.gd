class_name ball extends RigidBody2D

@export var value: int
@export var cost: int

var stuckTime: float = 0
var stuckTimeLimit: float = 2
var stuckThreshold: float = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.length() < stuckThreshold:
		stuckTime += delta
	if stuckTime > stuckTimeLimit:
		unstick_ball()
		
func unstick_ball():
	var randomDir = Vector2(randf_range(-120, 120), randf_range(80, 200))
	apply_central_impulse(randomDir)
	stuckTime = 0
