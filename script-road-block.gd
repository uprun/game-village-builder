extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var x: int
var z: int
var global_variables: Node
var key: Vector2

var should_check_dictionary_of_roads = true

var first_frame = true

var time_passed = 0.0
var neighbors_count = 0
var begin_build_time = 0.0

var eligable_for_stripes = false

func snapToGrid(pos: float) -> float:
	var base = 4
	pos =  sign(pos) * (int(round(abs(pos)/ base) ))
	return pos
	
func checkNeighborRoad(a: int, b: int) -> bool:
	var result = global_variables.dictionary_road.has(Vector2(a,b))
	return result

func triggerBuildingOfNeighborRoad(a: int, b: int) -> void:
	if checkNeighborRoad(a,b):
		global_variables.dictionary_road[Vector2(a,b)] = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_variables = get_node("/root/Script_global_variables")
	x = snapToGrid(translation.x)
	z = snapToGrid(translation.z)
	key = Vector2(x,z)
	global_variables.dictionary_road[key] = false
	$road.hide()
	$buffer.hide()
	$stripes_group.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	if(first_frame):
		first_frame = false
		if checkNeighborRoad(x - 1, z ):
			neighbors_count += 1
		if checkNeighborRoad(x + 1, z ):
			neighbors_count += 1
		if checkNeighborRoad(x, z - 1):
			neighbors_count += 1
		if checkNeighborRoad(x, z + 1 ):
			neighbors_count += 1
		if neighbors_count <= 1:
			#end or begin of road
			global_variables.dictionary_road[key] = true
		
		
		var check_x = checkNeighborRoad(x - 1, z ) or checkNeighborRoad(x + 1, z )
		var check_z = checkNeighborRoad(x, z - 1) or checkNeighborRoad(x, z + 1 )
		if  check_x and check_z:
			#junction
			global_variables.dictionary_road[key] = true
		else:
			#road
			eligable_for_stripes = true
			if check_z:
				#rotate to properly orient
				rotate_y(deg2rad(90))
			
	if should_check_dictionary_of_roads and global_variables.dictionary_road[key]:
		should_check_dictionary_of_roads = false
		$"road-block-from-blocks".show()
		$"road-block-from-blocks".reset_animation()
		if eligable_for_stripes:
			$stripes_group.show()
			$stripes_group.reset_animation()
		begin_build_time = time_passed
	if not should_check_dictionary_of_roads:
		var time_delta = time_passed - begin_build_time
		if time_delta > 3:
			triggerBuildingOfNeighborRoad(x - 1, z)
			triggerBuildingOfNeighborRoad(x + 1, z)
			triggerBuildingOfNeighborRoad(x, z - 1)
			triggerBuildingOfNeighborRoad(x, z + 1)
