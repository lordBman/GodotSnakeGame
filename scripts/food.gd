class_name Food extends Node2D

var current_position := Vector2()
@onready var snake = %snake as Snake
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var is_on_occupied_position = snake.intersects(Rect2(current_position, Vector2(Game.CELL_SIZE, Game.CELL_SIZE)))
	if(is_on_occupied_position):
		snake.grow()
		spawn()
	queue_redraw()

func _draw():
	draw_rect(Rect2(current_position, Vector2(Game.CELL_SIZE, Game.CELL_SIZE)), Colors.BLUE)
	
func spawn():
	var is_on_occupied_position = true
	
	while is_on_occupied_position:
		var random_position = Vector2()
		random_position.x = randi_range(0, Game.CELL_AMOUNT.x - 1) 
		random_position.y = randi_range(0, Game.CELL_AMOUNT.y - 1)
		
		current_position = random_position * Game.CELL_SIZE
		is_on_occupied_position = snake.intersects(Rect2(current_position, Vector2(Game.CELL_SIZE, Game.CELL_SIZE)))
	
