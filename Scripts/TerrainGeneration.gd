#МОЯ ПОПЫТКА СДЕЛАТЬ ГЕНЕРАЦИЮ КАРТЫ
extends TileMap

@onready var tile_map: TileMap = $"."

var x_cord = -2
var y_cord = 2

func _ready() -> void:
	for i in range(3):
		tile_map.set_cell(0, Vector2i(x_cord, y_cord), 0, Vector2i(0, 0))
		y_cord += 1
		for n in range(5):
			tile_map.set_cell(0, Vector2i(x_cord, y_cord), 0, Vector2i(0, 1))
			y_cord += 1
		y_cord = 2
		x_cord += 1
		for b in range(3):
			tile_map.set_cell(0, Vector2i(x_cord, y_cord), 0, Vector2i(1, 0))
			x_cord += 1
