extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

#export(NodePath) var pathToCamera

onready var BULLET = preload("res://house.tscn")

func snapToGrid(pos: float) -> float:
	var base = 8
	pos =  sign(pos) * (int(round(abs(pos)/ base) ) * base )
	return pos

func getMouseClick3d(data: InputEventMouse) -> Dictionary:
	var ray_length = 1000
	var camera = $Camera
	var from = camera.project_ray_origin(data.position)
	var to = from + camera.project_ray_normal(data.position) * ray_length
	
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to, [self], 0x1)
	return result
	
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		var data = (event as InputEventMouseButton)
		if data.pressed and data.button_index == 1:
			var result = getMouseClick3d(data)
			if result:
				var bullet = BULLET.instance()
				get_node("/root/game").add_child(bullet)
				var x = result.position.x
				var z = result.position.z
				x =  snapToGrid(x)
				z =  snapToGrid(z)
				var snappedHousePosition = Vector3(x, result.position.y, z)
				bullet.transform.origin =  snappedHousePosition
		pass
	if event is InputEventMouseMotion:
		var data = (event as InputEventMouseMotion)
		var result = getMouseClick3d(data)
		if result:
			$house.translation = result.position
			var x = result.position.x
			var z = result.position.z
			x =  snapToGrid(x)
			z =  snapToGrid(z)
			var snappedHousePosition = Vector3(x, result.position.y, z)
			print(result.position, 'snappped', snappedHousePosition)
			$house2.translation = snappedHousePosition
			pass
#			var bullet = BULLET.instance()
#			get_node("/root/game").add_child(bullet)
#			bullet.transform.origin =  result.position
		else:
			print('no hit')
		
		if true:
			pass
	if event is InputEventKey and event.pressed:
#		if Input.is_key_pressed(KEY_ESCAPE):
#			var shared_vars = get_node("/root/SharedVariables")
#			if shared_vars.isMenuOpen:
#				$"Button-re-start".hide()
#				$camera_horizontal/camera_vertical/Camera.current = true
#				shared_vars.isMenuOpen = false
#			else:
#				$"Button-re-start".show()
#				$CameraStart.current = true
#				shared_vars.isMenuOpen = true
#		#print(event.scancode,'-', event.unicode)
		pass


		
	
