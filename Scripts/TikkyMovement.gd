extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var camera_animations: AnimationPlayer = $Camera/CameraAnimations

@export var WalkSpeed = 200
@export var JumpHeight = 200


#АНДРЕЙ, ПОЖАЙЛУСТА НАПИШИ ТУТ КОД ДЛЯ ПЕРЕДВИЖЕНЯ, ХОТЯ БЫ САМЫЙ ПРОСТОЙ - фончи
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JumpHeight

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * WalkSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, WalkSpeed)

	move_and_slide()


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
