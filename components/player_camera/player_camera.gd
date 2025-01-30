extends Node2D


@export var speed = 5
@export var zoom_multiplier = 0.1
@export var zoom_min = 0.3
@export var zoom_max = 1.3

var velocity: Vector2 = Vector2.ZERO
var is_dragging: bool = false


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.c


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.is_dragging_object:
		is_dragging = false
	
	position += velocity
	var bounds = get_viewport_rect()
	bounds.size /= $Camera.zoom
	#print("Bounds: " + str(position.y + bounds.size.y / 2))
	if position.y + bounds.size.y / 2 > 386:
		position.y = 386 - bounds.size.y / 2
	#print("Camera position: " + str(position))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		on_mouse_button_event(event as InputEventMouseButton)
	elif event is InputEventMouseMotion:
		on_mouse_motion(event as InputEventMouseMotion)
	
	if event.is_action_pressed("move_left", true):
		velocity.x = -speed
	elif event.is_action_pressed("move_right", true):
		velocity.x = speed
	else:
		velocity.x = 0
	
	if event.is_action_pressed("move_up", true):
		velocity.y = -speed
	elif event.is_action_pressed("move_down", true):
		velocity.y = speed
	else:
		velocity.y = 0
	
	if event.is_action_pressed("zoom_in", true):
		$Camera.zoom += Vector2.ONE * event.factor * zoom_multiplier
		if $Camera.zoom.x > zoom_max:
			$Camera.zoom = Vector2.ONE * zoom_max
		position = event.position
	elif event.is_action_pressed("zoom_out", true):
		$Camera.zoom -= Vector2.ONE * event.factor * zoom_multiplier
		if $Camera.zoom.x < zoom_min:
			$Camera.zoom = Vector2.ONE * zoom_min
		position = event.position
	

func on_mouse_button_event(event: InputEventMouseButton) -> void:
	if Globals.is_dragging_object:
		return
	is_dragging = false
	if event.button_index == MOUSE_BUTTON_LEFT:
		if not Globals.is_dragging_object:
			is_dragging = event.pressed


func on_mouse_motion(event: InputEventMouseMotion) -> void:
	if Globals.is_dragging_object:
		return
	if is_dragging:
		position -= event.relative
