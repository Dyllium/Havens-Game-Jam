extends Node2D

@onready var score_text: Label = $ScoreText
@export var multipliers: Array[multiplier]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mult in multipliers:
		mult.scoreChanged.connect(_change_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Money: " + str(GameManager.score)

func _change_score(amount: int) -> void:
	GameManager.score += amount
