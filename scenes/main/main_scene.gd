extends Node2D

signal levelup

@export var end_game_screen_packed: PackedScene

var total_enemies: int
var killed_enemies = 0

@onready var HUD : Control = $UI/HUD

func _ready() -> void:
	var enemy_array: Array = get_tree().get_nodes_in_group('enemies')
	total_enemies = enemy_array.size()
	for i in enemy_array:
		i.died.connect(enemy_died)
	
	var player : CharacterBody2D = get_tree().get_first_node_in_group('player')
	levelup.connect(player.calculate_stats)
	player.game_over.connect(display_end_game_screen)
	player.update_hp_bar.connect(HUD.update_hp_bar)
	

func enemy_died(exp_rewad:int) -> void:
	killed_enemies += 1
	experience_gained(exp_rewad)
	if killed_enemies == total_enemies:
		display_end_game_screen(true)


func experience_gained(exp_gain:int) -> void:
	if PlayerData.level == LevelData.MAX_LEVEL:
		return
	var new_exp : int = PlayerData.experience + exp_gain
	if new_exp > LevelData.level_thresholds[PlayerData.level - 1]:
		level_up(new_exp)
	else:
		PlayerData.experience = new_exp
		

func level_up(new_experience:int) -> void:
	print('I have the power')
	new_experience -= LevelData.level_thresholds[PlayerData.level - 1 ]
	PlayerData.level += 1
	PlayerData.experience = new_experience
	levelup.emit()
	HUD.update_level_indicator()

func display_end_game_screen(victorius:bool) -> void:
	var end_game_screen: Control = end_game_screen_packed.instantiate()
	end_game_screen.victorius = victorius
	
	var scene_handler : Node = get_node("/root/SceneHandler")
	
	end_game_screen.repeat_level.connect(scene_handler.new_game)
	end_game_screen.main_menu.connect(scene_handler.load_main_menu)
	$UI.add_child(end_game_screen)
	
	await get_tree().create_timer(0.4).timeout
	var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
	player.set_process_mode(Node.PROCESS_MODE_DISABLED)
	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	for i: CharacterBody2D in enemies:
		i.set_process_mode(Node.PROCESS_MODE_DISABLED)
		
