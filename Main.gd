extends Node

export var cell_size = 32 #px

var game_running = false
var score = 0

var y_up = 0
var y_bottom = 21

var x_left = 0
var x_right = 9

var blocks_dic = Dictionary() 
var current_piece
var piece_saved = false
var pieces = [preload("res://Pieces/SquarePiece.tscn"), preload("res://Pieces/LPiece.tscn"),\
			preload("res://Pieces/LinePiece.tscn"), preload("res://Pieces/ReverseLPiece.tscn"),\
			preload("res://Pieces/ReverseSquiglyPiece.tscn"), preload("res://Pieces/SquiglyPiece.tscn"),\
			preload("res://Pieces/TPiece.tscn")]

var piece_queue = 1
var rand_piece_array = []

func _ready():
	randomize()
	print($GameArea.position)
	
func _process(delta):
	if current_piece:
		var direction = 0
		if Input.is_action_just_pressed("move_left"):
			direction -= 1
		if Input.is_action_just_pressed("move_right"):
			direction += 1
		if direction == -1:
			test_and_move_left()

		elif direction == 1:
			test_and_move_right()

		if Input.is_action_just_pressed("rotate"):
			current_piece.rotate(cell_size)
			
		if Input.is_action_just_pressed("place"):
			while not piece_saved:
				piece_saved = test_and_move_down()
			piece_saved = false
	else:
		if game_running:
			spawn_random_piece()
			
func start_game():
	for i in piece_queue:
		var rand_index = rand_range(0, len(pieces))
		rand_piece_array.push_back(pieces[rand_index])
	spawn_random_piece()
	game_running = true

func end_game():
	game_running = false
	$PieceTimer.stop()
	print("game over, your score: %s"%score)
	

func spawn_random_piece():
	spawn_piece(rand_piece_array.pop_front())
	var rand_index = rand_range(0, len(pieces))
	rand_piece_array.push_back(pieces[rand_index])
	
func spawn_piece(piece: PackedScene):
	var new_piece = piece.instance()
	add_child(new_piece)
	new_piece.position = $SpawnPoint.position
	new_piece.initiate(3, 0)
	current_piece = new_piece
	
	$PieceTimer.start()
	piece_saved = false

func test_and_move_left():
	current_piece.move_left(cell_size)
	var undo_move = false
	for block in current_piece.blocks:
		if x_left > block.x:
			undo_move = true
		elif blocks_dic.has(Vector2(block.x, block.y)):
			undo_move = true
	if undo_move:
			current_piece.move_right(cell_size)

func test_and_move_right():
	current_piece.move_right(cell_size)
	var undo_move = false
	for block in current_piece.blocks:
		if x_right < block.x:
			undo_move = true
		elif blocks_dic.has(Vector2(block.x, block.y)):
			undo_move = true
	if undo_move:
			current_piece.move_left(cell_size)

func test_and_move_down():
	#first move down then check and move up if necessary
	current_piece.move_down(cell_size)
	var block_to_save = false
	
	for block in current_piece.blocks:
		if y_bottom < block.y:
			block_to_save = true
		elif blocks_dic.has(Vector2(block.x, block.y)):
			block_to_save = true

	if block_to_save:
		current_piece.move_up(cell_size)
		save_piece(current_piece)
#		spawn_random_piece()
		$PieceTimer.stop()
		current_piece = null
	return block_to_save
	
func save_piece(piece):
	for block in piece.blocks:
		var key = Vector2(block.x, block.y)
		blocks_dic[key] = block.duplicate()
		$SpawnPoint.add_child(blocks_dic[key])
		blocks_dic[key].initiate(block.x, block.y)
		
	piece.queue_free()
	test_for_score()
	#after scoring if any block is in the top line game ends
	for x in x_right + 1:
		if blocks_dic.has(Vector2(x, 0)):
			end_game()
			return
	
func test_for_score():
	#dict to store block counts in every line
	var count_blocks = {}
	for i in y_bottom+1:
		count_blocks[i] = 0
	
	for key in blocks_dic.keys():
		count_blocks[int(key.y)] += 1
	print(count_blocks)

	for y in y_bottom+1:
		if count_blocks[y] == 10:
			score+=10 #hard coded
			erase_line(y)
			
	$UI.update_score(score)
	
	
func erase_line(line_y):
	for key in blocks_dic.keys():
		if key.y == line_y:
			blocks_dic[key].delete()
			blocks_dic.erase(key)
#	for key in blocks_dic.keys():
#		if key.y < line_y:
	#needs to be in reverse order from erased line
	for y_temp in range(0, line_y):
		var y = line_y - y_temp - 1
		for x in x_right+1:
			var lowered_key = Vector2(x, y + 1) 
			var key = Vector2(x, y) 
			if blocks_dic.has(key):
				blocks_dic[lowered_key] = blocks_dic[key].duplicate()
				$SpawnPoint.add_child(blocks_dic[lowered_key])
				blocks_dic[lowered_key].initiate(key.x, key.y)
				blocks_dic[lowered_key].move_down(cell_size)
				blocks_dic[key].delete()
				blocks_dic.erase(key)

func _on_Walls_body_entered(body):
	pass # Replace with function body.


func _on_Floor_body_entered(body):
	pass # Replace with function body.


