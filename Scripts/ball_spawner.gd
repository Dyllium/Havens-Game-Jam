extends Node2D

@export var balls: Array[PackedScene]
var type: int = 0
var cost: int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePosX = get_global_mouse_position().x
	global_position.x = clamp(mousePosX, 24, 420)
	setBallType()
	var ballScene = balls[type].instantiate()
	ballScene.global_position.x = global_position.x 
	
	if Input.is_action_just_pressed("spawn"):
		if GameManager.score - ballScene.cost >= 0:
			GameManager.score -= ballScene.cost
			get_tree().get_root().add_child(ballScene)
			

func setBallType() -> void:
	if Input.is_action_just_pressed("typeLeft"):
		type = wrapi(type - 1,0,balls.size())
	if Input.is_action_just_pressed("typeRight"):
		type = wrapi(type + 1,0,balls.size())
		
	
