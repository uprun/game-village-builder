extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func reset_animation() -> void:
	$stripe1.reset_time_passed()
	$stripe2.reset_time_passed()
	$stripe3.reset_time_passed()
	$stripe4.reset_time_passed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
