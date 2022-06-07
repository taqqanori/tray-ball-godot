extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var RANDOM_ROTATION_RATIO = 50
var ROTATE_RATIO = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rotateXZ(randomRotation(), randomRotation())
	
func randomRotation():
	return RANDOM_ROTATION_RATIO * (randf() - 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotateXZ(
		Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

func rotateXZ(x, z):
	rotate(Vector3(0, 0, 1), ROTATE_RATIO * x)
	rotate(Vector3(1, 0, 0), ROTATE_RATIO * z)
