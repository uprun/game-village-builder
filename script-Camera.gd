extends Camera

var target = Vector3.ZERO
var rotated_up = Vector3(0,0, -1)
var some = Vector3(0,0,1)
var length = 4.0
var around_y_rotation_degress = 0.0
var degrees_from_plane = -80.0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func _init() -> void:
	look_at(target, rotated_up)

func update_position() -> void:
	var rot_x = (some *length ).rotated(Vector3(1, 0, 0), deg2rad(degrees_from_plane))
	var rot_y = rot_x.rotated(Vector3(0,1,0), deg2rad(around_y_rotation_degress))
	var estimated_pos = target + rot_y
	translation = estimated_pos
	rotated_up = Vector3.UP.rotated(Vector3(1, 0, 0), deg2rad(degrees_from_plane)).rotated(Vector3(0,1,0), deg2rad(around_y_rotation_degress))
	look_at(target, rotated_up)

func _process(delta: float) -> void:
	update_position()

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		
		
		var data = (event as InputEventMouseButton)
		print(data.to_string())
		if data.pressed and data.button_index == 1:
			pass
	if event is InputEventMouseMotion:
		var data = (event as InputEventMouseMotion)
		print(event.relative, event.button_mask)
		if event.button_mask == 1:
			event.relative /= 100.0
			var shift = Vector3(event.relative.x, 0, event.relative.y)
			shift = shift.rotated(Vector3(0,1,0), deg2rad(around_y_rotation_degress))
			target -= shift
		if event.button_mask == 2:
			event.relative /= 10.0
			degrees_from_plane -= event.relative.y
			degrees_from_plane = max(-80, degrees_from_plane)
			degrees_from_plane = min(-10, degrees_from_plane)
			around_y_rotation_degress -= event.relative.x
