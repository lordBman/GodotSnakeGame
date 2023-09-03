class_name Part

var current_position := Vector2(): set = _set_position
var prev_position := Vector2()

var size := Vector2(Game.CELL_SIZE, Game.CELL_SIZE)
var color := Colors.BLUE

func  get_rect()->Rect2:
	return Rect2(current_position, size)
	
func _set_position(position: Vector2):
	prev_position = current_position
	current_position = position
