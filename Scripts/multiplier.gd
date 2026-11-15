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
	body.queue_free()
