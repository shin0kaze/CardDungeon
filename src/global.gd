## Здесь лежат самые частоиспользуемые или дебаг функции
extends Node



## Значение для дебага по умолчанию
var DBG_PRINT := true



## Выводит значение параметра если включен режим дебага DebugVariable
func dv(v, msg: String = "your variable", enabled := 1):
	if DBG_PRINT && enabled:
		print("val of " + msg + " is " + str(v))

## Выводит на экран длинное сообщение разделитель DebugDelimiter
func dd(enabled := 1):
	if DBG_PRINT && enabled:
		print("============| Delimiter |============")

## Выводит сообщение если включен режим дебага DebugMessage
func dm(msg: String = "down_here!", enabled := 1):
	if DBG_PRINT && enabled:
		print(msg)

## Получить числовое представление resourceUID
func uid(uid: String):
	print(ResourceUID.text_to_id(uid))

## Получает все члены класса GetALlmembers
func gal(class_instance):
	var output = {}
	var methods = []
	for method in class_instance.get_method_list():
		methods.append(method.name)
	output[S.Funcs] = methods

	var properties = []
	for prop in class_instance.get_property_list():
		# Eh??? Ля видимо, что то с++ное
		if prop.type == 3:
			properties.append(prop.name)
	output[S.Props] = properties

	return output

## Получаем тип любой переменное
func wtf(any_var):
	any_var.get_class()
	typeof(any_var)
