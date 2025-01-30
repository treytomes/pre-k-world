@tool
extends Node2D

@export var radius: float = 1:
	set(value):
		radius = value
		queue_redraw()

@export var color: Color = Color(1, 0, 0):
	set(value):
		color = value
		queue_redraw()

@export var start_angle: float = 0:
	set(value):
		start_angle = value
		queue_redraw()

@export var end_angle: float = 0:
	set(value):
		end_angle = value
		queue_redraw()

@export var point_count: float = 0:
	set(value):
		point_count = value
		queue_redraw()

@export var width: float = -1:
	set(value):
		width = value
		queue_redraw()

@export var antialiased: bool = false:
	set(value):
		antialiased = value
		queue_redraw()
	
#func _ready():
	#update()  # Ensure the circle is drawn on start
	#queue_redraw()

#func _process(delta: float) -> void:
	#queue_redraw()

func _draw():
	draw_arc(Vector2(0, 0), radius, start_angle, end_angle, point_count, color, width, antialiased)
