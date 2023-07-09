## Здесь лежат самые частоиспользуемые или дебаг функции
extends Node



## Значение для дебага по умолчанию
var DBG_PRINT := true



## Выводит значение параметра если включен режим дебага
func dv(v, msg: String = "your variable", enabled := true):
	if DBG_PRINT && enabled:
		print("val of " + msg + " is " + str(v))

## Выводит на экран длинное сообщение разделитель
func dd(enabled := true):
	if DBG_PRINT && enabled:
		print("============| Delimiter |============")

## Выводит сообщение если включен режим дебага
func dm(msg: String = "down_here!", enabled := true):
	if DBG_PRINT && enabled:
		print(msg)

## Получить числовое представление resourceUID
func uid(uid: String):
	print(ResourceUID.text_to_id(uid))

