extends Node2D

enum Feeling {
	HAPPY,
	SURPRISED,
	SAD,
	MAD,
	ASLEEP,
	EXCITED,
}

@export var feeling: Feeling = Feeling.HAPPY:
	set(value):
		feeling = value
		reset_face()

@export var speed: float = -1

@export var leftExtent: float = -2000
@export var rightExtent: float = 2000

var left_eye: Node2D
var right_eye: Node2D
var mouth: Node2D
var base_scale: float = 50
var min_y: float = -240
var is_dragging: bool = false

# All times are in seconds.
var feelingChangeDelay: float = 3
var feelingChangeCounter: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_eye = get_node("Face/Left Eye")
	right_eye = get_node("Face/Right Eye")
	mouth = get_node("Face/Mouth")
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
			print("Begin dragging cloud.")
		else:
			change_feeling()
			$AudioStreamPlayer2D.play()
			is_dragging = false
			Globals.is_dragging_object = is_dragging
			print("Done dragging cloud.")
	elif event is InputEventScreenTouch:
		change_feeling()
		$AudioStreamPlayer2D.play()
		is_dragging = event.pressed
		Globals.is_dragging_object = is_dragging
	#elif event is InputEventMouseMotion:
		#if is_dragging:
			#position.x = event.position.x
			##position.x += event.relative.x
			##print("Cloud dragging.")


func change_feeling():
	feelingChangeCounter = 0
	var value = randi_range(0, 5)
	if value == 0:
		feeling = Feeling.HAPPY
	elif value == 1:
		feeling = Feeling.SURPRISED
	elif value == 2:
		feeling = Feeling.SAD
	elif value == 3:
		feeling = Feeling.MAD
	elif value == 4:
		feeling = Feeling.ASLEEP
	elif value == 5:
		feeling = Feeling.EXCITED

func reset_face():
	if left_eye == null:
		return
	
	if feeling == Feeling.HAPPY:
		left_eye.state = left_eye.State.OPEN
		right_eye.state = right_eye.State.OPEN
		mouth.state = mouth.State.SMILE
	elif feeling == Feeling.SURPRISED:
		left_eye.state = left_eye.State.OPEN
		right_eye.state = right_eye.State.OPEN
		mouth.state = mouth.State.SURPRISED
	elif feeling == Feeling.SAD:
		left_eye.state = left_eye.State.OPEN
		right_eye.state = right_eye.State.OPEN
		mouth.state = mouth.State.FROWN
	elif feeling == Feeling.MAD:
		left_eye.state = left_eye.State.SLANT_IN
		right_eye.state = right_eye.State.SLANT_OUT
		mouth.state = mouth.State.FROWN
	elif feeling == Feeling.ASLEEP:
		left_eye.state = left_eye.State.CLOSED
		right_eye.state = right_eye.State.CLOSED
		mouth.state = mouth.State.SMILE
	elif feeling == Feeling.EXCITED:
		left_eye.state = left_eye.State.SLANT_OUT
		right_eye.state = right_eye.State.SLANT_IN
		mouth.state = mouth.State.SMILE
		
