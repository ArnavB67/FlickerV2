extends StaticBody2D

var PlayerInRange=false
var HasBattery=false
var Searched=false
@onready var color_rect: ColorRect = $ColorRect
var PlayerNode=null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Containers")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerInRange and not Searched:
		if color_rect.visible and Input.is_action_just_pressed("Interact"):
			Searched=true
			print("Noice")
			color_rect.visible=false
			if HasBattery:
				EquipBattery()
			return
				
		var IsClosest=true
		var Distance=global_position.distance_to(PlayerNode.global_position)
		for OtherContainers in get_tree().get_nodes_in_group("Containers"):
			if OtherContainers!=self and OtherContainers.PlayerInRange and not OtherContainers.Searched:
				if OtherContainers.global_position.distance_to(PlayerNode.global_position)<Distance:
					IsClosest=false
					break
		color_rect.visible=IsClosest



func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not Searched:
		PlayerInRange=true
		color_rect.visible=true
		PlayerNode=body
	


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerInRange=false
		color_rect.visible=false
		PlayerNode=null
		
		

func EquipBattery():
	if not BatteryManager.Battery2Found:
		BatteryManager.Battery2Found=true
	elif not BatteryManager.Battery3Found:
		BatteryManager.Battery3Found=true
	elif not BatteryManager.Battery4Found:
		BatteryManager.Battery4Found=true
