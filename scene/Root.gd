extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var BALL_THRESHOLD_Y = -20

var started = false
var score = 0
var best_score = 0

var message_label
var ball_rigid_body
var score_label
var best_score_label

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			started = true
			ball_rigid_body.sleeping = false
			message_label.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	message_label = get_node("MessageLabel")
	ball_rigid_body = get_node("BallRigidBody")
	score_label = get_node("ScoreLabel")
	best_score_label = get_node("BestScoreLabel")
	load_best_score()
	display_score()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !started:
		return
	score += delta
	if best_score < score:
		best_score = score
	display_score()
	if ball_rigid_body.get_global_transform().origin.y < BALL_THRESHOLD_Y:
		started = false
		save_best_score()
		get_tree().reload_current_scene()
		
func display_score():
	score_label.text = "Score: %.2f" % score
	best_score_label.text = "Best Score: %.2f" % best_score

func load_best_score():
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.save"):
		return
	save_file.open("user://savefile.save", File.READ)
	best_score = float(save_file.get_line())
	save_file.close()

func save_best_score():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	save_file.store_line("%.2f" % best_score)
	save_file.close()
