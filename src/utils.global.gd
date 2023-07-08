## Здесь лежат общие константы и функции
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

## Флаг если сцена главная
var _if_main := true
##
func if_main(scene: Node):
	if not _if_main: return false
	_if_main = false
	if not "UID" in scene: return false #OS.is_debug_build():
	if not ResourceUID.has_id(scene.UID): return false
	var id_path := ResourceUID.get_id_path(scene.UID)
	if OS.get_cmdline_args()[0] == id_path: return true
	return false

## Получить числовое представление resourceUID
func uid(uid: String):
	print(ResourceUID.text_to_id(uid))











