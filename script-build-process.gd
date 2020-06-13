extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var initial_translation: Vector3
export var start_from_translation: Vector3

export var progress_per_second = 100.0
export var show_and_animate_after_seconds = 0.0

var progress = 0
var time_passed = 0
var direction_of_animation = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_translation = translation
	visible = false
	start_from_translation = initial_translation + start_from_translation

func reset_time_passed() -> void:
	time_passed = 0
	visible = false
	start_from_translation = initial_translation + start_from_translation
	progress = 0
	direction_of_animation = 1.0
	progress_per_second = abs(progress_per_second)

func set_time(time: float) -> void:
	time_passed = time

func reverse_animation(time: float) -> void:
	time_passed = time
	progress = 100
	progress_per_second = - abs(progress_per_second)
	direction_of_animation = -1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(time_passed >= show_and_animate_after_seconds):
		visible = true
		translation = (initial_translation - start_from_translation) * progress / 100 + start_from_translation
		progress += progress_per_second * delta
		progress = min(100, progress)
	else:
		visible = false
	
	time_passed += direction_of_animation * delta

