extends Node2D
@onready var score_text: Label = $UI/ScoreText
@export var multipliers: Array[multiplier]
@onready var ball_spawner: Node2D = $BallSpawner
@onready var pegs: Node2D = $Pegs
@onready var plain_ball: Button = $"UI/HBoxContainer/Plain Ball"
@onready var heavy_ball: Button = $"UI/HBoxContainer/Heavy Ball"
@onready var refill: Button = $UI/Refill
@onready var pay_debt: Button = $"UI/Pay Debt"
@onready var __1_golden_peg: Button = $"UI/Upgrade Buttons/+1 Golden Peg"
@onready var __1_ball_value: Button = $"UI/Upgrade Buttons/+1 Ball Value"
@onready var __1_bounce_back: Button = $"UI/Upgrade Buttons/+1 Bounce Back"
@onready var seleced_ball: TextureRect = $"UI/Seleced Ball"

@export var textureArray: Array[Texture2D]
@export var button_sounds: AudioStreamPlayer2D
@export var refill_sound: AudioStreamPlayer2D

var ballInScene: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plain_ball.button_pressed = true
	for mult in multipliers:
		mult.scoreChanged.connect(_change_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Money: " + str(GameManager.score)
	if get_tree().get_first_node_in_group("balls") != null:
		ballInScene = true
	else:
		ballInScene = false
	if GameManager.score < 10  and !ballInScene:
		refill.disabled = false
	else:
		refill.disabled = true
	if GameManager.score >= 500:
		pay_debt.disabled = false
	else:
		pay_debt.disabled = true
	
	if GameManager.score >= 20:
		__1_golden_peg.disabled = false
	else:
		__1_golden_peg.disabled = true
	if GameManager.score >= 30:
		__1_ball_value.disabled = false
	else:
		__1_ball_value.disabled = true
	if GameManager.score >= 50:
		__1_bounce_back.disabled = false
	else:
		__1_bounce_back.disabled = true


func _change_score(amount: int) -> void:
	GameManager.score += amount


func _on__bounce_back_pressed() -> void:
	if GameManager.score >= 50:
		GameManager.bonusBounceBack += 1
		GameManager.score -= 50
		play_button_sound()


func _on__ball_pressed() -> void:
	if heavy_ball.button_pressed == false:
		plain_ball.button_pressed = true
	heavy_ball.button_pressed = false
	seleced_ball.texture = textureArray[0]
	ball_spawner.type = 0


func _on_refill_pressed() -> void:
	refill.disabled = true
	GameManager.score = 10
	refill_sound.pitch_scale = randf_range(0.9, 1.1)
	refill_sound.play()


func _on__ball_value_pressed() -> void:
	if GameManager.score >= 30:
		GameManager.bonusValue += 1
		GameManager.score -= 30
		play_button_sound()


func _on__golden_peg_pressed() -> void:
	if GameManager.score >= 20:
		pegs.randomPeg()
		GameManager.score -= 20
		play_button_sound()


func _on_pay_debt_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


func _on_heavy_ball_pressed() -> void:
	if plain_ball.button_pressed == false:
		heavy_ball.button_pressed = true
	plain_ball.button_pressed = false
	seleced_ball.texture = textureArray[1]
	ball_spawner.type = 1
func play_button_sound():
	button_sounds.pitch_scale = randf_range(0.9, 1.1)
	button_sounds.play()
