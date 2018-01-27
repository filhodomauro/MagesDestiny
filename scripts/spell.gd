extends Node2D

var target
var speed
var limits

func _ready():
	limits = get_viewport().get_rect().size
	set_process(true)

func throw(origin, target, speed):
	self.target = target
	self.speed = speed
	set_pos(origin)
	
func _process(delta):
	if not is_out_of_range():
		var position = get_pos() + delta * speed * target.normalized()
		set_pos(position)
	else:
		release()

func is_out_of_range():
	var pos = get_pos()
	return pos.x < 0 or pos.y < 0 or pos.x > limits.x or pos.y > limits.y
	
func release():
	queue_free()