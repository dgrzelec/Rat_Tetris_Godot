extends Node2D

onready var blocks = [$LL, $L, $R, $RR]

func _ready():
	pass

func initiate(spawn_x, spawn_y):
	$LL.initiate(spawn_x, spawn_y+1)
	$L.initiate(spawn_x + 1, spawn_y + 1)
	$R.initiate(spawn_x + 2, spawn_y + 1)
	$RR.initiate(spawn_x + 3, spawn_y + 1)
	

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

var rotated = false
var rotation_vecs = [
				[-Vector2(1,-1), Vector2.ZERO,-Vector2(-1, 1),-Vector2(-2, 2)],
				[Vector2(1,-1), Vector2.ZERO,Vector2(-1, 1),Vector2(-2, 2)]]
				

func rotate(increment):
	rotated = !rotated
	var mod_vec = Vector2.ZERO
	if rotated:
		mod_vec = rotation_vecs[1]
	else:
		mod_vec = rotation_vecs[0]
		
	for i in 4:
		blocks[i].rotation_degrees += 90	
		blocks[i].position += mod_vec[i] * increment
		blocks[i].x += mod_vec[i].x
		blocks[i].y += mod_vec[i].y
	
func rotate_back(increment):
	rotated = !rotated
	var mod_vec = Vector2.ZERO
	if rotated:
		mod_vec = rotation_vecs[1]
	else:
		mod_vec = rotation_vecs[0]
		
	for i in 4:
		blocks[i].rotation_degrees -= 90	
		blocks[i].position += mod_vec[i] * increment
		blocks[i].x += mod_vec[i].x
		blocks[i].y += mod_vec[i].y
	
func get_blocks():
	return blocks.duplicate(true)

