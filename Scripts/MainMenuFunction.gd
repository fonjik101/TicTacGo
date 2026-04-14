extends Control

@export var small_scale = 1.0
@export var big_scale = 1.2
@export var pressed_scale = 0.6
@export var speed = 5.0

@onready var play_button: Button = $Interactables/Play
@onready var host_button: Button = $Interactables/Host
@onready var join_button: Button = $Interactables/Join
@onready var settings_button: Button = $Interactables/Settings
@onready var quit_button: Button = $Interactables/Quit

var GLOBAL_DELTA: float

func _ready() -> void:
	#МНЕ БЫЛО ЛЕНЬ ДЕЛАТЬ ЭТО В РЕДАКТОРЕ ТАК ЧТО... ДА - фончи
	_set_button_offset(play_button)
	_set_button_offset(host_button)
	_set_button_offset(join_button)
	_set_button_offset(settings_button)
	_set_button_offset(quit_button)

func _set_button_offset(current_button: Button):
	current_button.pivot_offset = Vector2(
		current_button.size.x/2, 
		current_button.size.y/2
		)

func _process(delta: float) -> void:
	#МНЕ БЫЛО ЛЕНЬ ПРИДУМЫВАТЬ ЧТО-ТО ТАК ЧТО Я ПРОСТО СДЕЛАЛ GLOBAL_DELTA - фончи
	GLOBAL_DELTA = delta
	
	#ФУНКЦИЯ IS_HOVERED ДЛЯ КНОПОК 
	#(ЗАМЕТКА ДЛЯ СЕБЯ: ПОПРОБУЙ ОПТИМИЗИРОВАТЬ КОД РАЗБИВ ЕГО НА 2 ФУНКЦИИ, НО НЕ ЗАБУДЬ ПРОТЕСТИРОВАТЬ) - фончи
	#START
	if play_button.is_hovered():
		play_button.scale = Vector2(
			lerpf(play_button.scale.x, big_scale, delta * speed), 
			lerpf(play_button.scale.y, big_scale, delta * speed)
			)
	else:
		play_button.scale = Vector2(
			lerpf(play_button.scale.x, small_scale, delta * speed), 
			lerpf(play_button.scale.y, small_scale, delta * speed)
			)
	#HOST
	if host_button.is_hovered():
		host_button.scale = Vector2(
			lerpf(host_button.scale.x, big_scale, delta * speed), 
			lerpf(host_button.scale.y, big_scale, delta * speed)
			)
	else:
		host_button.scale = Vector2(
			lerpf(host_button.scale.x, small_scale, delta * speed), 
			lerpf(host_button.scale.y, small_scale, delta * speed)
			)
	#JOIN
	if join_button.is_hovered():
		join_button.scale = Vector2(
			lerpf(join_button.scale.x, big_scale, delta * speed), 
			lerpf(join_button.scale.y, big_scale, delta * speed)
			)
	else:
		join_button.scale = Vector2(
			lerpf(join_button.scale.x, small_scale, delta * speed), 
			lerpf(join_button.scale.y, small_scale, delta * speed)
			)
	#SETTINGS
	if settings_button.is_hovered():
		settings_button.scale = Vector2(
			lerpf(settings_button.scale.x, big_scale, delta * speed), 
			lerpf(settings_button.scale.y, big_scale, delta * speed)
			)
	else:
		settings_button.scale = Vector2(
			lerpf(settings_button.scale.x, small_scale, delta * speed), 
			lerpf(settings_button.scale.y, small_scale, delta * speed)
			)
	#QUIT
	if quit_button.is_hovered():
		quit_button.scale = Vector2(
			lerpf(quit_button.scale.x, big_scale, delta * speed), 
			lerpf(quit_button.scale.y, big_scale, delta * speed)
			)
	else:
		quit_button.scale = Vector2(
			lerpf(quit_button.scale.x, small_scale, delta * speed), 
			lerpf(quit_button.scale.y, small_scale, delta * speed)
			)
