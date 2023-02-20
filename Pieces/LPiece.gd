extends Node2D

onready var blocks = [$U, $L, $R, $B]

func _ready():
	pass

func initiate(spawn_x, spawn_y):
	$U.initiate(spawn_x, spawn_y)
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

func rotate(_increment):
	pass
	
func rotate_back(_increment):
	pass
	
func get_blocks():
	return blocks.duplicate(true)

