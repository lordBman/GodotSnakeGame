extends Node2D

var head := MiniSnake.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	head.color = Colors.BLUE_DARK
	head.size = Vector2(Game.CELL_SIZE, Game.CELL_SIZE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
func  _draw():
	draw_rect(head.get_rect(), head.color)
