extends TextureRect

var BatteryId='Battery3'

func _get_drag_data(at_position: Vector2) -> Variant:
	var Data={
		"Item":'Battery',
		"BatteryId":BatteryId,
		"Node":self
	}
	var MouseFollowPreview=TextureRect.new()
	MouseFollowPreview.texture=texture
	MouseFollowPreview.size=size
	var MouseFollowControl=Control.new()
	MouseFollowControl.add_child(MouseFollowPreview)
	MouseFollowPreview.position=-0.5*size
	set_drag_preview(MouseFollowControl)
	return Data

func _process(delta: float) -> void:
	visible=BatteryManager.Battery3Found
