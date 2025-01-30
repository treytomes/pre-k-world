@tool
extends Node2D


func _process(delta: float) -> void:
	queue_redraw()


func get_camera_rect() -> Rect2:
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		return get_viewport_rect()
	
	var pos = camera.global_position
	var zoom = get_viewport().get_camera_2d().zoom
	var size = get_viewport_rect().size / zoom
	var half_size = size / 2
	return Rect2(pos - half_size, size)


func _on_draw() -> void:
	draw_rect(get_camera_rect(), Color.SKY_BLUE, true)
	
