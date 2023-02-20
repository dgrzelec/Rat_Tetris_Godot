extends Sprite

var x 
var y

#var y_up = 0
#var y_bottom = 21
#
#var x_left = 0
#var x_right = 9

func _ready():
	pass

func initiate(xi, yi):
	x = xi
	y = yi
	

#func try_move(new_x, new_y):
#	if x_left < new_x < x_right:
#		return false
#	if y_bottom < new_x < y_up:
#		return false
#	return true
#
#func move(new_x, new_y):
#	x = new_x
#	y = new_y
	
func move_up(increment):
	position.y -= increment
	y -= 1
	
func move_down(increment):
	position.y += increment
	y += 1
	
func move_left(increment):
	position.x -= increment
	x -= 1

func move_right(increment):
	position.x += increment
	x += 1

func delete():
	queue_free()
