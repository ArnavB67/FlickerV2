extends CharacterBody2D


const SPEED = 200.0
var BrightnessBoxValue=512
var MaxBatteryPercentage=100
var BatteryBaseDrainRate=0.01

var LightNoise=FastNoiseLite.new()
var PassedTime=0

func _ready() -> void:
	LightNoise.seed=randi()
	LightNoise.frequency=0.05
	$PlayerInventory.visible=false

func _process(delta: float) -> void:
	
	var NoiseSpeedMultiplier=lerp(5,20,1-(BatteryManager.Battery1Charge/100))
	PassedTime+=delta*NoiseSpeedMultiplier
	var LightFluctuation=LightNoise.get_noise_1d(PassedTime)
	var FluctuationInstability=lerp(0.1,0.8,1-(BatteryManager.Battery1Charge/100))
	$Camera2D/PointLight2D.energy=1+(LightFluctuation*FluctuationInstability)
		
	var Drain= BatteryBaseDrainRate*(BrightnessBoxValue/50)*(BrightnessBoxValue/50)*delta
	BatteryManager.Battery1Charge=max(0,BatteryManager.Battery1Charge-Drain)
	$PlayerUi/ProgressBar.value=BatteryManager.Battery1Charge
	$Camera2D/PointLight2D.texture.width=BrightnessBoxValue
	$Camera2D/PointLight2D.texture.height=BrightnessBoxValue
	
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


func _on_h_slider_value_changed(value: float) -> void:
	BrightnessBoxValue=value
