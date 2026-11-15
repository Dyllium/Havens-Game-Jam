class_name multiplier extends Area2D

@export var multiplierAmount: float


signal scoreChanged(amount: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(on_body_entered)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_body_entered(body: RigidBody2D) -> void:
	var amount: int = ceili(body.value * multiplierAmount)
	scoreChanged.emit(amount)
	if body.amountDropped < body.maxAmountDropped:
		body.amountDropped +=1
		body.global_position.y = 0
		body.linear_velocity = Vector2.ZERO
		body.apply_central_impulse(Vector2(randf_range(-15,15), 0))
	else:
		queue_free()
	if multiplierAmount == 0:
		body.queue_free()
