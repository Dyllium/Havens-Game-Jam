extends Node2D

@onready var score_text: Label = $ScoreText
@export var multipliers: Array[multiplier]
@onready var ball_spawner: Node2D = $BallSpawner
@onready var refill: Button = $Refill

var ballInScene: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mult in multipliers:
		mult.scoreChanged.connect(_change_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Money: " + str(GameManager.score)
	if get_tree().get_first_node_in_group("balls") != null:
		ballInScene = true
	else:
		ballInScene = false
	if GameManager.score < 10 and ball_spawner.amountSpawned == ball_spawner.maxSpawn and !ballInScene:
		refill.disabled = false
	else:
		refill.disabled = true
	
	if GameManager.score >= 1000:
		print("u win")

func _change_score(amount: int) -> void:
	GameManager.score += amount


func _on__bounce_back_pressed() -> void:
	if GameManager.score >= 100:
		GameManager.bonusBounceBack += 1
		GameManager.score -= 100


func _on__ball_pressed() -> void:
	if GameManager.score >= 10:
		ball_spawner.maxSpawn += 1
		GameManager.score -= 10


func _on_refill_pressed() -> void:
	refill.disabled = true
	ball_spawner.amountSpawned = 0


func _on__ball_value_pressed() -> void:
	if GameManager.score >= 30:
		GameManager.bonusValue += 1
		GameManager.score -= 30
