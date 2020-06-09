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

func snapToGrid(pos: float) -> float:
	var base = 4
	pos =  sign(pos) * (int(round(abs(pos)/ base) ))
	return pos
	
func checkNeighborRoad(a: int, b: int) -> bool:
	var result = global_variables.dictionary_road.has(Vector2(a,b))
	return result

func triggerBuildingOfNeighborRoad(a: int, b: int) -> void:
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
			global_variables.dictionary_road[key] = true
	if should_check_dictionary_of_roads and global_variables.dictionary_road[key]:
		should_check_dictionary_of_roads = false
		$road.show()
		begin_build_time = time_passed
	if not should_check_dictionary_of_roads:
		var time_delta = time_passed - begin_build_time
		if time_delta > 0.5:
			triggerBuildingOfNeighborRoad(x - 1, z)
			triggerBuildingOfNeighborRoad(x + 1, z)
			triggerBuildingOfNeighborRoad(x, z - 1)
			triggerBuildingOfNeighborRoad(x, z + 1)
