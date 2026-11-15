extends Button

var time: float
var speed: float = 8
var targetScale: = Vector2(1,1)
var maxScale: = Vector2(1.25,1.25)
var minScale: = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * speed
	var t = (sin(time) + 1)/2
	if !disabled:
		targetScale = minScale
		scale = scale.lerp(targetScale, t)
		await get_tree().create_timer(0.4).timeout
		targetScale = maxScale
		scale = scale.lerp(targetScale, t)
	else:
		scale = Vector2(1,1)
