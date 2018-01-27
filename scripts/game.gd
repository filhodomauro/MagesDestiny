extends Node

onready var mages_floor = get_node("mages_floor")

var mage = preload("res://scenes//mage.tscn")

var central_position

func _ready():
	central_position = get_viewport().get_rect().size.x / 2
	add_players()

func add_players():
	var mage_node = mage.instance()
	mage_node.spawn(Vector2(50,get_viewport().get_rect().size.y / 2))
	mages_floor.add_child(mage_node)
	