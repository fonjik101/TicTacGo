extends Control

@export var CanReplaceArtifact = true

@export var MaxHealth = 100
@export var StyleGoal = 1000

var Health = MaxHealth
var Style = 0

func _process(delta: float) -> void:
	if Health <= 0:
		get_tree().quit()
