extends Sprite

var spell = preload("res://scenes//spell.tscn")
onready var mages_floor = get_node("mages_floor")

var move_target
var speed
var way
var UP = Vector2(0,-1)
var DOWN = Vector2(0,1)

func _ready():
	set_process(true)
	set_process_input(true)

func spawn(position):
	set_pos(position)
	move_target = Vector2(0,0)
	speed = 200

func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			var position = event.pos
			if position.x > 100:
				throw_spell(position)
			else:
				start_move(position.y)
	
func start_move(y):
	move_target = Vector2(0,y)
	if get_pos().y > move_target.y:
		way = UP
		set_flip_h(false)
		set_rotd(90)
	else:
		way = DOWN
		set_flip_h(false)
		set_rotd(-90)

func throw_spell(target):
	var spell_node = spell.instance()
	spell_node.throw(get_pos(), target, 300)
	get_parent().add_child(spell_node)

	
func _process(delta):
	if not is_on_target():
		if move_target != Vector2(0,0):
			var position = (get_pos() + way) + delta * speed * way.normalized()
			set_pos(position)
	else:
		set_rotd(0)

func is_on_target():
	var target = move_target.y
	var position = get_pos().y
	if target == position: return true
	if way == UP:
		return position < target
	else:
		return position > target