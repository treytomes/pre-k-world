@tool
extends Node2D


var color_node: Node2D


@export var color: Color = Color(1, 0, 0):
	set(value):
		color = value
		if color_node:
			color_node.color = get_light_color()
		queue_redraw()


@export var is_active: bool = false:
	set(value):
		is_active = value
		if color_node:
			color_node.color = get_light_color()
		queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_node = get_node("Frame/Color")
	color_node.color = get_light_color()


func get_light_color() -> Color:
	if is_active:
		return color
	else:
		return color.darkened(0.6)


func toggle_light():
	is_active = not is_active
