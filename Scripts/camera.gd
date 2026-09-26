extends Panel

var CameraBatteryId=null
var CameraFOV=50
var BatteryBaseDrainRate=0.1
var LightNoise=FastNoiseLite.new()
var PassedTime=0
@onready var point_light_2d: PointLight2D = $"../../../Camera2D/CameraLight"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LightNoise.seed=randi()
	LightNoise.frequency=0.05


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CameraBatteryId==null:
		point_light_2d.visible=false
	else:
		var CameraBatteryCharge=BatteryManager.GetBatteryCharge(CameraBatteryId)
		if CameraBatteryCharge==0:
			point_light_2d.visible=false
		else:
			point_light_2d.visible=true
			var NoiseSpeedMultiplier=lerp(5,20,1-(CameraBatteryCharge/100))
			PassedTime+=delta*NoiseSpeedMultiplier
			var LightFluctuation=LightNoise.get_noise_1d(PassedTime)
			var FluctuationInstability=lerp(0.1,0.8,1-(CameraBatteryCharge/100))
			point_light_2d.energy=1+(LightFluctuation*FluctuationInstability)
			point_light_2d.texture.width=CameraFOV
			point_light_2d.texture.height=CameraFOV
			var Drain= BatteryBaseDrainRate*(CameraFOV/50)*(CameraFOV/50)*delta
			BatteryManager.DrainBatteryCharge(CameraBatteryId,Drain)


func _on_v_slider_value_changed(value: float) -> void:
	CameraFOV=value
