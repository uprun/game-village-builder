extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var global_variables: Node
onready var scene_road_block = preload("res://road-block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_variables = get_node("/root/Script_global_variables")
	
func snapToGridIndex4(pos: float) -> float:
	var base = 4
	pos =  sign(pos) * (int(round(abs(pos)/ base) ))
	return pos

func snapToGridPosition4(pos: float) -> float:
	var base = 4
	pos =  sign(pos) * (int(round(abs(pos)/ base) ) * base)
	return pos
	
func checkNeighborRoad(a: int, b: int) -> bool:
	var result = global_variables.dictionary_road.has(Vector2(a,b))
	return result

func checkIfThereIsARoadToAttachTo(a: int, b: int) -> bool:
	var x1 = checkNeighborRoad( a - 1, b)
	var x2 = checkNeighborRoad( a + 1, b)
	var z1 = checkNeighborRoad( a, b - 1)
	var z2 = checkNeighborRoad( a, b + 1)
	var isOnZ = z1 or z2
	var isOnX = x1 or x2
	return (isOnX and (isOnZ == false)) or ((isOnX == false) and isOnZ)
	
func removeRoadBlock(ix: int, iz: int) -> void:
	var child_nodes = get_children()
	for nodeMaybeRoad in child_nodes:
		if nodeMaybeRoad.name.begins_with("road-block"):
			var check_ix = snapToGridIndex4(nodeMaybeRoad.translation.x)
			var check_iz = snapToGridIndex4(nodeMaybeRoad.translation.z)
			if check_ix == ix and check_iz == iz:
				nodeMaybeRoad.queue_free()
				global_variables.dictionary_road.erase(Vector2(ix,iz))
				$"road-remove".hide()
	

func getMouseClick3d(data: InputEventMouse) -> Dictionary:
	var ray_length = 1000
	var camera = $Camera
	var from = camera.project_ray_origin(data.position)
	var to = from + camera.project_ray_normal(data.position) * ray_length
	
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to, [self], 0x1)
	return result

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_node("/root/Script_global_variables").dictionary_road.clear()
			get_tree().reload_current_scene()
	
	if event is InputEventMouseButton:
		
		
		var data = (event as InputEventMouseButton)
		if data.doubleclick and data.button_index == 1:
			var clickResult = getMouseClick3d(data)
			if clickResult:
				var ix = snapToGridIndex4(clickResult.position.x)
				var iz = snapToGridIndex4(clickResult.position.z)
				if checkNeighborRoad(ix, iz):
					removeRoadBlock(ix, iz)
				else:
					if checkIfThereIsARoadToAttachTo(ix, iz):
						var x = clickResult.position.x
						var z = clickResult.position.z
						x =  snapToGridPosition4(x)
						z =  snapToGridPosition4(z)
						var snappedPosition = Vector3(x, 0, z)
						var road_block_instance = scene_road_block.instance()
						road_block_instance.translation =  snappedPosition
						get_node("/root/game").add_child(road_block_instance, true)
						
						$"road-add".hide()
			pass
		if data.pressed and data.button_index == 4:
			pass
	if event is InputEventMouseMotion:
		$"road-remove".hide()
		$"road-add".hide()
		var data = (event as InputEventMouseMotion)
		var clickResult = getMouseClick3d(data)
		if clickResult:
			var ix = snapToGridIndex4(clickResult.position.x)
			var iz = snapToGridIndex4(clickResult.position.z)
			var x = clickResult.position.x
			var z = clickResult.position.z
			x =  snapToGridPosition4(x)
			z =  snapToGridPosition4(z)
			var snappedPosition = Vector3(x, 0, z)
			if checkNeighborRoad(ix, iz):
				$"road-remove".translation = snappedPosition
				$"road-remove".show()
			else:
				if checkIfThereIsARoadToAttachTo(ix, iz):
					$"road-add".translation = snappedPosition
					$"road-add".show()
				
		if event.button_mask == 1:
			pass
		if event.button_mask == 2:
			pass
