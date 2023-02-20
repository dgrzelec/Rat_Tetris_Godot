extends Node2D

onready var blocks = [$U, $L, $B, $R]

func _ready():
	pass

func initiate(spawn_x, spawn_y):
	$U.initiate(spawn_x + 2, spawn_y)
	$L.initiate(spawn_x, spawn_y + 1)
	$B.initiate(spawn_x + 1, spawn_y + 1)
	$R.initiate(spawn_x + 2, spawn_y + 1)
	

func move_up(increment):
	for block in blocks:
		block.move_up(increment)
		
func move_down(increment):
	for block in blocks:
		block.move_down(increment)

func move_left(increment):
	for block in blocks:
		block.move_left(increment)
		
func move_right(increment):
	for block in blocks:
		block.move_right(increment)


var rotation_id = 0
var rotation_vecs = [
				[Vector2(2,0), Vector2(-1,-1),Vector2.ZERO,Vector2(1,1)],
				[Vector2(0,2), Vector2(1,-1),Vector2.ZERO,Vector2(-1,1)],
				[Vector2(-2,0), Vector2(1,1), Vector2.ZERO, Vector2(-1,-1)],
				[Vector2(0,-2), Vector2(-1,1), Vector2.ZERO, Vector2(1,-1)]]


func rotate(increment):
	rotation_id += 1
	if rotation_id > 3:
		rotation_id = 0
	#apply rotation
	for i in 4:
		var mod_vec = rotation_vecs[rotation_id][i]
		blocks[i].rotation_degrees = 90 * rotation_id	
		blocks[i].position += mod_vec * increment
		blocks[i].x += mod_vec.x
		blocks[i].y += mod_vec.y
		

func rotate_back(increment):
	for i in 3:
		rotate(increment)
	
func get_blocks():
	return blocks.duplicate(true)

