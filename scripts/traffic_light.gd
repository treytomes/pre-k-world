extends Node2D


var outer_frame: Node2D
var red_light: Node2D
var yellow_light: Node2D
var green_light: Node2D

var selected_light: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	outer_frame = get_node("Outer Frame")
	red_light = get_node("Outer Frame/Inner Frame/Red Light")
	yellow_light = get_node("Outer Frame/Inner Frame/Yellow Light")
	green_light = get_node("Outer Frame/Inner Frame/Green Light")
	
	selected_light = red_light
	selected_light.is_active = true


func toggle_lights():
	selected_light.is_active = false
	if selected_light == red_light:
		selected_light = green_light
	elif selected_light == green_light:
		selected_light = yellow_light
	else:
		selected_light = red_light
	$AudioStreamPlayer2D.play()
	selected_light.is_active = true


func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !event.pressed):
		toggle_lights()
	elif event is InputEventScreenTouch:
		toggle_lights()
