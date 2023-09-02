class_name Snake extends Node2D

var current_direction := Vector2.RIGHT;
var next_direction := Vector2.RIGHT;

var parts := []

var tween_move: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	var head = Part.new()
	head.color = Colors.BLUE_DARK
	
	parts.push_front(head)
	
	tween_move = create_tween().set_loops()
	tween_move.tween_callback(move).set_delay(0.074)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func  _draw():
	for part in parts:
		draw_rect(part.get_rect(), part.color)
	
func _input(event):
	if event.is_action_pressed("move_down") and current_direction != Vector2.UP:
		next_direction = Vector2.DOWN
	elif event.is_action_pressed("move_left") and current_direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	elif event.is_action_pressed("move_up") and current_direction != Vector2.DOWN:
		next_direction = Vector2.UP
	elif event.is_action_pressed("move_right") and current_direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT
		
func move():
	current_direction = next_direction
	var init = Vector2(parts.front().current_position + (current_direction * Game.CELL_SIZE))
	
	init.x = fposmod(init.x, Game.GRID_SIZE.x)
	init.y = fposmod(init.y, Game.GRID_SIZE.y)
	
	for part in parts:
		(part as Part).current_position = init
		init = (part as Part).prev_position
	
func grow():
	var init = Part.new()
	init.current_position = (parts.back() as Part).current_position
	
	parts.push_back(init)
	
func intersects(init: Rect2)->bool:
	for part in parts:
		if (part as Part).get_rect().intersects(init):
			return true
	return false
