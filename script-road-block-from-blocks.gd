extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func reset_animation() -> void:
	$"road-tile".reset_time_passed()
	$"road-tile2".reset_time_passed()
	$"road-tile3".reset_time_passed()
	$"road-tile4".reset_time_passed()
	$"road-tile5".reset_time_passed()
	$"road-tile6".reset_time_passed()
	$"road-tile7".reset_time_passed()
	$"road-tile8".reset_time_passed()
	$"road-tile9".reset_time_passed()
	$"road-tile10".reset_time_passed()
	$"road-tile11".reset_time_passed()
	$"road-tile12".reset_time_passed()
	$"road-tile13".reset_time_passed()
	$"road-tile14".reset_time_passed()
	$"road-tile15".reset_time_passed()
	$"road-tile16".reset_time_passed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
