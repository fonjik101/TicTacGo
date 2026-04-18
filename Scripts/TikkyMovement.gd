extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var camera_animations: AnimationPlayer = $Camera/CameraAnimations

@export var WalkSpeed = 200
@export var JumpHeight = 200


#АНДРЕЙ, ПОЖАЙЛУСТА НАПИШИ ТУТ КОД ДЛЯ ПЕРЕДВИЖЕНЯ, ХОТЯ БЫ САМЫЙ ПРОСТОЙ - фончи



func camera_shake(Intensity: int, ZoomSpeed: float):
	#ПОДЛЕЖИТ ДАЛНЬЕЙШЕМУ ТЕСТИРОВАНИЮ - фончи
	camera_animations.play("ZoomIn")
	camera_animations.speed_scale = ZoomSpeed
	while Intensity > 0:
		camera.offset.x = -Intensity
		await get_tree().create_timer(0.02).timeout
		camera.offset.x = Intensity
		await get_tree().create_timer(0.02).timeout
		Intensity -= 1
