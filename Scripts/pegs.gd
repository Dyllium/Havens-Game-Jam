extends Node2D

@export var pegTypes: Array[PackedScene]

var pegs: Array[Node]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pegs = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func randomPeg() -> void:
	var randomPeg = pegs.pick_random()
	var newPeg = pegTypes.pick_random().instantiate()
	newPeg.global_position = randomPeg.global_position
	add_child(newPeg)
	pegs.erase(randomPeg)
	randomPeg.queue_free()
	
