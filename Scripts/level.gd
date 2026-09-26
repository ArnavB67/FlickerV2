extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	var Containers=get_tree().get_nodes_in_group("Containers")
	Containers.shuffle()
	for i in range(3):
		Containers[i].HasBattery=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_background_finished() -> void:
	$Background.play()
