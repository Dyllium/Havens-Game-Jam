class_name multiplier extends Area2D

@export var multiplierAmount: float
const popupScene = preload("res://Scenes/popup_text.tscn")


signal scoreChanged(amount: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(on_body_entered)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_body_entered(body: RigidBody2D) -> void:
	var amount: int = ceili(body.value * multiplierAmount * body.extraMultiply)
	scoreChanged.emit(amount)
	
	var popup = popupScene.instantiate()
	popup.text = "+" + str(int(body.value * multiplierAmount)) + " (x" + str(body.amountDropped) + ")"
	popup.global_position = body.global_position + Vector2(randf_range(-20,20), -20)
	get_tree().current_scene.add_child(popup)
	
	if multiplierAmount == 0:
		body.queue_free()
		
	if body.amountDropped < body.maxAmountDropped:
		body.amountDropped +=1
		body.global_position.y = 0
		body.global_position.x = randf_range(20, 420)
		body.linear_velocity = Vector2.ZERO
		body.apply_central_impulse(Vector2(randf_range(-15,15), 0))
	else:
		body.queue_free()
