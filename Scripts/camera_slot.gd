extends Panel

@export var Camera:Node

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if typeof(data)==TYPE_DICTIONARY and data.has("Item") and data["Item"]=="Battery":
		return true
	else:
		return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var Battery=data["Node"]
	Battery.get_parent().remove_child(Battery)
	add_child(Battery)
	Battery.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	Camera.CameraBatteryId=data["BatteryId"]


func _on_child_exiting_tree(node: Node) -> void:
	Camera.CameraBatteryId=null
