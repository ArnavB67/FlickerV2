extends Node

var Battery1Found=true
var Battery2Found=false
var Battery3Found=false
var Battery4Found=false
var Battery1Charge=100
var Battery2Charge=100
var Battery3Charge=100
var Battery4Charge=100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func GetBatteryCharge(BatteryId):
	if BatteryId=="Battery1":
		return Battery1Charge
	if BatteryId=="Battery2":
		return Battery2Charge
	if BatteryId=="Battery3":
		return Battery3Charge
	if BatteryId=="Battery4":
		return Battery4Charge
	else:
		return 0

func DrainBatteryCharge(BatteryId,DrainAmount):
	if BatteryId=="Battery1":
		Battery1Charge=max(0,Battery1Charge-DrainAmount)
	if BatteryId=="Battery2":
		Battery2Charge=max(0,Battery2Charge-DrainAmount)
	if BatteryId=="Battery3":
		Battery3Charge=max(0,Battery3Charge-DrainAmount)
	if BatteryId=="Battery4":
		Battery4Charge=max(0,Battery4Charge-DrainAmount)
