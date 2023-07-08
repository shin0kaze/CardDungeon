## Класс управляющий данными расположения карточек на поле
extends Node
class_name CardField

#region Свойства класса

## Размер игрового поля x в ширину, y в высоту
var size: Vector2i = Vector2i(0,0)
## Массив содержащий в себе карточки на поле
var field: Array[Card] = []
var finder := CardFinder.new(size, field) #
var moveResolver := MoveResolver.new(self)
var posConverter := PosConverter.new()
#end

#region Конструкторы и функции жизненного цикла

## Инициализирует поле указанного размера
func init(size_of_field: Vector2i) -> void:
	size = size_of_field
	field.resize(size.x * size.y)

## Заполняет поле картами
func fill(cards: Array) -> void:
	var i = 0
	for card in cards.size():
		field[i] = cards[i]

## Инициализирует поле указанного размера, и заполняет его картами
func init_fill(size_of_field: Vector2i, cards: Array) -> void:
	init(size_of_field)
	fill(cards)

#endregion

## Преобразует индекс в координаты
func i_xy(length: int) -> Vector2i: return finder.i_xy(length)

## Преобразует координаты в индекс
func xy_i(coord: Vector2i) -> int: return finder.xy_i(coord)

## Сравнивает что координата x не выходит за поле
func in_range_x(coord: Vector2i) -> bool: return finder.in_range_x(coord)

## Сравнивает что координата y не выходит за поле
func in_range_y(coord: Vector2i) -> bool: return finder.in_range_y(coord)

## Сравнивает что координаты не выходят за поле
func in_range(coord: Vector2i) -> bool: return finder.in_range(coord)
#end

#region Функции получения карт

## Проверяет наличие карты
func exists(coord: Vector2i) -> bool: return finder.exists(coord)

## Возвращает карту, или null, если такого объекта нет
func take(coord: Vector2i) -> Card: return finder.take(coord)

## Возвращает карту обернутую в массив, или null, если такого объекта нет
func take1(coord: Vector2i) -> Array[Card]: return finder.take1(coord)

## Возвращает соседние карты в четырех основных направлениях
func take4(coord: Vector2i) -> Array[Card]: return finder.take4(coord)

## Возвращает соседние карты в четырех основных направлениях,
## а также карту по координатам
func take5(coord: Vector2i) -> Array[Card]: return finder.take5(coord)

## Возвращает соседние карты по диагонали
func takeX(coord: Vector2i) -> Array[Card]: return finder.takeX(coord)

## Возвращает соседние карты по диагонали, а также карту по координатам
func takeX1(coord: Vector2i) -> Array[Card]: return finder.takeX1(coord)

## Возвращает все соседние карты по часовой стрелке начиная с левой верхней
func take8(coord: Vector2i) -> Array[Card]: return finder.take8(coord)

## Возращает массив карт 3*3, coord указывает на центр
func take9(coord: Vector2i) -> Array[Card]: return finder.take9(coord)

## Возвращает строку из карт
## Если 1 параметр, берет всю строку, если 2, от coord.x до range_coord.x
func take_x(coord: Vector2i,  range_coord := -Vector2i.ONE) -> Array[Card]: return finder.take_x(coord, range_coord)

## Возвращает столбец из карт
## Если 1 параметр, берет весь столбец, если 2, от coord.y до range_coord.y
func take_y(coord: Vector2i, range_coord := -Vector2i.ONE) -> Array[Card]: return finder.take_y(coord, range_coord)

## Возвращает массив карт по основной диагонали
func take_diag(coord: Vector2i) -> Array[int]: return finder.take_diag(coord)

## Возвращает массив карт по основной диагонали
func take_diag_s(coord: Vector2i) -> Array[int]: return finder.take_diag_s(coord)

# Возращает массив карт в виде прямоугольника, необходимо указать
# верхний левый угол и правый нижний
func take_rect(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]: return []
# Возращает массив карт в виде ромба, необходимо указать
# верхнюю вершину фигуры и нижнюю
func take_romb(_coord_high: Vector2i, _coord_low: Vector2i) -> Array[Card]: return []

## Возвращает массив карт в четырех основных направлениях с указанной длинной
func take_cross(_coord: Vector2i, _length: int = 12) -> Array[Card]: return []

# Возвращает массив карт в четырех диагональных направлениях с указанной длинной
func take_diagX(_coord: Vector2i, _length: int = 12) -> Array[Card]: return []

# Возращает массив карт в восьми направлениях с указанной длинной
func take_star(_coord: Vector2i, _length: int = 12) -> Array[Card]: return []

## Возвращает все поле
func take_field(deep: = false)->Array[Card]: return field.duplicate(deep)

## Заменяет поле на новое
func replace(new_field: Array[Card])->void: field = new_field
#end

## Добавляет карты на поле
func add_move(cur_coord: Vector2i, tar_coord: Vector2i, swap_mode: bool) -> void: return moveResolver.add_move(cur_coord, tar_coord, swap_mode)

func _ready():
	var cardi = load("uid://2drjjot2y0th")
	if C.if_main(self):
		# var n = CodeRunner.new()
		# self.add_child(n)
		var size := Vector2i(3, 3)
		finder.size = size
		var cards = Array()
		for i in range(size.x * size.y):
			var card:Card = cardi.instantiate()
			card.position = posConverter.xy_pos(i_xy(i))
			print(card.position)
			cards.append(card)
			self.add_child(card)

