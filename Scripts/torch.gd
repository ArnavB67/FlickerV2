extends Panel

var TorchBatteryId=null
var BrightnessBoxValue=50
var BatteryBaseDrainRate=0.01
var LightNoise=FastNoiseLite.new()
var PassedTime=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LightNoise.seed=randi()
	LightNoise.frequency=0.05


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if TorchBatteryId==null:
		$"../../Camera2D/PointLight2D".visible=false
	else:
		var TorchBatteryCharge=BatteryManager.GetBatteryCharge(TorchBatteryId)
		if TorchBatteryCharge==0:
			$"../../Camera2D/PointLight2D".visible=false
		else:
			$"../../Camera2D/PointLight2D".visible=true
			var NoiseSpeedMultiplier=lerp(5,20,1-(TorchBatteryCharge/100))
			PassedTime+=delta*NoiseSpeedMultiplier
			var LightFluctuation=LightNoise.get_noise_1d(PassedTime)
			var FluctuationInstability=lerp(0.1,0.8,1-(TorchBatteryCharge/100))
			$"../../Camera2D/PointLight2D".energy=1+(LightFluctuation*FluctuationInstability)
			$"../../PlayerUi/ProgressBar".value=TorchBatteryCharge
			$"../../Camera2D/PointLight2D".texture.width=BrightnessBoxValue
			$"../../Camera2D/PointLight2D".texture.height=BrightnessBoxValue
			var Drain= BatteryBaseDrainRate*(BrightnessBoxValue/50)*(BrightnessBoxValue/50)*delta
			BatteryManager.DrainBatteryCharge(TorchBatteryId,Drain)


func _on_h_slider_value_changed(value: float) -> void:
	BrightnessBoxValue=value
