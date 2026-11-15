extends Node2D

@export var balls: Array[PackedScene]
var type: int = 0
var maxSpawn: int = 1
var amountSpawned: int = 0


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
	
	if Input.is_action_just_pressed("spawn") and amountSpawned < maxSpawn:
		amountSpawned += 1
		get_tree().get_root().add_child(ballScene)
			

func setBallType() -> void:
	if Input.is_action_just_pressed("typeLeft"):
		type = wrapi(type - 1,0,balls.size())
	if Input.is_action_just_pressed("typeRight"):
		type = wrapi(type + 1,0,balls.size())
		
	
