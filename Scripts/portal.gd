class_name portal extends Area2D

@export var startPos: Vector2
@export var endPos: Vector2
@export var linkedPortal: portal
@export var speed: float = 2

var time: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = startPos
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * speed
	var t = (sin(time) + 1)/2
	
	global_position = startPos.lerp(endPos, t)

func _on_body_entered(body: Node2D) -> void:
	print("body tp")
	if body.canTeleport:
		print("can tp")
		body.canTeleport = false
		var target_position = Transform2D(body.global_rotation, linkedPortal.global_position)
		PhysicsServer2D.body_set_state(body.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM, target_position)
		await get_tree().create_timer(0.4).timeout
		if is_instance_valid(body):
			body.canTeleport = true
