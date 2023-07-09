## Инструмент для всяких преобразований
@tool
extends Node

## Сконвертировать UID
@export var uid_str: String
@export var convert_uid_button: bool = false:
	set(_value):
		convert_uid()
@export var uid_str_result: String

func convert_uid():
	print(ResourceUID.text_to_id(uid_str))
	uid_str_result = str(ResourceUID.text_to_id(uid_str))
