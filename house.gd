extends KinematicBody


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var velocity = Vector3.ZERO
var jumpCountLeft = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	velocity.y -= 9.8 * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	velocity.x = 0
	velocity.z = 0
	if is_on_floor():
		if jumpCountLeft > 0:
			jumpCountLeft -= 1
			velocity.y = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
