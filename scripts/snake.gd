class_name Snake extends Node2D

var current_direction := Vector2.RIGHT;
var next_direction := Vector2.RIGHT;
var tween_move: Tween
var alive := true;
signal on_hit(part: Part)

var parts := []

# Called when the node enters the scene tree for the first time.
func _ready():
	var head = Part.new()
	head.color = Colors.BLUE_DARK
	
	parts.push_front(head)
	on_hit.connect(_on_hit)
	
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
	if alive:
		current_direction = next_direction
		var init = Vector2(parts.front().current_position + (current_direction * Game.CELL_SIZE))
		
		init.x = fposmod(init.x, Game.GRID_SIZE.x)
		init.y = fposmod(init.y, Game.GRID_SIZE.y)
		
		var is_hit = intersects(init)
		if is_hit:
			alive = false
		else:
			for part in parts:
				(part as Part).current_position = init
				init = (part as Part).prev_position
	else:
		tween_move.kill()
	
func grow():
	var init = Part.new()
	init.current_position = (parts.back() as Part).current_position
	
	parts.push_back(init)
	
func intersects(init: Vector2)->bool:
	var index = 0;
	for part in parts:
		if (part as Part).get_rect().intersects(Rect2(init, Vector2(Game.CELL_SIZE, Game.CELL_SIZE))):
			if index > 0:
				on_hit.emit(part as Part)
			return true
		index += 1
	return false
	
func eaten(init: Vector2)->bool:
	return (parts.front() as Part).get_rect().intersects(Rect2(init, Vector2(Game.CELL_SIZE, Game.CELL_SIZE)))
	
func _on_hit(part: Part):
	# part.color = Colors.RED
	var tween_pulse =create_tween().set_trans(Tween.TRANS_CIRC).set_loops()
	tween_pulse.tween_property(part, "color", Colors.RED, 0.6).set_ease(Tween.EASE_OUT)
	tween_pulse.tween_property(part, "color", Colors.BLUE, 0.6).set_ease(Tween.EASE_IN).set_delay(0.1)
	
