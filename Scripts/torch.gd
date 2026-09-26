extends Panel

var TorchBatteryId=null
var BrightnessBoxValue=50
var BatteryBaseDrainRate=0.01
var LightNoise=FastNoiseLite.new()
var PassedTime=0
@onready var point_light_2d: PointLight2D = $"../../../Camera2D/PointLight2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LightNoise.seed=randi()
	LightNoise.frequency=0.05


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TorchBatteryId==null:
		point_light_2d.visible=false
	else:
		var TorchBatteryCharge=BatteryManager.GetBatteryCharge(TorchBatteryId)
		if TorchBatteryCharge==0:
			point_light_2d.visible=false
		else:
			point_light_2d.visible=true
			var NoiseSpeedMultiplier=lerp(5,20,1-(TorchBatteryCharge/100))
			PassedTime+=delta*NoiseSpeedMultiplier
			var LightFluctuation=LightNoise.get_noise_1d(PassedTime)
			var FluctuationInstability=lerp(0.1,0.8,1-(TorchBatteryCharge/100))
			point_light_2d.energy=1+(LightFluctuation*FluctuationInstability)
			point_light_2d.texture.width=BrightnessBoxValue
			point_light_2d.texture.height=BrightnessBoxValue
			var Drain= BatteryBaseDrainRate*(BrightnessBoxValue/50)*(BrightnessBoxValue/50)*delta
			BatteryManager.DrainBatteryCharge(TorchBatteryId,Drain)


func _on_h_slider_value_changed(value: float) -> void:
	BrightnessBoxValue=value
