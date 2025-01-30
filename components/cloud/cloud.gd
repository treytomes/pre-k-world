extends Node2D

@export var speed: float = -1

@export var leftExtent: float = -2000
@export var rightExtent: float = 2000

var base_scale: float = 50
var min_y: float = -240
var is_dragging: bool = false

# All times are in seconds.
var feelingChangeDelay: float = 3
var feelingChangeCounter: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = position.y
	scale = Vector2.ONE * base_scale * (min_y / (position.y * 1.5))
	
	# Change feelings every 3-6 seconds.
	feelingChangeDelay = 3 + randi_range(0, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	feelingChangeCounter += delta
	if feelingChangeCounter > feelingChangeDelay:
		change_feeling()
	
	if not is_dragging:
		position += Vector2.RIGHT * speed * delta
		if position.x < leftExtent:
			position.x = rightExtent
		elif position.x > rightExtent:
			position.x = leftExtent
		
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !event.pressed:
				is_dragging = false
				Globals.is_dragging_object = false
	elif event is InputEventMouseMotion:
		if is_dragging:
			var multiplier = get_viewport().get_camera_2d().zoom.x
			position.x += event.relative.x / multiplier
		

func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			Globals.is_dragging_object = is_dragging
		else:
			change_feeling()
			$AudioStreamPlayer2D.play()
			is_dragging = false
			Globals.is_dragging_object = is_dragging
	elif event is InputEventScreenTouch:
		change_feeling()
		$AudioStreamPlayer2D.play()
		is_dragging = event.pressed
		Globals.is_dragging_object = is_dragging


func change_feeling():
	feelingChangeCounter = 0
	$Face.set_random_feeling()
