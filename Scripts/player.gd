extends CharacterBody2D


const SPEED = 200.0


func _ready() -> void:
	$PlayerInventory.visible=false

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Inventory"):
		$PlayerInventory.visible=!$PlayerInventory.visible

func _physics_process(delta: float) -> void:
	var Direction:= Input.get_vector("Left","Right","Up","Down")

	if Direction!=Vector2(0,0):
		velocity=SPEED*Direction
		rotation= lerp_angle(global_rotation,Direction.angle(),10*delta)
		
	else:
		velocity=Vector2.ZERO
	move_and_slide()
