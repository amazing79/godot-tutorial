extends Node2D

@export var total : int = 15

var original: Color = Color(1,1,1)
var state: int 
var step : int 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = 1
	step = 1
	$Timer.start()


func _on_timer_timeout() -> void:
	match state:
		1:
			$LevelText.modulate = Color(0, 0, 0, 1)
		2:
			$LevelText.modulate =Color(1.0, 0.179, 0.336, 1.0)
		3: 
			$LevelText.modulate = original
	state += 1
	step += 1
	if state == 4 :
		state = 1
	if step == total:
		$Timer.stop()
		queue_free() 
