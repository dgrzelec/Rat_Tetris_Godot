extends Node2D

onready var blocks = [$LU, $LB, $RB, $RU]

func _ready():
	pass

func initiate(spawn_x, spawn_y):
	$LU.initiate(spawn_x + 1, spawn_y)
	$RU.initiate(spawn_x + 2, spawn_y)
	$LB.initiate(spawn_x + 1, spawn_y + 1)
	$RB.initiate(spawn_x + 2, spawn_y + 1)
	
#
#func try_move_down():
#	for block in blocks:
#		if not block.try_move(block.x, block.y + 1):
#			return false
#	return true

func move_up(increment):
	for block in blocks:
		block.move_up(increment)
		
func move_down(increment):
	for block in blocks:
		block.move_down(increment)
#
#func try_move_left():
#	for block in blocks:
#		if not block.try_move(block.x -1, block.y):
#			return false
#	return true

func move_left(increment):
	for block in blocks:
		block.move_left(increment)
		
#func try_move_right():
#	for block in blocks:
#		if not block.try_move(block.x + 1, block.y):
#			return false
#	return true

func move_right(increment):
	for block in blocks:
		block.move_right(increment)
#
#func try_rotate():
#	return true
	
func rotate(_increment):
	for i in 4:
		blocks[i].rotation_degrees += 90
	
func rotate_back(_increment):
	for i in 4:
		blocks[i].rotation_degrees -= 90
		
func get_blocks():
	return blocks.duplicate(true)

