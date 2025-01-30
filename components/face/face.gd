@tool
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

@export var color: Color = Color.from_string("6392ff", Color.BLACK):
	set(value):
		color = value
		set_colors()

@export var background_color: Color = Color.WHITE:
	set(value):
		background_color = value
		set_colors()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_random_feeling():
	var value = get_feeling_value()
	while value == get_feeling_value():
		value = randi_range(0, 5)
	set_feeling_by_value(value)


func get_feeling_value() -> int:
	if feeling == Feeling.HAPPY:
		return 0
	elif feeling == Feeling.SURPRISED:
		return 1
	elif feeling == Feeling.SAD:
		return 2
	elif feeling == Feeling.MAD:
		return 3
	elif feeling == Feeling.ASLEEP:
		return 4
	elif feeling == Feeling.EXCITED:
		return 5
	return 0
	

func set_feeling_by_value(value: int):
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
	if $LeftEye == null:
		return
	
	if feeling == Feeling.HAPPY:
		$LeftEye.state = $LeftEye.State.OPEN
		$RightEye.state = $RightEye.State.OPEN
		$Mouth.state = $Mouth.State.SMILE
	elif feeling == Feeling.SURPRISED:
		$LeftEye.state = $LeftEye.State.OPEN
		$RightEye.state = $RightEye.State.OPEN
		$Mouth.state = $Mouth.State.SURPRISED
	elif feeling == Feeling.SAD:
		$LeftEye.state = $LeftEye.State.OPEN
		$RightEye.state = $RightEye.State.OPEN
		$Mouth.state = $Mouth.State.FROWN
	elif feeling == Feeling.MAD:
		$LeftEye.state = $LeftEye.State.SLANT_IN
		$RightEye.state = $RightEye.State.SLANT_OUT
		$Mouth.state = $Mouth.State.FROWN
	elif feeling == Feeling.ASLEEP:
		$LeftEye.state = $LeftEye.State.CLOSED
		$RightEye.state = $RightEye.State.CLOSED
		$Mouth.state = $Mouth.State.SMILE
	elif feeling == Feeling.EXCITED:
		$LeftEye.state = $LeftEye.State.SLANT_OUT
		$RightEye.state = $RightEye.State.SLANT_IN
		$Mouth.state = $Mouth.State.BIG_SMILE


func set_colors():
	if $LeftEye != null:
		$LeftEye.color = color
	if $RightEye != null:
		$RightEye.color = color
	if $Mouth != null:
		$Mouth.color = color
		$Mouth.background_color = background_color
