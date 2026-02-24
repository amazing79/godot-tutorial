extends Node

@export var main_menu_packed : PackedScene
@export var game_scene_packed : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_main_menu("game_start")


func load_main_menu(_origin:String) -> void:
	if _origin == "end_game_screen":
		get_node("MainScene").queue_free()
	
	var main_menu: Control = main_menu_packed.instantiate()
	main_menu.new_game_pressed.connect(new_game)
	main_menu.exit_pressed.connect(exit_game)
	main_menu.settings_pressed.connect(settings_open)
	main_menu.about_pressed.connect(about)
	add_child(main_menu)


func new_game(_origin: String) -> void:
	if _origin == "main_menu":
		get_node("MainMenu").queue_free()
	
	if _origin == "end_game_screen":
		get_node("MainScene").queue_free()
		await get_tree().process_frame
		
	var game_scene: Node2D = game_scene_packed.instantiate()
	add_child(game_scene)
	
	
func settings_open(_origin: String) -> void:
	pass


func about(_origin: String) -> void:
	pass
	

func exit_game(_origin: String) -> void:
	get_tree().quit()
	
