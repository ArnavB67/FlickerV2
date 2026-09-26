extends CharacterBody2D


const SPEED = 200.0


func _ready() -> void:
	$PlayerUi/PlayerInventory.visible=false

func _process(delta: float) -> void:
	$PlayerUi/Battery1.value=BatteryManager.Battery1Charge
	$PlayerUi/Battery2.value=BatteryManager.Battery2Charge
	$PlayerUi/Battery3.value=BatteryManager.Battery3Charge
	$PlayerUi/Battery4.value=BatteryManager.Battery4Charge
	if BatteryManager.Battery1Found:
		$PlayerUi/Battery1/Label.text='1'
	if BatteryManager.Battery2Found:
		$PlayerUi/Battery2/Label.text='2'
	if BatteryManager.Battery3Found:
		$PlayerUi/Battery3/Label.text='3'
	if BatteryManager.Battery4Found:
		$PlayerUi/Battery4/Label.text='4'
	
	if Input.is_action_just_pressed("Inventory"):
		$PlayerUi/PlayerInventory.visible=!$PlayerUi/PlayerInventory.visible

func _physics_process(delta: float) -> void:
	var Direction:= Input.get_vector("Left","Right","Up","Down")

	if Direction!=Vector2(0,0):
		velocity=SPEED*Direction
		rotation= lerp_angle(global_rotation,Direction.angle(),10*delta)
		
	else:
		velocity=Vector2.ZERO
	move_and_slide()
