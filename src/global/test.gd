extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var node = $Node
	node.add_scan_directory("res://directory")
	node.files_created.connect(on_files_created)
	node.files_modified.connect(on_files_modified)
	node.files_deleted.connect(on_files_deleted)
	var watcher = node.get_script()
	node.add_scan_directoryy("res://directory")
	
	#var watcher = Watcher.new()
#	watcher.add_scan_directory("res://directory")
#	watcher.files_created.connect(on_files_created)
#	watcher.files_modified.connect(on_files_modified)
#	watcher.files_deleted.connect(on_files_deleted)
	print('watch')

func _notification(what):
	if what == MainLoop.NOTIFICATION_CRASH:
		print("oops")

func on_files_created(files):
	print(files)
func on_files_modified(files):
	print(files)
func on_files_deleted(files):
	print(files)

