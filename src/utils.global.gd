## Здесь лежат общие константы и функции
extends Node



## Флаг если сцена главная
var _if_main := true
## Если запуск отдельной сцены
func if_main(scene: Node):
	if not _if_main: return false
	_if_main = false
	if not "UID" in scene: return false #OS.is_debug_build():
	if not ResourceUID.has_id(scene.UID): return false
	var id_path := ResourceUID.get_id_path(scene.UID)
	if OS.get_cmdline_args()[0] == id_path: return true
	return false
