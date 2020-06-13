extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func reset_animation() -> void:
	$stripe1.reset_time_passed()
	$stripe2.reset_time_passed()
	$stripe3.reset_time_passed()
	$stripe4.reset_time_passed()

func set_time(time: float) -> void:
	$stripe1.set_time(time)
	$stripe2.set_time(time)
	$stripe3.set_time(time)
	$stripe4.set_time(time)

func reverse_animation(time: float) -> void:
	$stripe1.reverse_animation(time)
	$stripe2.reverse_animation(time)
	$stripe3.reverse_animation(time)
	$stripe4.reverse_animation(time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
