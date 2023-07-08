## Класс ищущий нужные элементы на поле
class_name CardFinder extends RefCounted

func _init(size: Vector2i = Vector2i(), field: Array[Card] = []):
	self.size = size
	self.field = field

var size: Vector2i = Vector2i(0,0)
var field: Array = [Card]


func i_xy(length: int) -> Vector2i: 
	@warning_ignore("integer_division")
	print(size)
	return Vector2i(length % size.x,length / size.x)

func xy_i(coord: Vector2i) -> int:
	return coord.x + coord.y * size.x

func in_range_x(coord: Vector2i) -> bool:
	return coord.x >= 0 && coord.x < size.x

func in_range_y(coord: Vector2i) -> bool:
	return coord.y >= 0 && coord.y < size.y

func in_range(coord: Vector2i) -> bool:
	return coord.x >= 0 && coord.y >= 0 && coord.x < size.x && coord.y < size.y
#end

#region Функции получения карт

func exists(coord: Vector2i) -> bool:
	return take(coord) != null

func take(coord: Vector2i) -> Card:
		return field[xy_i(coord)]

func take1(coord: Vector2i)  -> Array[Card]: return [take(coord)]

func take4(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append(take(coord + Vector2i.UP))
	cards.append(take(coord + Vector2i.LEFT))
	cards.append(take(coord + Vector2i.RIGHT))
	cards.append(take(coord + Vector2i.DOWN))
	return cards

func take5(coord: Vector2i) -> Array[Card]:
	var cards := take4(coord)
	cards.append(take(coord))
	return cards

func takeX(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append(take(coord - Vector2i.ONE))
	cards.append(take(coord + C.MIR))
	cards.append(take(coord - C.MIR))
	cards.append(take(coord + Vector2i.ONE))
	return cards

func takeX1(coord: Vector2i) -> Array[Card]:
	var cards := takeX(coord)
	cards.append(take(coord))
	return cards

func take8(coord: Vector2i) -> Array[Card]:
	var cards: Array[Card] = []
	cards.append_array(takeX(coord))
	cards.append_array(take4(coord))
	return cards

func take9(coord: Vector2i) -> Array[Card]:
	var cards := take8(coord)
	cards.append(take(coord))
	return cards

func take_x(coord: Vector2i,  range_coord := -Vector2i.ONE) -> Array[Card]:
	var cards: Array[Card] = []
	if range_coord.x == -1:
		for i in size.x:
			var target_coord = C.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	else:
		for i in range(coord.x, range_coord.x):
			var target_coord = C.Vec2ixy(i, coord)
			cards.append(take(target_coord))
	return cards

func take_y(coord: Vector2i, range_coord := -Vector2i.ONE) -> Array[Card]:
	var cards: Array[Card] = []
	if range_coord.y == -1:
		for i in size.y:
			var target_coord = C.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	else:
		for i in range(coord.y, range_coord.y):
			var target_coord = C.Vec2ixy(coord, i)
			cards.append(take(target_coord))
	return cards

func take_diag_s(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - C.Vec2ixy(C.minc(coord))
	var final_coord = C.Vec2ixy(C.minc(size - first_coord))

	var target_coord = first_coord
	while  target_coord < final_coord:
		C.dv(target_coord, "target_coord")
		cards.append(take(target_coord))
		target_coord += Vector2i(1,1)
	return cards

func take_diag(coord: Vector2i) -> Array[int]:
	var cards: Array[int] = []
	# Находим ближайшую координату к краю поля
	# Что бы взять крайнюю ячейку
	var first_coord := coord - C.Vec2ixy(C.minc(coord))
	var final_coord = C.Vec2ixy(C.minc(size - first_coord - Vector2i.ONE))
	var _spread = C.mixc(first_coord, final_coord)
	var a = _spread[0]
	var b = _spread[1]
	
	var target_coord = a
	while  target_coord <= b:
		cards.append(take(target_coord))
		target_coord += C.MIR
	return cards

func take_rect(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]:
	return []

func take_romb(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]:
	return []

func take_cross(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []

func take_diagX(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []
	#var cards = take_romb(coord-Vector2i(length, length), coord).reverse()
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)))
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)).reverse())
	#cards.append_arraay(take_romb(coord, coord+Vector2i(length, length)))

func take_star(_coord: Vector2i, _length: int = 12) -> Array[Card]:
	return []

func take_field(deep: = false) -> Array[Card]:
		return field.duplicate(deep)

func replace(new_field: Array[Card]):
	field = new_field
#end
