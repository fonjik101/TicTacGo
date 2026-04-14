extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var camera_animations: AnimationPlayer = $Camera2D/CameraAnimations


@export var speed = 300.0
@export var sprint_speed = 500.0  # скорость при беге
@export var jump_force = -400.0
@export var sprint_jump_force = -450.0  # прыжок при беге
@export var gravity = 1200.0
@export var min_stamina_to_sprint = 20.0  # минимальная стамина для начала бега (%)

var experience = 0
var artifacts = 0
var health = 100
var is_sprinting = false
var stamina = 100.0  # выносливость для бега
var max_stamina = 100.0
var stamina_regen_rate = 20.0  # восстановление в секунду
var stamina_drain_rate = 40.0  # расход в секунду
var was_sprinting = false  # для отслеживания предыдущего состояния
var sprite_flip = false

func _physics_process(delta):
	# Проверка минимальной стамины для начала бега
	var can_start_sprint = (stamina / max_stamina * 100) >= min_stamina_to_sprint
	var wants_to_sprint = Input.is_action_pressed("sprint") and is_on_floor() and velocity.x != 0
	
	# Если уже бежим, продолжаем даже при низкой стамине (но не ниже 0)
	if is_sprinting:
		# Продолжаем бег, если хотим и стамина > 0
		is_sprinting = wants_to_sprint and stamina > 0
	else:
		# Начинаем бег только если хватает минимальной стамины
		is_sprinting = wants_to_sprint and can_start_sprint
	
	# Расход/восстановление выносливости
	if is_sprinting and velocity.x != 0:
		stamina = max(stamina - stamina_drain_rate * delta, 0)
		if stamina <= 0:
			is_sprinting = false
	else:
		stamina = min(stamina + stamina_regen_rate * delta, max_stamina)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if is_sprinting:
			velocity.y = sprint_jump_force
			velocity.x = sign(velocity.x) * sprint_speed * 0.8
		else:
			velocity.y = jump_force
	
	var direction = Input.get_axis("move_left", "move_right")
	var current_speed = sprint_speed if is_sprinting else speed
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * current_speed, current_speed/10)
		$Sprite2D.flip_h = direction < 0
		if is_on_floor():
			if is_sprinting:
				$Sprite2D.play("sprint")
			else:
				$Sprite2D.play("walk")
		else:
			$Sprite2D.play("fall")
	else:
		velocity.x = move_toward(velocity.x, 0, speed/10)
		if is_on_floor():
			$Sprite2D.play("idle")
		else:
			$Sprite2D.play("fall")
	
	move_and_slide()
	
	# Проверка падения
	if position.y > 1000:
		game_over()

func take_damage(damage):
	health -= damage
	$HealthBar.value = health
	if health <= 0:
		game_over()

func add_experience(amount):
	experience += amount
	$ExperienceBar.value = experience
	# Проверка уровня
	if experience >= 100:
		level_up()

func collect_artifact():
	artifacts += 1
	$ArtifactLabel.text = "Артефакты: " + str(artifacts)
	# Восстановление выносливости при сборе артефакта
	stamina = max_stamina
	$StaminaBar.value = stamina

func level_up():
	speed += 50
	sprint_speed += 70
	max_stamina += 20
	stamina = max_stamina
	health = min(health + 30, 100)
	$StaminaBar.max_value = max_stamina

func game_over():
	get_tree().reload_current_scene()

# Получение бонуса выносливости
func add_stamina_bonus(amount):
	max_stamina += amount
	stamina = max_stamina
	$StaminaBar.max_value = max_stamina

func shake_camera():
	camera_animations.play("camera_shake")
	var shake = 0
	while shake <= 10:
		camera_2d.offset.x = -50 + shake * 5
		await get_tree().create_timer(0.01).timeout
		camera_2d.offset.x = 50 - shake * 5
		await get_tree().create_timer(0.01).timeout
		shake += 1
