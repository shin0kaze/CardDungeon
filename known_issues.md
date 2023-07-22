# Существующие проблемы и баги

### [GD Templates not working](https://docs.godotengine.org/en/stable/tutorials/scripting/creating_script_templates.html)

Решение: ну и нахер они нужны?

### Godot custom warnings

Решение: Использовать VS code или [@tool](https://www.youtube.com/watch?v=90XPxd2533c)

### [VScode-Godot debugger not working #389](https://github.com/godotengine/godot-vscode-plugin/issues/389#issuecomment-1302540744)

Решение:
Временно отключить use external editor, для написания кода использовать VScode, для дебага, Godot editor.

### [get_class() not return class_name #21789](https://github.com/godotengine/godot/issues/21789)

Решение:
Пока ждем пока они разведут это свойство на два (для базового типа, и пользовательского), храним значение в переменной. Можно парсить класс [Script](https://docs.godotengine.org/en/stable/classes/class_script.html#class-script-method-can-instantiate)

### [Godot code hint not working]()

Решение: Использовать VS code плагин godot-tools

### UID on node is missing

Решение: Добавлять переменную вручную, или воспользоваться [scene_file_path](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-property-scene-file-path)

### [#regions](https://github.com/godotengine/godot-proposals/issues/3366)

Решение: Vs code

### [Method overloading](https://github.com/godotengine/godot-proposals/issues/1571)

Решение: Написать диспатчер руками

### [Variadic functions](https://github.com/godotengine/godot-proposals/issues/1034)

Решение: использовать dictionary, и сопоставление аргументов. либо решение по ссылке.

### [Private/Protected](https://github.com/godotengine/godot-proposals/issues/641)

Решение: _перед_переменной.

### [Onready setter](https://github.com/godotengine/godot-proposals/issues/325)

Решение: отложенная/ленивая инициализация, возможно проверки, возможно сигналы

### [AnimTree -> Transition, no way to change Animation]

Решение: использовать set/get как в документации и не выебываться, оптимизатор хуев.

### [Double inheritance]

Решение: Ну можно вообще не писать me, годо сам нужные свойства подкинет в любом случае. Это больше нужно для хинтов.

### Yaml parsing

Решение: Ну мне пойдет любая тулза, и пользователи как нить разберуться сами json или yaml.

### inheritance from json

Решение: Для этого нужно создавать скрипты из json, и ноды по типу, [присваивать](https://docs.godotengine.org/en/stable/classes/class_script.html#class-script-method-reload) им эти скрипты, тем самым я смогу сделать полностью динамичный годо)) Либо отказаться от наследования и делать миксины/meta/dictionary.

### [Nullable static types](https://github.com/godotengine/godot-proposals/issues/162)
### [Description not showing in inspector #72952](https://github.com/godotengine/godot/issues/72952)
### [Trait, composition system](https://github.com/godotengine/godot-proposals/issues/6416)
### [Interfaces](https://github.com/godotengine/godot-proposals/issues/4872)
### [Types in loop](https://github.com/godotengine/godot-proposals/issues/632)
### [int | string union types](https://github.com/godotengine/godot-proposals/issues/737)
### [Set type](https://github.com/godotengine/godot-proposals/issues/867)
### [Signal typing hints](https://github.com/godotengine/godot-proposals/issues/2557)
### [?? null coalescing](https://github.com/godotengine/godot-proposals/issues/1321)
### [Tuples](https://github.com/godotengine/godot-proposals/issues/2944)
### [f "{sex}" strings](https://github.com/godotengine/godot-proposals/issues/157)
### [property signals](https://github.com/godotengine/godot-proposals/issues/4867)
### [Destructuring](https://github.com/godotengine/godot-proposals/issues/2135)
### [Structures](https://github.com/godotengine/godot-proposals/issues/7329)
### [Scene hints](https://github.com/godotengine/godot-proposals/issues/1935)
### [Differ node from script inheritance](https://www.reddit.com/r/godot/comments/cmrdvs/multiple_inheritance_in_godot/)


Ужас... повезет если к 2024 году хотя бы 1/8 реализуют.
