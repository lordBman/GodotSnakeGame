extends Label

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	Game.score_change.connect(score_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func score_changed(score: int)->void:
	text = "Score: " + str(score)
	
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "modulate:a", 1, 0.6).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0, 0.6).set_ease(Tween.EASE_IN)
