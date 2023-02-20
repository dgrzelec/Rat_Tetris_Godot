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

func rotate(_increment):
	pass
	
func rotate_back(_increment):
	pass
	
func get_blocks():
	return blocks.duplicate(true)

