extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready()->void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)->void:
	pass

func _draw()->void:
	# draw background
	draw_rect(Rect2(0, 0, Game.GRID_SIZE.x, Game.GRID_SIZE.y), Colors.WHITE)
	
	# draw vertical lines
	for i in Game.CELL_AMOUNT.x:
		var from := Vector2(i * Game.CELL_SIZE, 0)
		var to := Vector2(i * Game.CELL_SIZE, Game.GRID_SIZE.y)
		draw_line(from, to, Colors.GRAY)
		
	for i in Game.CELL_AMOUNT.y:
		var from := Vector2(0, Game.CELL_SIZE * i)
		var to := Vector2(Game.GRID_SIZE.x, Game.CELL_SIZE * i)
		draw_line(from, to, Colors.GRAY)
	
