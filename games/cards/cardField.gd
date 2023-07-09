## Класс управляющий данными расположения карточек на поле
extends Node
class_name CardField

## Scene uid://b4t7kaa0jpwn
const UID: int = 131267092040567053
## Размер игрового поля x в ширину, y в высоту
var size: Vector2i = Vector2i(0,0)
## Массив содержащий в себе карточки на поле
var field: Array[Card] = []
var finder := CardFinder.new(size, field) #
var mover := MoveResolver.new(self)
var posConverter := PosConverter.new()
#end



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

func _ready():
	_if_main()



## Возвращает все поле
func take_field(deep: = false)->Array[Card]: return field.duplicate(deep)

## Заменяет поле на новое
func replace(new_field: Array[Card])->void: field = new_field
#end



func _if_main():
	if UTILS.if_main(self):
		var cards = Array()
		var card_res := load("uid://2drjjot2y0th")
		var size := Vector2i(3, 3)
		finder.size = size

		for i in range(MATH.v2iS(size)):
			var card:Card = card_res.instantiate()
			self.add_child(card)
			cards.append(card)
			card.position = posConverter.xy_pos(finder.i_xy(i), card.size())
			print(card.position)

		mover.add_move(Vector2i(0,0), Vector2i(0,1), true)
		mover.add_move(Vector2i(1,0), Vector2i(1,1), false)
