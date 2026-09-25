extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
enum State{Patrol,Alert,Chase,Trapped}
@export var Player:CharacterBody2D
@export var Torch:Panel
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
var Aggression=0
var PatrolSpeed=50
var ChaseSpeed=250
var MaxAlertTime=2
var AlertTimer=0
var CurrentState=State.Patrol

func _ready() -> void:
	await get_tree().physics_frame
	SetPatrolTargetLocation()

func _physics_process(delta: float) -> void:
	match CurrentState:
		State.Patrol:
			Patrol(delta)
		State.Alert:
			Alert(delta)
		State.Chase:
			Chase(delta)
		State.Trapped:
			Trapped(delta)

func Patrol(delta):
	if navigation_agent_2d.is_navigation_finished():
		SetPatrolTargetLocation()
	var Direction=global_position.direction_to(navigation_agent_2d.get_next_path_position())
	velocity=Direction*PatrolSpeed
	move_and_slide()
	#CheckProximity()


func SetPatrolTargetLocation():
	var RandomTargetLocation=Vector2.ZERO
	if randf()<Aggression:
		RandomTargetLocation=Player.global_position+Vector2(randf_range(-500,500),randf_range(-500,500))
	else:
		RandomTargetLocation=Vector2(randf_range(0,2000),randf_range(0,2000))
	navigation_agent_2d.target_position=RandomTargetLocation

func CheckProximity():
	var DistanceToPlayer=global_position.distance_to(Player.global_position)
	var LightRadius=Torch.BrightnessBoxValue/2
	var DetectionRadius=LightRadius+50
	if DistanceToPlayer<DetectionRadius:
		CurrentState=State.Alert
		AlertTimer=0

func Alert(delta):
	pass
	
func Chase(delta):
	pass
	
func Trapped(delta):
	pass
