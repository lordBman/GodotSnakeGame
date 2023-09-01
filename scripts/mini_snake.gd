class_name MiniSnake

var current_position := Vector2()
var size := Vector2()
var color := Color()

func  get_rect()->Rect2:
	return Rect2(current_position, size)
