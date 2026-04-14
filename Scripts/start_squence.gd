extends Node2D

@onready var tikky: CharacterBody2D = $"../Tikky"

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	tikky.shake_camera()
