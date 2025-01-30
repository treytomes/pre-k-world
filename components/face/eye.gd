@tool
extends Node2D

enum State {
	OPEN,
	CLOSED,
	HAPPY,
	SLANT_IN,
	SLANT_OUT,
}

@export var color: Color = Color.from_string("6392ff", Color.BLACK):
	set(value):
		color = value
		queue_redraw()

@export var state: State = State.OPEN:
	set(value):
		state = value
		queue_redraw()

@export var width: float = 0.2:
	set(value):
		width = value
		queue_redraw()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw() -> void:
	var radius = 1
	var filled = true
	var antialiased = false
	var point_count = 7
	if state == State.OPEN:
		draw_circle(Vector2.ZERO, radius, color, filled, width, antialiased)
	elif state == State.CLOSED:
		var start_angle = 0
		var end_angle = PI
		draw_arc(Vector2.ZERO, radius, start_angle, end_angle, point_count, color, width, antialiased)
	elif state == State.HAPPY:
		var start_angle = PI
		var end_angle = TAU
		draw_arc(Vector2.ZERO, radius, start_angle, end_angle, point_count, color, width, antialiased)
	elif state == State.SLANT_IN:
		var from = Vector2(-1.1, -0.7)
		var to = Vector2(1.1, 0.7)
		draw_line(from, to, color, width * 1.5, antialiased)
	elif state == State.SLANT_OUT:
		var from = Vector2(-1.1, 0.7)
		var to = Vector2(1.1, -0.7)
		draw_line(from, to, color, width * 1.5, antialiased)
