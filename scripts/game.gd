extends  Node

const GRID_SIZE := Vector2(800, 480)
const CELL_SIZE := 32

const CELL_AMOUNT := Vector2(GRID_SIZE.x / CELL_SIZE, GRID_SIZE.y / CELL_SIZE)

var score := 0 : set = _set_score
signal score_change(new_score: int)

func _set_score(new_score: int):
	score = new_score
	score_change.emit(new_score)
